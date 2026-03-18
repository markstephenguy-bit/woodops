# WOODOPS_PHASE_1_IMPLEMENTATION_PLAN.md

## Purpose

This document defines the execution plan for bringing all **Phase 1 core containers** online under the WoodOps infra architecture.

This is an implementation planning document.

It is not:
- a discussion document
- a future-state wishlist
- a phase 2 extension plan

It is the working record for:
- what Phase 1 includes
- what is already online
- what is still missing
- what compose layer each system belongs to
- what environment/config additions are required
- what volumes are required
- what dependencies must be online first
- how each system is validated

---

## Governing Rules

1. All services must follow the existing `infra/` architecture.
2. No ad hoc `docker run` containers.
3. No direct production-shape config outside repo-controlled files.
4. One dependency block at a time.
5. Validate each block before moving to the next.
6. No Phase 2 systems are to be added in this document.
7. This document tracks **containers only**, not NuGet/client capabilities.

---

## Phase 1 Scope

Phase 1 includes the following systems only:

- Traefik
- Keycloak
- Vault
- PostgreSQL
- PgBouncer
- Redis
- MinIO
- Apache NiFi
- Apache Tika
- OCR service
- Iceberg REST Catalog
- Trino
- OpenMetadata
- OpenLineage
- OpenSearch
- OpenTelemetry Collector
- Prometheus
- Loki
- Grafana

---

## Current Installed Status

| System | Installed Now |
|---|---|
| Traefik | No |
| Keycloak | No |
| Vault | No |
| PostgreSQL | Yes |
| PgBouncer | No |
| Redis | Yes |
| MinIO | Yes |
| Apache NiFi | Yes |
| Apache Tika | Yes |
| OCR service | No |
| Iceberg REST Catalog | No |
| Trino | No |
| OpenMetadata | No |
| OpenLineage | No |
| OpenSearch | Yes |
| OpenTelemetry Collector | No |
| Prometheus | No |
| Loki | No |
| Grafana | No |

---

## Bring-Up Blocks

### Block 1 — Security / Edge Foundation
- Traefik
- Keycloak
- Vault
- PgBouncer

### Block 2 — Document Completion
- OCR service

### Block 3 — Canonical Structured Data
- Iceberg REST Catalog
- Trino

### Block 4 — Metadata / Lineage
- OpenMetadata
- OpenLineage

### Block 5 — Observability
- OpenTelemetry Collector
- Prometheus
- Loki
- Grafana

---

## Working Table

| Order | Block | System | Compose Layer | Env Additions Required | Volume Mounts Required | Depends On | Validation Check | Installed Now | Status |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Block 1 | Traefik | `infra/docker/foundation/` | domain/host routing vars, TLS vars, admin exposure vars | traefik dynamic config, cert storage | none | routes resolve, dashboard/admin reachable if enabled, upstream proxying works | No | Pending |
| 2 | Block 1 | Keycloak | `infra/docker/foundation/` | admin user/pass, DB connection, hostname, proxy settings | keycloak data/config | Traefik, PostgreSQL | login page reachable, admin console works, token issuance works | No | Pending |
| 3 | Block 1 | Vault | `infra/docker/foundation/` | root/init settings, listener config, storage config, UI config | vault data/config | Traefik | health endpoint reachable, initialized, unsealed, UI/API accessible | No | Pending |
| 4 | Block 1 | PgBouncer | `infra/docker/foundation/` | Postgres host, port, auth config, pooling config | pgbouncer config | PostgreSQL | pooled connection succeeds, app-compatible endpoint reachable | No | Pending |
| 5 | Block 2 | OCR service | `infra/docker/document/` | OCR language/config vars, service port, temp/work dirs | OCR work/cache dirs | none | sample scanned PDF/image successfully OCRs | No | Pending |
| 6 | Block 3 | Iceberg REST Catalog | `infra/docker/data-platform/` | catalog service config, warehouse path, MinIO endpoint/credentials, DB backing if used | catalog state/config | PostgreSQL, MinIO | catalog reachable, namespace operations succeed | No | Pending |
| 7 | Block 3 | Trino | `infra/docker/data-platform/` | coordinator config, Iceberg catalog config, MinIO endpoint, auth/access config | trino config/catalog files | Iceberg REST Catalog, MinIO, PostgreSQL | query engine reachable, Iceberg catalog visible, test query succeeds | No | Pending |
| 8 | Block 4 | OpenMetadata | `infra/docker/metadata/` | DB connection, search backend config if required, pipeline/auth config | openmetadata data/config | PostgreSQL, Trino, OpenSearch | UI/API reachable, source registration works, metadata scan can be configured | No | Pending |
| 9 | Block 4 | OpenLineage | `infra/docker/metadata/` | API/storage config, endpoint settings, auth config if used | lineage config/data | PostgreSQL, Trino, Apache NiFi | lineage endpoint reachable, test event accepted | No | Pending |
| 10 | Block 5 | OpenTelemetry Collector | `infra/docker/observability/` | receiver/exporter config, ports, backend endpoints | collector config | none | collector health reachable, receives test telemetry | No | Pending |
| 11 | Block 5 | Prometheus | `infra/docker/observability/` | scrape config, storage path, retention settings | prometheus data/config | OpenTelemetry Collector | targets scrape successfully, UI reachable | No | Pending |
| 12 | Block 5 | Loki | `infra/docker/observability/` | storage config, retention config, ports | loki data/config | OpenTelemetry Collector | log ingestion succeeds, query works | No | Pending |
| 13 | Block 5 | Grafana | `infra/docker/observability/` | admin creds, datasource bootstrap config, auth settings | grafana data/provisioning | Prometheus, Loki | UI reachable, datasources connect, dashboard loads | No | Pending |

---

## Existing Online Systems Reference

These are already online and must be preserved while extending Phase 1:

| System | Role |
|---|---|
| PostgreSQL | control plane database |
| Redis | cache / coordination |
| MinIO | canonical object storage |
| Apache NiFi | ingestion / flow |
| Apache Tika | document parsing |
| OpenSearch | retrieval/search projection |

---

## Compose Layer Plan

### Foundation Layer
Path:
- `infra/docker/foundation/`

Contains:
- Traefik
- Keycloak
- Vault
- PgBouncer

### Document Layer
Path:
- `infra/docker/document/`

Contains:
- OCR service

### Data Platform Layer
Path:
- `infra/docker/data-platform/`

Contains:
- Iceberg REST Catalog
- Trino

### Metadata Layer
Path:
- `infra/docker/metadata/`

Contains:
- OpenMetadata
- OpenLineage

### Observability Layer
Path:
- `infra/docker/observability/`

Contains:
- OpenTelemetry Collector
- Prometheus
- Loki
- Grafana

---

## Expected Env Structure

All new config must remain env-driven and repo-controlled.

Expected areas:
- `infra/env/.env.local`
- service-specific env includes if needed
- compose references must resolve from repo paths only

Suggested grouping:
- foundation vars
- document vars
- data platform vars
- metadata vars
- observability vars

---

## Expected Volume Structure

All new persistent data should follow the existing mounted-data convention.

Suggested structure:
- `/srv/woodops-data/traefik`
- `/srv/woodops-data/keycloak`
- `/srv/woodops-data/vault`
- `/srv/woodops-data/pgbouncer`
- `/srv/woodops-data/ocr`
- `/srv/woodops-data/iceberg-catalog`
- `/srv/woodops-data/trino`
- `/srv/woodops-data/openmetadata`
- `/srv/woodops-data/openlineage`
- `/srv/woodops-data/otel-collector`
- `/srv/woodops-data/prometheus`
- `/srv/woodops-data/loki`
- `/srv/woodops-data/grafana`

---

## Execution Order

### Step 1
Bring online:
- Traefik
- Keycloak
- Vault
- PgBouncer

### Step 2
Bring online:
- OCR service

### Step 3
Bring online:
- Iceberg REST Catalog
- Trino

### Step 4
Bring online:
- OpenMetadata
- OpenLineage

### Step 5
Bring online:
- OpenTelemetry Collector
- Prometheus
- Loki
- Grafana

---

## Validation Gate Rules

Do not move to the next block until the current block is validated.

### Block 1 gate
- Traefik routes traffic correctly
- Keycloak issues tokens
- Vault is initialized and unsealed
- PgBouncer accepts pooled connections

### Block 2 gate
- OCR service successfully processes a scanned sample

### Block 3 gate
- Iceberg catalog is reachable
- Trino can see the catalog
- test namespace/table operations succeed

### Block 4 gate
- OpenMetadata UI/API is reachable
- OpenLineage endpoint accepts test lineage events

### Block 5 gate
- OTEL collector receives test telemetry
- Prometheus scrapes targets
- Loki stores and queries logs
- Grafana connects to datasources

---

## Status Tracking

| Block | Status |
|---|---|
| Block 1 — Security / Edge Foundation | Pending |
| Block 2 — Document Completion | Pending |
| Block 3 — Canonical Structured Data | Pending |
| Block 4 — Metadata / Lineage | Pending |
| Block 5 — Observability | Pending |

---

## Immediate Next Action

Begin implementation with **Block 1**:
- Traefik
- Keycloak
- Vault
- PgBouncer

This document should be updated as each system is:
- added to compose
- configured in env
- assigned persistent mounts
- started
- validated
- marked complete

---
