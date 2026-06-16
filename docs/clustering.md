<!-- SPDX-License-Identifier: AGPL-3.0-or-later -->

# Clustering Operations: CHF

**Applies to:** chf 0.1.0 and later · **Revised:** 2026-06-16

## 1. Scope

This document covers the operational procedures for running Next-CHF in a
multi-node cluster: forming a cluster, understanding quorum requirements,
handling network partitions, adding and removing nodes, and known limitations.
For tunable parameters (`cluster_nodes`, `cluster_unique_origin_host`) see
[configuration.md](configuration.md).

## 2. Background

The clustering layer (`chf_cluster`) manages static-list membership and
strict-majority quorum. Clustered Mnesia (`disc_copies` replicated across all
nodes) provides distributed transactions that prevent double-spend across nodes.
One global sweeper (`chf_session_sweeper`) is elected cluster-wide via
`:global`; it fails over automatically on node loss.

## 3. Forming a cluster

### 3.1 Prerequisites

All nodes must:

- Run the same `next-chf` release.
- Share the same Erlang cookie (`-setcookie` in `config/vm.args`).
- Have unique node names (`-name` or `-sname` in `config/vm.args`).
- Be mutually reachable at the Erlang distribution level (EPMD port 4369 and
  the dynamic distribution port range must be open between all nodes).

### 3.2 Configuration

Set the `cluster_nodes` list identically on every node in `config/sys.config`:

```erlang
{chf, [
    {cluster_nodes, ['chf@10.0.0.1', 'chf@10.0.0.2', 'chf@10.0.0.3']}
  ]},
```

The list must include all nodes, including the node on which `sys.config`
resides (the code always union-inserts the local node, so omitting self is
harmless but inconsistent).

Each node's `config/vm.args` must carry a matching node name:

```
-name chf@10.0.0.1
-setcookie my-shared-cookie
```

> [!IMPORTANT]
> Every node must carry the **same** `cluster_nodes` list. A node that lists
> only a subset of peers forms an independent view of quorum and may make
> incorrect majority decisions.

### 3.3 Cold-start ordering

Bring up one **seed node** first and wait for it to reach healthy Mnesia before
starting the others:

1. Start `chf@10.0.0.1` (seed). The node creates the Mnesia schema and all
   tables (`subscriber`, `balance`, `cdr`, `charging_session`) as `disc_copies`
   on itself.
2. Once the seed node logs `mnesia: system running`, start `chf@10.0.0.2`.
   Its `chf_db_mnesia:init/1` pings the seed, merges the schema via
   `mnesia:change_config(extra_db_nodes, ...)`, and adds local `disc_copies`
   replicas via `mnesia:add_table_copy`.
3. Repeat for `chf@10.0.0.3` and any further nodes.

> [!WARNING]
> If all nodes cold-start simultaneously on an empty cluster, two nodes can
> each see the other's VM yet complete `mnesia:change_config` independently
> and seed disjoint schemas (permanently diverged data). This is a known
> limitation of the phase-2 implementation; a future phase will add automatic
> seed election. For now, production boot **must** be serialised: seed first,
> then followers.

## 4. Quorum requirement

The CHF enforces a **strict majority** quorum: a node must be able to see more
than half of the configured cluster nodes.

```
connected * 2 > total
```

Practical implications:

| Cluster size | Nodes that may fail without losing quorum |
| --- | --- |
| 1 | 0 (not HA; single point of failure) |
| 2 | 0 (any single failure removes majority — **not recommended for HA**) |
| 3 | 1 |
| 5 | 2 |

A **2-node cluster** has no majority on a split and is NOT recommended for HA
charging. If you have only two charging-grade nodes, add a lightweight **witness
node**: a node running `chf_cluster` (and Mnesia, for schema consistency) but
carrying no charging traffic — it participates in membership and quorum without
handling user traffic.

## 5. Minority behaviour (fail-closed)

A node that cannot see a strict majority of its configured peers declares
itself out of quorum and refuses all charging operations:

- **DIAMETER (Gy/Rf):** CCR and ACR requests receive a CCA/ACA with
  Result-Code `3004 DIAMETER_TOO_BUSY`. No balance is read or mutated.
- **5G SBI (Nchf):** All `POST` requests to the converged-charging and
  offline-only-charging endpoints return `503 Service Unavailable`. No
  balance is read or mutated.
- **Provisioning API and Web UI:** Unaffected — they are served by `chf_api`
  and `chf_web` which do not check quorum.

The majority partition continues to charge normally. No balance mutations
occur on the minority side, so there is no risk of double-spend across the
partition.

Quorum is re-evaluated after every `nodeup` and `nodedown` event. If a
minority node regains connectivity to the majority, it resumes charging within
one event cycle.

## 6. Partition-heal procedure

Because the minority wrote nothing during the partition, recovery is clean:

1. Identify the majority partition (the side that continued charging).
2. Restart each minority node so its Mnesia reloads table data from the
   majority. The `chf_db_mnesia:init/1` boot sequence pings peers and merges
   from the first reachable majority node.
3. Verify that `mnesia:table_info(balance, disc_copies)` on any surviving node
   now includes all cluster nodes.

> [!WARNING]
> Mnesia logs `inconsistent_database` when it detects a partition and does
> **not** auto-merge. Do **not** force-load minority tables with
> `mnesia:set_master_nodes/2` or `force_load` pointing at minority nodes —
> that would overwrite the majority's data with stale values. Always recover
> by restarting minority nodes so they join and replicate from the majority.

## 7. Node join and leave

### 7.1 Joining a node

Boot the new node with the shared `cluster_nodes` list (which already contains
it). On start, `chf_db_mnesia:init/1` pings the existing nodes, merges their
Mnesia schema, and adds `disc_copies` replicas for all four tables. No manual
steps are required.

### 7.2 Removing a node gracefully

1. Stop the node: `_build/default/rel/next-chf/bin/next-chf stop`.
2. From any surviving node's Erlang shell, remove its Mnesia replicas:

```erlang
NodeToRemove = 'chf@10.0.0.3'.
Tables = [subscriber, balance, cdr, charging_session].
[mnesia:del_table_copy(T, NodeToRemove) || T <- Tables].
mnesia:del_table_copy(schema, NodeToRemove).
```

3. Update `cluster_nodes` in `sys.config` on all remaining nodes to remove the
   departed node, then do a rolling restart so each node reloads its config.

> [!NOTE]
> If you skip step 2, the surviving nodes will log Mnesia warnings about an
> unreachable `disc_copies` replica and wait for it to come back before
> allowing schema changes. This does not affect charging but generates
> persistent log noise.

## 8. Testing reference

Multi-node cluster tests live in
`apps/chf_db/test/chf_cluster_SUITE.erl`.

- `cluster` group: 2-node tests covering `disc_copies` replication, distributed
  no-double-spend transactions, `:global` singleton sweeper, and sweeper
  takeover on node loss.
- `cluster3` group: 3-node test confirming that a node placed in a minority
  partition refuses charging while the majority continues.

The cluster groups are excluded from the default `rebar3 ct` path (they require
peer node setup and longer runtimes). Run them explicitly when validating
cluster logic:

```sh
rebar3 ct --suite apps/chf_db/test/chf_cluster_SUITE --group cluster
rebar3 ct --suite apps/chf_db/test/chf_cluster_SUITE --group cluster3
```

## 9. Known limitations and future work

**Cold-start split-brain:** If all nodes boot simultaneously from empty, each
may self-seed an independent Mnesia schema. Quorum gates runtime charging but
not cold-start schema formation. Production mitigation: start the seed node
first (see Section 3.3). Automatic seed election is future work.

**Real nodedown-triggered charge-refusal test:** The automatic
`{nodedown} → refresh_quorum` transition is covered by the sweeper-takeover
test, and charging-fails-closed is covered by `minority_refuses_to_charge`.
However, there is no single test that asserts a charge refusal driven by a real
`nodedown`-triggered quorum drop on the surviving minority node. The difficulty
is that a killed peer cannot itself call `session_initial` to be refused; the
test must keep the peer alive but isolated, which is done in the `cluster3` test
by overriding `cluster_nodes` + calling `refresh_quorum/0` explicitly rather
than by killing the peer. A future test could use a 4-node cluster where a
surviving minority node (that has not been killed) refuses after the majority
partition is cut. This is tracked as future work.
