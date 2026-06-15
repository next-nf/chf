<!-- SPDX-License-Identifier: AGPL-3.0-or-later -->

# Configuration Reference: CHF

**Applies to:** chf 0.1.0 and later · **Revised:** 2026-06-15

## 1. Scope

This document covers every operator-tunable parameter and every network listener
for the CHF (Combined Charging Function) umbrella application. The CHF comprises
seven OTP applications — `chf_db`, `chf_core`, `chf_diameter`, `chf_sbi`,
`chf_api`, `chf_web`, and `chf` — each with its own configuration key in
`config/sys.config`. Observability settings (OpenTelemetry SDK and exporter) are
also covered here.

Out of scope: the content and semantics of individual metrics are documented in
[`METRICS.md`](../METRICS.md). Interface contracts (DIAMETER Gy/Rf message
formats, 5G SBI Nchf operations, provisioning REST API) are covered in separate
interface-reference documents.

## 2. Terms

- **CHF** — Combined Charging Function; the node implementing this software.
  Combines the role of OCS (Online Charging System) and OFCS (Offline Charging
  System) as defined in 3GPP TS 32.290.
- **OCS** — Online Charging System; provides credit-based real-time charging.
- **OFCS** — Offline Charging System; records usage for post-processing.
- **Gy / Ro** — DIAMETER credit-control interface between an SMF/PCEF and an
  OCS. The CHF acts as the DIAMETER server on this interface.
- **Rf** — DIAMETER offline charging interface between a network element and an
  OFCS. The CHF acts as the DIAMETER server on this interface.
- **Nchf** — 5G Service-Based Interface exposing `Nchf_ConvergedCharging` and
  `Nchf_OfflineOnlyCharging` as defined in 3GPP TS 32.291.
- **SBI** — Service-Based Interface; HTTP/2 REST interface used in 5G SA.
- **IMSI** — International Mobile Subscriber Identity.
- **RatingGroup** — a numeric identifier grouping traffic flows for charging
  purposes (3GPP TS 32.299).
- **DiameterIdentity** — a Fully-Qualified Domain Name used as a DIAMETER node
  identity (RFC 6733).
- **OTLP** — OpenTelemetry Protocol; used to export traces and metrics.
- **micro-unit** — the internal unit for all balance amounts; one micro-unit
  equals 10⁻⁶ of the denomination (e.g. one micro-credit).

## 3. Where configuration lives

All runtime configuration is in `config/sys.config` at the repository root. This
file is read at boot by both `rebar3 shell` and a built release
(`_build/default/rel/next-chf/bin/next-chf foreground`). Parameters not
explicitly present in `sys.config` fall back to the code-level defaults listed
in Section 4.

The file is structured as a list of `{Application, Parameters}` tuples:

```erlang
[{chf_db, [
    {backend, chf_db_mnesia}
  ]},

 {chf_core, [
    {session_idle_timeout, 300000}
  ]},

 {chf_diameter, [
    {origin_host,  "chf.epc.mnc001.mcc001.3gppnetwork.org"},
    {origin_realm, "epc.mnc001.mcc001.3gppnetwork.org"},
    {listen, [{tcp, {127,0,0,1}, 3868}]}
  ]},

 {chf_sbi, [
    {port, 8443},
    {ip, {127,0,0,1}}
  ]},

 {chf_api, [
    {port, 8080},
    {ip, {127,0,0,1}}
  ]},

 {chf_web, [
    {port, 8081},
    {ip, {127,0,0,1}}
  ]},

 {opentelemetry, [
    {span_processor, batch},
    {traces_exporter, none},
    {resource, #{service => #{name => <<"chf">>}}}
  ]},

 {opentelemetry_exporter, [
    {otlp_protocol, http_protobuf},
    {otlp_endpoint, "http://localhost:4318"}
  ]},

 {opentelemetry_experimental, [
    {readers, [
      #{module => otel_metric_reader,
        config => #{exporter => {opentelemetry_exporter, #{}},
                    export_interval_ms => 10000}},
      #{module => otel_metric_reader_prometheus,
        config => #{server_name => otel_prometheus_reader}}
    ]}
  ]}
].
```

## 4. Parameter reference

### 4.1 Ports and listeners

The following table summarises every network listener. All listeners default to
loopback (`127.0.0.1`).

> [!IMPORTANT]
> Every listener defaults to `127.0.0.1`. An operator who needs external
> connectivity (e.g. from an SMF, AMF, or monitoring system on a separate host)
> `shall` change the `ip` (or `listen`) parameter to a routable address before
> deployment.

| Port | Protocol | Application | Purpose | Default bind address |
| --- | --- | --- | --- | --- |
| 3868 | TCP (DIAMETER) | `chf_diameter` | DIAMETER Gy (Ro) + Rf server for 4G charging | `127.0.0.1` |
| 8443 | HTTP (Cowboy) | `chf_sbi` | 5G Nchf SBI — `Nchf_ConvergedCharging` and `Nchf_OfflineOnlyCharging` | `127.0.0.1` |
| 8080 | HTTP (Cowboy) | `chf_api` | Provisioning REST API — subscriber CRUD, balance management | `127.0.0.1` |
| 8081 | HTTP (Cowboy) | `chf_web` | Web management UI; `GET /metrics` Prometheus pull endpoint | `127.0.0.1` |
| 4318 | HTTP (outbound) | `opentelemetry_exporter` | OTLP push target for traces and metrics | `localhost` (outbound) |

### 4.2 `chf_db` parameters

| Parameter | Type | Default | Allowed values | Unit | Description | Effect | Since |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `backend` | atom | `chf_db_mnesia` | `chf_db_mnesia` | — | Selects the DB backend module. The module is resolved at startup and cached in `persistent_term`. | Determines which implementation handles all subscriber, balance, CDR, and session operations. | 0.1.0 |
| `backend_opts` | map | `#{}` | any map | — | Opaque options passed to the backend's `init/1` callback. The Mnesia backend ignores this key; it is reserved for future backends. | Backend-specific initialisation behaviour. | 0.1.0 |

### 4.3 `chf_core` parameters

| Parameter | Type | Default | Allowed values | Unit | Description | Effect | Since |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `session_idle_timeout` | integer | `300000` | 1 – 2<sup>31</sup>−1 | ms | Maximum time a charging session may remain active with no update. The session sweeper terminates sessions that exceed this age. | Directly controls the maximum session lifetime after the last CCR or Nchf request. Setting a smaller value reclaims reserved balance sooner; setting a larger value tolerates longer gaps between UE updates. | 0.1.0 |
| `sweep_interval` | integer | `60000` | 1 – 2<sup>31</sup>−1 | ms | How often `chf_session_sweeper` scans for stale sessions. | Controls the granularity of idle-session detection. The maximum additional latency before a timed-out session is reaped is one `sweep_interval`. | 0.1.0 |

> [!NOTE]
> `sweep_interval` is not present in the default `sys.config`; the code default
> of 60 000 ms (1 minute) applies unless the key is added.

### 4.4 `chf_diameter` parameters

| Parameter | Type | Default | Allowed values | Unit | Description | Effect | Since |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `origin_host` | string | `"chf.local"` | any DiameterIdentity (FQDN) | — | DIAMETER identity this node presents to peers in the Origin-Host AVP of every message. | Peers match this against their configured Destination-Host or Origin-Host allowlists. | 0.1.0 |
| `origin_realm` | string | `"local"` | any DIAMETER realm (FQDN) | — | DIAMETER realm this node belongs to, carried in Origin-Realm AVP. | Used for realm-based routing by DIAMETER peers. | 0.1.0 |
| `listen` | list of `{tcp, ip4_address, port}` | `[{tcp,{0,0,0,0},3868}]` | one or more listener tuples | port | Transport endpoints the DIAMETER service binds. | Determines which addresses and ports accept inbound DIAMETER connections from peers (SMF, PCEF). | 0.1.0 |

> [!NOTE]
> The code-level default for `listen` is `[{tcp,{0,0,0,0},3868}]` (all
> interfaces). The `sys.config` shipped in the repository overrides this to
> `[{tcp,{127,0,0,1},3868}]` (loopback only) for a safe out-of-the-box
> experience. Operators `should` set an explicit routable address rather than
> binding to `{0,0,0,0}` in production.

### 4.5 `chf_sbi` parameters

| Parameter | Type | Default | Allowed values | Unit | Description | Effect | Since |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `port` | integer | `8443` | 1–65535 | port | TCP port the Nchf SBI HTTP listener binds. | Determines the port on which 5G SBI clients (AMF, SMF) connect. | 0.1.0 |
| `ip` | ip4_address (4-tuple) | `{127,0,0,1}` | any valid IPv4 address | — | IP address the Nchf SBI listener binds. | Determines which network interface accepts SBI connections. | 0.1.0 |

### 4.6 `chf_api` parameters

| Parameter | Type | Default | Allowed values | Unit | Description | Effect | Since |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `port` | integer | `8080` | 1–65535 | port | TCP port the provisioning REST API listener binds. | Determines the port on which operators and provisioning systems connect. | 0.1.0 |
| `ip` | ip4_address (4-tuple) | `{127,0,0,1}` | any valid IPv4 address | — | IP address the provisioning API listener binds. | Determines which network interface accepts provisioning connections. | 0.1.0 |

### 4.7 `chf_web` parameters

| Parameter | Type | Default | Allowed values | Unit | Description | Effect | Since |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `port` | integer | `8081` | 1–65535 | port | TCP port the web UI and metrics listener binds. | Determines the port on which the management dashboard and the Prometheus scrape endpoint (`GET /metrics`) are accessible. | 0.1.0 |
| `ip` | ip4_address (4-tuple) | `{127,0,0,1}` | any valid IPv4 address | — | IP address the web UI listener binds. | Determines which network interface accepts connections to the dashboard and metrics endpoint. | 0.1.0 |

### 4.8 `opentelemetry` parameters

| Parameter | Type | Default | Allowed values | Unit | Description | Effect | Since |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `span_processor` | atom | `batch` | `batch`, `simple` | — | Span processor used by the OTel SDK. `batch` buffers and exports spans in batches; `simple` exports each span synchronously. | `batch` reduces per-request latency overhead; `simple` is useful for debugging but adds latency to every request. | 0.1.0 |
| `traces_exporter` | atom | `none` | `none`, `otlp` | — | Exporter for distributed traces. `none` disables trace export; `otlp` exports via the endpoint configured in `opentelemetry_exporter`. | When `none`, no trace data is sent to the collector; spans are still created and can be inspected in-process. | 0.1.0 |
| `resource` | map | `#{service => #{name => <<"chf">>}}` | an OTel resource map | — | Resource attributes attached to every span and metric. The `service.name` attribute identifies this node in a collector or UI. | All exported telemetry carries these attributes; changing `service.name` affects how the data appears in Jaeger, Grafana, and similar tools. | 0.1.0 |

### 4.9 `opentelemetry_exporter` parameters

| Parameter | Type | Default | Allowed values | Unit | Description | Effect | Since |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `otlp_protocol` | atom | `http_protobuf` | `http_protobuf`, `grpc` | — | Wire protocol used to push telemetry to the OTLP collector. | Determines the serialisation format and transport used for export. | 0.1.0 |
| `otlp_endpoint` | string | `"http://localhost:4318"` | any HTTP or HTTPS URL | — | Base URL of the OTLP collector to which traces and metrics are pushed. The exporter appends `/v1/traces` or `/v1/metrics` as appropriate. | All OTLP push export goes to this address. Change this to point at a local collector sidecar (e.g. OpenTelemetry Collector) or a hosted endpoint (e.g. Grafana Cloud). | 0.1.0 |

### 4.10 `opentelemetry_experimental` metric readers

Two metric readers are configured. Both are specified under the `readers` key:

| Reader module | Mode | Key config | Description | Since |
| --- | --- | --- | --- | --- |
| `otel_metric_reader` | Push (OTLP) | `export_interval_ms => 10000` | Periodically exports all accumulated metrics to the OTLP endpoint configured in `opentelemetry_exporter`. | 0.1.0 |
| `otel_metric_reader_prometheus` | Pull (Prometheus) | `server_name => otel_prometheus_reader` | Exposes metrics at `GET /metrics` on the `chf_web` listener (port 8081) for Prometheus scraping. | 0.1.0 |

| Sub-parameter | Type | Default | Allowed values | Unit | Description | Effect | Since |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `export_interval_ms` | integer | `10000` | 1 – 2<sup>31</sup>−1 | ms | How often the OTLP push reader exports metric data to the collector. | Shorter intervals increase collector ingestion load and network traffic; longer intervals increase the staleness of metrics at the collector. | 0.1.0 |
| `server_name` | atom | `otel_prometheus_reader` | any atom | — | Internal name of the Prometheus reader process. Changing this `shall` also update any internal routing that references the process by name; operators `should` leave this at the default. | Controls the registered name of the pull reader; the `chf_web` metrics handler resolves it by this name. | 0.1.0 |

## 5. Parameter detail

### 5.1 `chf_core`: `session_idle_timeout` and `sweep_interval`

These two parameters interact. A session is declared stale when it has been
active for longer than `session_idle_timeout` milliseconds with no
`session_update` or `session_terminate` call. The sweeper checks for stale
sessions every `sweep_interval` milliseconds.

- The maximum time a stale session continues to hold reserved balance is
  `session_idle_timeout + sweep_interval`.
- `session_idle_timeout` `shall` be greater than the longest expected gap
  between CCR-Update messages from any peer. Setting it shorter than the peer's
  update interval causes premature session termination and refund of granted
  units.
- `sweep_interval` `should` be set to no more than one-tenth of
  `session_idle_timeout` to keep reaping latency proportionally small.

### 5.2 `chf_diameter`: `origin_host` and `origin_realm`

- `origin_host` `should` be a fully-qualified domain name in the operator's
  realm, following the form
  `chf<N>.<domain>` (e.g. `chf01.epc.mnc001.mcc001.3gppnetwork.org`).
- `origin_realm` `shall` match the realm portion of `origin_host`.
- When multiple CHF instances are deployed, each `shall` have a unique
  `origin_host`. Sharing an `origin_host` between nodes causes DIAMETER
  routing ambiguity and peer connection failures.

### 5.3 `chf_diameter`: `listen`

Each entry in `listen` is `{tcp, IpV4Address, Port}`. The list may contain
more than one entry to bind on multiple addresses or ports.

- When a DIAMETER peer (SMF, PCEF) resides on a separate host, the listener
  `shall` include at least one entry bound to a routable address; an entry
  bound solely to `{127,0,0,1}` `shall not` be used in that case.
- The registered DIAMETER port is `3868`. A non-standard port `may` be used
  provided the peer is configured to connect on the same port.

> [!WARNING]
> Binding to `{0,0,0,0}` exposes the DIAMETER server on all interfaces,
> including any management or external network interface. Operators `should`
> bind to the specific interface that faces DIAMETER peers.

### 5.4 Listeners: binding to non-loopback addresses

All HTTP listeners (`chf_sbi`, `chf_api`, `chf_web`) accept an `ip` tuple of
the form `{A, B, C, D}` (Erlang's IPv4 tuple notation). To bind on all
interfaces, use `{0,0,0,0}`.

- The `chf_api` and `chf_web` listeners `should` be bound to an address that
  is reachable from the operator's provisioning and monitoring networks, but
  `should not` be exposed to the UE-facing data network.
- The `chf_sbi` listener `shall` be reachable from the AMF and SMF nodes that
  issue Nchf requests.

### 5.5 `opentelemetry_exporter`: `otlp_endpoint`

The OTLP exporter appends path suffixes automatically:

- Traces: `<otlp_endpoint>/v1/traces`
- Metrics: `<otlp_endpoint>/v1/metrics`

Operators `shall` point `otlp_endpoint` at an OTLP-compatible receiver. When
`traces_exporter` is `none`, trace data is not exported regardless of this
setting. Metric export (via `otel_metric_reader`) is independent of
`traces_exporter` and proceeds whenever the reader is configured.

> [!TIP]
> Running an OpenTelemetry Collector sidecar on `localhost:4318` is the
> recommended deployment pattern. The Collector can then fan out to Jaeger
> (traces), Prometheus remote-write, or a managed observability backend.

## 6. Example

### 6.1 Production deployment on a dedicated EPC subnet

This configuration binds all listeners to a routable address (`10.0.1.5`),
enables OTLP trace export to a local collector, and uses a 10-minute session
idle timeout:

```erlang
[{chf_db, [
    {backend, chf_db_mnesia}
  ]},

 {chf_core, [
    {session_idle_timeout, 600000},   %% 10 minutes
    {sweep_interval, 60000}           %% 1 minute
  ]},

 {chf_diameter, [
    {origin_host,  "chf01.epc.mnc001.mcc001.3gppnetwork.org"},
    {origin_realm, "epc.mnc001.mcc001.3gppnetwork.org"},
    {listen, [{tcp, {10,0,1,5}, 3868}]}
  ]},

 {chf_sbi, [
    {port, 8443},
    {ip, {10,0,1,5}}
  ]},

 {chf_api, [
    {port, 8080},
    {ip, {10,0,1,5}}
  ]},

 {chf_web, [
    {port, 8081},
    {ip, {10,0,1,5}}
  ]},

 {opentelemetry, [
    {span_processor, batch},
    {traces_exporter, otlp},
    {resource, #{service => #{name => <<"chf01">>}}}
  ]},

 {opentelemetry_exporter, [
    {otlp_protocol, http_protobuf},
    {otlp_endpoint, "http://localhost:4318"}
  ]},

 {opentelemetry_experimental, [
    {readers, [
      #{module => otel_metric_reader,
        config => #{exporter => {opentelemetry_exporter, #{}},
                    export_interval_ms => 10000}},
      #{module => otel_metric_reader_prometheus,
        config => #{server_name => otel_prometheus_reader}}
    ]}
  ]}
].
```

This configuration binds all four listeners to `10.0.1.5`, enables trace
export to an OTLP collector running on `localhost:4318`, and names the service
`chf01` to distinguish it in a multi-node deployment.

### 6.2 Minimal local development (default `sys.config`)

All listeners on loopback; traces disabled; session timeout at 5 minutes:

```erlang
[{chf_db, [{backend, chf_db_mnesia}]},
 {chf_core, [{session_idle_timeout, 300000}]},
 {chf_diameter, [
    {origin_host,  "chf.epc.mnc001.mcc001.3gppnetwork.org"},
    {origin_realm, "epc.mnc001.mcc001.3gppnetwork.org"},
    {listen, [{tcp, {127,0,0,1}, 3868}]}
  ]},
 {chf_sbi,  [{port, 8443}, {ip, {127,0,0,1}}]},
 {chf_api,  [{port, 8080}, {ip, {127,0,0,1}}]},
 {chf_web,  [{port, 8081}, {ip, {127,0,0,1}}]},
 {opentelemetry, [{span_processor, batch}, {traces_exporter, none},
                  {resource, #{service => #{name => <<"chf">>}}}]},
 {opentelemetry_exporter, [{otlp_protocol, http_protobuf},
                            {otlp_endpoint, "http://localhost:4318"}]},
 {opentelemetry_experimental, [
    {readers, [
      #{module => otel_metric_reader,
        config => #{exporter => {opentelemetry_exporter, #{}},
                    export_interval_ms => 10000}},
      #{module => otel_metric_reader_prometheus,
        config => #{server_name => otel_prometheus_reader}}
    ]}
  ]}
].
```

## 7. Verify

After starting the node (`rebar3 shell` or the release `foreground`), confirm
each configured component as follows:

**Listeners bound:**

```sh
ss -ltn '( sport = :3868 or sport = :8443 or sport = :8080 or sport = :8081 )'
```

Each configured port `shall` appear in the output bound to the configured
address.

**DIAMETER listener:**
A DIAMETER peer's CER `shall` be answered with a CEA carrying the configured
`origin_host` and `origin_realm`. The Erlang node log `shall` emit a line of
the form:

```
DIAMETER listener added: {IP}: Port
```

at the `info` level during startup.

**Nchf SBI (port 8443):**
A `POST` to `http://<ip>:8443/nchf-convergedcharging/v3/chargingdata` with a
valid JSON body `shall` return `201 Created` or a 4xx error with a JSON
problem-details body (never a TCP connection refused).

**Provisioning API (port 8080):**
A `GET` to `http://<ip>:8080/subscribers` `shall` return `200 OK` with a JSON
array (empty on a fresh node).

**Web UI and metrics (port 8081):**
`GET http://<ip>:8081/metrics` `shall` return `200 OK` with a
`Content-Type: text/plain; version=0.0.4` body containing Prometheus-format
lines. `GET http://<ip>:8081/` `shall` return `200 OK` with the management
dashboard HTML.

**OTLP push export:**
When `traces_exporter` is `otlp`, the configured OTLP collector `shall` receive
POST requests on `<otlp_endpoint>/v1/traces` and `<otlp_endpoint>/v1/metrics`
within one `export_interval_ms` of the first request handled by the CHF.

**Session sweeper:**
The Erlang node log `shall` emit a line of the form:

```
Session sweeper started: interval=<N>ms idle_timeout=<M>ms
```

at the `info` level during startup, confirming both parameters were read.

> [!TIP]
> For metrics catalog details — instrument names, label sets, and scrape
> examples — see [`METRICS.md`](../METRICS.md).
