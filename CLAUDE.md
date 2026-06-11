# Next-CHF

3GPP combined CHF (Charging Function) + OCS (Online Charging System) + OFCS (Offline Charging System) in Erlang/OTP.

## Build

```sh
rebar3 compile
rebar3 release
_build/default/rel/next-chf/bin/next-chf foreground
```

OTP 28.4+ is required. rebar3 is the build system. The `chf_diameter` app uses the `rebar3_diameter_compiler` plugin (configured in `apps/chf_diameter/rebar.config`). The top-level `rebar.config` has an override to suppress `warnings_as_errors` for generated diameter code.

## Architecture

Erlang umbrella application with 7 sub-apps under `apps/`:

| App | Purpose | Deps | Listeners |
|-----|---------|------|-----------|
| `chf_db` | Pluggable DB layer (behaviour + Mnesia backend) | - | - |
| `chf_core` | Charging engine: session orchestration, online/offline logic | chf_db | - |
| `chf_diameter` | DIAMETER Gy (Ro) + Rf server interfaces for 4G | chf_core, diameter | TCP :3868 |
| `chf_api` | 5G Nchf_ConvergedCharging + OfflineOnlyCharging REST APIs (TS 32.291) | chf_core, cowboy | HTTP :8443 |
| `chf_provision` | Provisioning REST API (subscribers, balances) | chf_db, cowboy | HTTP :8080 |
| `chf_web` | Web management UI + Prometheus metrics | chf_core, chf_db, cowboy | HTTP :8081 |
| `chf` | Top-level app: config, startup logging | all above | - |

Startup order: chf_db -> chf_core -> chf_diameter -> chf_api -> chf_provision -> chf_web -> chf.

## Key design decisions

### Session model: DB-backed, no per-session processes

Session state (granted_units, used_units per RatingGroup) is persisted to Mnesia `disc_copies` on every operation. There are no gen_server processes per session. `chf_core.erl` reads the session from DB, calls the stateless charging modules, and writes back. A single `chf_session_sweeper` gen_server periodically scans for stale active sessions and terminates them (replacing per-session idle timers).

### Charging logic is stateless

`chf_online.erl` and `chf_offline.erl` are pure function modules. They take (Imsi, RatingGroups) and call `chf_db` for balance/CDR operations. All orchestration (which module to call, unit accumulation) lives in `chf_core.erl`.

### Pluggable DB backend

`chf_db_backend` defines a behaviour with callbacks for subscriber CRUD, balance operations (topup/reserve/commit/refund), CDR storage, and session persistence. `chf_db_mnesia` is the first implementation. `chf_db.erl` is the public facade that delegates to the configured backend (cached in `persistent_term`). Backend selection: `{chf_db, backend, chf_db_mnesia}` in app env.

### Only RatingGroup-based charging

No ServiceIdentifier or per-service rating in v1. MSCC (Multiple-Services-Credit-Control) uses RatingGroup as the sole discriminator.

### JSON handling

Uses Erlang's built-in `json` module: `json:decode/1` for input (the native
single-pass decoder; object keys are kept as **binaries**, never atomised) and
`json:encode/1` for output. Keys are not converted to atoms because 3GPP map
structures can carry arbitrary identifiers — atomising them would risk mixed
atom/binary key maps and atom-table growth. Each app with JSON handling has a
thin codec module (`chf_api_json`, `chf_provision_json`) wrapping decode/encode;
conversion from binary-keyed maps to internal representations (records, the
atom-keyed rating-group `quota`/`priority` config) happens explicitly and in a
single pass at the handler layer.

### DIAMETER: server-side

The CHF is a DIAMETER **server** (receives CCR/ACR, sends CCA/ACA). This is the opposite of the SMF sibling project which is a client. The critical callback is `handle_request/3`. Client-side callbacks (prepare_request, handle_answer, etc.) are stubs. Dictionary files were copied from `/home/nathanf/next-nf/smf/apps/smf_aaa/dia/`.

### Cowboy handlers

- `chf_provision` uses `cowboy_rest` behaviour (subscriber: full CRUD with content negotiation; balance: GET/PUT/PATCH on single resource)
- `chf_api` uses plain `cowboy_handler` (3GPP APIs are POST-only RPC-style, not RESTful)
- `chf_web` uses plain `cowboy_handler` (simple GET-only JSON APIs for the dashboard)

### Web UI

HTMX 2.0.4 + Pico CSS 2.1.1 served from `apps/chf_web/priv/static/vendor/`. HTMX polls JSON API endpoints with `hx-trigger="load, every 5s"`. A `htmx:beforeSwap` event listener transforms JSON responses into HTML via thin client-side template functions. No build tooling.

## Data model

Records defined in `apps/chf_db/include/chf_db.hrl`:

- `#subscriber{imsi, msisdn, account_id, status, rating_groups, created_at, updated_at}` — keyed by IMSI, secondary index on MSISDN
- `#balance{account_id, total, reserved, available}` — all amounts in micro-units (integers)
- `#cdr{id, session_id, imsi, type, rating_group, used_units, timestamp, metadata}`
- `#charging_session{session_id, imsi, type, state, granted_units, used_units, created_at, updated_at}` — `state` is `active | terminated`

Balance invariant: `available = total - reserved`. Reserve decrements available, commit decrements both reserved and total, refund moves from reserved back to available. All balance operations use Mnesia transactions.

## Call flow

All protocol interfaces go through `chf_core` as the single entry point:

```
Protocol handler
  -> chf_core:create_session(#{session_id, imsi, type})     %% writes to DB
  -> chf_core:session_initial(SessionId, #{rating_groups})  %% loads from DB, dispatches, persists
  -> chf_core:session_update(SessionId, #{rating_groups})   %% loads, accumulates, dispatches, persists
  -> chf_core:session_terminate(SessionId, #{rating_groups}) %% loads, finalizes, refunds, marks terminated
```

For online/converged sessions, `chf_online` does balance_reserve (initial/update) and balance_commit + balance_refund (terminate). For offline/converged sessions, `chf_offline` writes CDRs at each stage.

## Configuration

All in `config/sys.config`. Key settings:

- `{chf_db, [{backend, chf_db_mnesia}]}`
- `{chf_core, [{session_idle_timeout, 300000}, {sweep_interval, 60000}]}`
- `{chf_diameter, [{origin_host, "..."}, {origin_realm, "..."}, {listen, [{tcp, IP, Port}]}]}`
- `{chf_api, [{port, 8443}, {ip, {127,0,0,1}}]}`
- `{chf_provision, [{port, 8080}, {ip, {127,0,0,1}}]}`
- `{chf_web, [{port, 8081}, {ip, {127,0,0,1}}]}`

## Conventions

- License: AGPL-3.0-or-later. All new source files (.erl, .hrl, .app.src) must have the SPDX header and short AGPLv3 notice at the top (see any existing file for the template)
- Sonnet agents for implementation, Opus for orchestration and review
- No parse_transforms
- No unnecessary abstractions or speculative features
- Balance amounts always in micro-units (integers, no floats)
- Decode JSON to binary-keyed maps (`json:decode/1`); never atomise inbound JSON keys
- Convert/transform decoded structures in a single pass — no repeated full traversals of the same list or map
- Mnesia `disc_copies` for persistent tables, transactions for atomicity
