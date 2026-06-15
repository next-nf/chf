<!-- SPDX-License-Identifier: AGPL-3.0-or-later -->

# Metrics Reference: CHF

**Applies to:** chf 0.1.0 and later · **Revised:** 2026-06-15

## 1. Scope

This document describes all OpenTelemetry metrics emitted by the CHF (Combined
Charging Function), including both instruments defined in the CHF source and
instruments provided by the instrumentation libraries the CHF enables at startup.

The CHF emits metrics via two paths:

- **OTLP push** — the `opentelemetry_exporter` application sends metrics to an
  OTLP receiver using `http_protobuf` encoding (default endpoint:
  `http://localhost:4318`; configurable via `{opentelemetry_exporter,
  [{otlp_endpoint, "..."}]}`).
- **Prometheus pull** — `GET /metrics` on the chf_web listener (default:
  `http://127.0.0.1:8081/metrics`) returns Prometheus text exposition served by
  the OTEL Prometheus pull reader (`otel_metric_reader_prometheus`).

> [!NOTE]
> The Prometheus serializer converts `.` to `_` in metric names and appends a
> unit-derived suffix. Because the two hand-rolled counters carry the OTEL
> dimensionless unit `1`, the exporter renders them with a `_ratio` suffix:
> `gy.charging.outcome` scrapes as **`gy_charging_outcome_ratio`** and
> `chf.balance.operation` as **`chf_balance_operation_ratio`** (both still
> `# TYPE ... counter`). `http.server.request.duration` scrapes as
> `http_server_request_duration_seconds`, and so on. Scrape `GET /metrics` to
> see the exact rendered names for your build.

Metrics that are not initialized in the CHF — including any instruments defined
in the instrumentation libraries but not enabled — are not documented here and
are not part of this component's operator contract.

## 2. Terms

| Abbreviation | Meaning |
| --- | --- |
| CHF | Combined Charging Function (3GPP TS 32.290) |
| OCS | Online Charging System |
| OFCS | Offline Charging System |
| Gy | Diameter credit-control interface (online charging, Ro application) |
| Rf | Diameter accounting interface (offline charging) |
| CCR | Credit-Control-Request (Diameter, Gy) |
| CCA | Credit-Control-Answer (Diameter, Gy) |
| ACR | Accounting-Request (Diameter, Rf) |
| ACA | Accounting-Answer (Diameter, Rf) |
| IMSI | International Mobile Subscriber Identity |
| OTLP | OpenTelemetry Protocol |
| RatingGroup | Diameter Multiple-Services-Credit-Control discriminator |
| BEAM | Erlang virtual machine |

## 3. Export surface

### 3.1 OTLP push

The CHF pushes metrics over HTTP using the OpenTelemetry protocol.

| Parameter | Default | Configurable via |
| --- | --- | --- |
| Endpoint | `http://localhost:4318` | `{opentelemetry_exporter, [{otlp_endpoint, "http://..."}]}` in `sys.config` |
| Encoding | `http_protobuf` | `{opentelemetry_exporter, [{otlp_protocol, http_protobuf}]}` |

### 3.2 Prometheus pull

The chf_web application (`apps/chf_web`) routes `GET /metrics` to
`chf_web_metrics_h`, which calls the OTEL Prometheus reader directly and returns
Prometheus text exposition.

| Parameter | Default | Configurable via |
| --- | --- | --- |
| Address | `127.0.0.1` | `{chf_web, [{ip, ...}]}` in `sys.config` |
| Port | `8081` | `{chf_web, [{port, 8081}]}` in `sys.config` |
| Path | `/metrics` | Not configurable |

**Verify:** `curl -s http://127.0.0.1:8081/metrics | head -20` shall return
Prometheus text exposition beginning with `# HELP` lines for the instruments
listed in this document.

## 4. Hand-rolled instruments

These instruments are defined and initialized in
`apps/chf_otel/src/chf_otel.erl`, via `chf_otel:setup_metrics/0` called at
`chf_otel_app` startup. Both instruments are counters. The `record_*` functions
no-op silently if `setup_metrics/0` has not yet run, so a missing metrics
subsystem never fails a charging request.

### 4.1 `gy.charging.outcome`

| Field | Value |
| --- | --- |
| Name | `gy.charging.outcome` |
| Prometheus name | `gy_charging_outcome_ratio` (counter; `_ratio` suffix from OTEL unit `1`) |
| Type | Counter |
| Unit | `1` (dimensionless count) |
| Since | chf 0.1.0 (W5) |
| Description | Charging decisions by outcome and interface, one increment per Diameter credit-control or accounting response built. |

**Attributes:**

| Attribute | Type | Values |
| --- | --- | --- |
| `charging.interface` | atom | `gy`, `rf` |
| `charging.outcome` | atom | `success`, `insufficient_balance`, `user_unknown`, `unknown_session`, `unable_to_comply` |

**Recorded in:**

- `chf_diameter_gy` — once per CCA built, mapping the Gy result to the outcome
  atom (`success` for `{ok, _}`; `insufficient_balance` for
  `CREDIT_LIMIT_REACHED`; `user_unknown` for `USER_UNKNOWN`;
  `unknown_session` for `UNKNOWN_SESSION_ID`; `unable_to_comply` for all other
  errors).
- `chf_diameter_rf` — once per ACA built, using the same mapping (the Rf result
  set does not include `insufficient_balance`; that value will not appear on
  `charging.interface = rf`).

**Attribute value contract:** both call sites use private mapping functions
(`outcome_atom/1` in `chf_diameter_gy`, `rf_outcome_atom/1` in
`chf_diameter_rf`) that exhaustively match the result tuple. No other outcome
atoms are produced.

### 4.2 `chf.balance.operation`

| Field | Value |
| --- | --- |
| Name | `chf.balance.operation` |
| Prometheus name | `chf_balance_operation_ratio` (counter; `_ratio` suffix from OTEL unit `1`) |
| Type | Counter |
| Unit | `1` (dimensionless count) |
| Since | chf 0.1.0 (W5) |
| Description | Balance operations on the online-charging path, one increment per reserve, commit, or refund attempt, tagged with the result. |

**Attributes:**

| Attribute | Type | Values |
| --- | --- | --- |
| `balance.op` | atom | `reserve`, `commit`, `refund` |
| `balance.result` | atom | `ok` on success; an error reason atom (e.g. `insufficient_balance`) on failure |

**Recorded in:** `chf_online` — at each call to `chf_db:balance_reserve/3`,
`chf_db:balance_commit/3`, and `chf_db:balance_refund/3` on the online and
converged charging paths.

> [!NOTE]
> `topup` is reserved in the attribute space for future use but is not currently
> recorded. The provisioning path (`chf_api`) is not instrumented in this
> version; topup operations do not appear in this counter.

## 5. HTTP server metrics

**Source:** `opentelemetry_cowboy_experimental_h`

**Enabled by:** `chf_otel_app` calls `opentelemetry_cowboy_experimental_h:init/0`
at startup. All three Cowboy listeners wire the metrics callback via
`otel_opts => #{metrics_cb => fun opentelemetry_cowboy_experimental_h:metrics_cb/5}`.

**Listeners covered:**

| Listener | App | Default address |
| --- | --- | --- |
| chf_sbi | `chf_sbi` | `127.0.0.1:8443` |
| chf_api | `chf_api` | `127.0.0.1:8080` |
| chf_web | `chf_web` | `127.0.0.1:8081` |

### 5.1 Instruments

All three are histograms, recorded once per HTTP request.

| Name | Type | Unit | When recorded |
| --- | --- | --- | --- |
| `http.server.request.duration` | Histogram | `s` (seconds) | Every request |
| `http.server.request.body.size` | Histogram | `By` (bytes) | Only when the request body size is a number |
| `http.server.response.body.size` | Histogram | `By` (bytes) | Every request |

### 5.2 Attributes

Each histogram is recorded with the following attribute set (stable HTTP
OpenTelemetry semantic conventions):

`http.request.method`, `url.scheme`, `error.type`, `http.response.status_code`,
`http.route`, `network.protocol.name`, `network.protocol.version`,
`server.address`, `server.port`.

> [!WARNING]
> **`http.route` and `error.type` are in the attribute filter but are never
> set by the handler.** Cowboy provides no matched-route string to the metrics
> callback, and `error.type` is not populated. These two dimensions are absent
> on all histograms — per-route latency breakdowns are not available without
> additional instrumentation.

> [!WARNING]
> **`http.server.response.body.size` is recorded even when the body size is
> `undefined`** (the implementation does not guard this with `is_number/1`,
> unlike request body size). Treat unexpected values on this histogram with
> skepticism.

> [!NOTE]
> **Spans and metrics carry different attribute vintages.** The span emitted by
> `opentelemetry_cowboy_h` uses legacy keys (`http.method`, `http.scheme`,
> `http.status_code`, `http.flavor`); the metrics use stable semconv keys
> (`http.request.method`, `url.scheme`, `http.response.status_code`, …). Span
> and metric attribute keys do not align.

## 6. Diameter metrics

**Source:** `opentelemetry_diameter`

**Enabled by:** `chf_otel_app` calls `opentelemetry_diameter_metrics:setup/0` at
startup. These metrics poll `diameter:services()` at collect time; they cover
all active Diameter services on the node.

The CHF runs a single Diameter service, `next-chf` (the `?SERVICE` macro in
`chf_diameter_srv`), which hosts both interfaces as separate Diameter
applications. Gy and Rf are therefore distinguished not by the service-name
label but by the per-message application/command labels:

| Interface | Distinguishing label values |
| --- | --- |
| Gy / Ro (online charging) | `diameter_command_name` ∈ `CCR`/`CCA` (Credit-Control) |
| Rf (offline charging / accounting) | `diameter_command_name` ∈ `ACR`/`ACA` (Accounting) |

The `diameter_service_name` label carries the value `next-chf` on every Diameter
metric, so it is not useful for splitting Gy from Rf — group by
`diameter_command_name` (or `diameter_application_id`) instead.

**Instruments** (instrument base names; the Prometheus exporter renders monotonic
counters with a `_total` suffix, e.g. `diameter_message_count_total`, and leaves
gauges such as `diameter_connection_count` unsuffixed): `diameter.application.count`,
`diameter.connection.count`, `diameter.message.count`, `diameter.connection.io`,
`diameter.connection.packets`, `diameter.error.count`.

**Key attribute keys** (Prometheus label form): `diameter_service_name`,
`diameter_peer_origin_host`, `diameter_command_name`, `diameter_application_id`,
`message_direction` (`sent`/`received`), `network_io_direction`
(`transmit`/`receive`), `diameter_result_code`, `diameter_error_type`.

For the authoritative description of units, attribute keys, and attribute values
for each instrument, see the upstream library documentation:
<https://github.com/next-nf/opentelemetry-erlang-contrib/tree/main/instrumentation/opentelemetry_diameter>

> [!NOTE]
> Because these instruments poll `diameter:services()` at collect time rather
> than recording on each event, they reflect the state at the moment of
> collection. Burst traffic between collection intervals does not inflate counts.

## 7. BEAM/VM metrics

**Source:** `opentelemetry_beam` (via `opentelemetry_beam_metrics:setup/0`)

**Enabled by:** `chf_otel_app` calls `opentelemetry_beam_metrics:setup/0` at
startup.

The `opentelemetry_beam` library in this build emits metrics in the following
categories (verified against a live `/metrics` scrape):

- Memory — `beam_memory_allocated_bytes{kind}`, `beam_memory_processes_bytes{usage}`,
  `beam_memory_system_bytes{usage=atom|binary|ets|code|other}`,
  `beam_memory_atoms_bytes{usage}`
- Run-queue lengths — `beam_cpu_scheduler_run_queues_length` (normal),
  `beam_cpu_dirty_cpu_scheduler_run_queue_length`,
  `beam_cpu_dirty_io_scheduler_run_queue_length`
- Scheduler / CPU counts — `beam_cpu_scheduler_count`, `beam_cpu_scheduler_online`,
  `beam_cpu_logical_processors_*` (counts, **not** a 0–1 utilization ratio)
- Process / port / table counts — `beam_process_count`, `beam_port_count`,
  `beam_ets_count`, `beam_atom_count` (plus their `_limit` gauges)
- Work done — `beam_process_reductions_total`, `beam_port_io_bytes_total`
- Garbage collection — `beam_memory_garbage_collection_count_total`,
  `beam_memory_garbage_collection_words_reclaimed_total`,
  `beam_memory_garbage_collection_bytes_reclaimed_bytes_total`

> [!NOTE]
> This build exposes scheduler/CPU **counts** and run-queue lengths, not a
> scheduler-utilization ratio. Use `rate(beam_process_reductions_total[…])` as a
> CPU-work proxy. The authoritative names, units, and attributes are governed by
> the next-nf BEAM VM semantic conventions:
> <https://github.com/next-nf/semantic-conventions/tree/add/beam-vm>

> [!NOTE]
> `opentelemetry_process_propagator` carries OpenTelemetry context across
> Erlang process boundaries. It emits no metrics.

## 8. Verify

The following checks confirm that all instrument categories are active after the
CHF node starts.

**Hand-rolled instruments (OTLP or Prometheus):**

```sh
curl -s http://127.0.0.1:8081/metrics | grep gy_charging_outcome
# Expected: a # HELP line and a # TYPE counter line for gy_charging_outcome.

curl -s http://127.0.0.1:8081/metrics | grep chf_balance_operation
# Expected: a # HELP line and a # TYPE counter line for chf_balance_operation.
```

**HTTP server metrics:**

```sh
curl -s http://127.0.0.1:8081/metrics | grep http_server_request_duration
# Expected: a # HELP line and # TYPE histogram line; bucket lines appear after
# the first HTTP request has been served.
```

**Diameter metrics:**

```sh
curl -s http://127.0.0.1:8081/metrics | grep diameter_connection_count
# Expected: a # HELP line; a metric line with the Diameter service label.
# Value is 0 until a Diameter peer connects.
```

**BEAM/VM metrics:**

```sh
curl -s http://127.0.0.1:8081/metrics | grep beam_
# Expected: multiple # HELP / # TYPE lines covering schedulers, memory, and GC.
```

**Startup log warnings:** if any library setup call fails (cowboy metrics, BEAM
metrics, or Diameter metrics), `chf_otel_app` logs a `warning`-level message of
the form:

```
chf_otel: <subsystem> setup failed (<class>:<reason>); metrics for this subsystem will be absent.
```

The hand-rolled instruments (`gy.charging.outcome`, `chf.balance.operation`) are
not guarded — a failure in `chf_otel:setup_metrics/0` causes the node to fail
to start, as these are considered a real defect.
