## Table 1 — Phase 1 Core Platform Authorities

| Domain                   | System                  | System Type             | Why It Is Phase 1 Core                                       | Requires These Systems Online           | Installed Now |
| ------------------------ | ----------------------- | ----------------------- | ------------------------------------------------------------ | --------------------------------------- | ------------- |
| Edge                     | Traefik                 | Platform authority      | ingress, routing, TLS, external entry boundary               | none                                    | No            |
| Identity                 | Keycloak                | Platform authority      | authentication, OIDC, token issuance, SSO boundary           | Traefik                                 | No            |
| Secrets                  | Vault                   | Platform authority      | secrets authority, rotation, secure app/system credentials   | Traefik                                 | No            |
| Control Plane            | PostgreSQL              | Platform authority      | canonical control-plane state, identity, correlation, config | none                                    | Yes           |
| Control Plane Protection | PgBouncer               | Required support system | protects Postgres under concurrent load                      | PostgreSQL                              | No            |
| Cache / Coordination     | Redis                   | Platform authority      | ephemeral cache, locks, short-lived coordination             | none                                    | Yes           |
| Object Storage           | MinIO                   | Platform authority      | canonical object and artifact storage                        | none                                    | Yes           |
| Ingestion / Flow         | Apache NiFi             | Platform authority      | ingestion routing, landing, transformation orchestration     | PostgreSQL, MinIO                       | Yes           |
| Document Parsing         | Apache Tika             | Required support system | text/metadata extraction for files and docs                  | none                                    | Yes           |
| OCR                      | OCR service             | Required support system | OCR for scanned/image-native documents                       | none                                    | No            |
| Structured Catalog       | Iceberg REST Catalog    | Platform authority      | catalog authority for canonical structured tables            | PostgreSQL, MinIO                       | No            |
| Structured Data          | Apache Iceberg          | Platform authority      | canonical structured/open-table substrate                    | MinIO, Iceberg REST Catalog             | No            |
| Query Layer              | Trino                   | Platform authority      | canonical SQL access over Iceberg and approved sources       | Iceberg REST Catalog, MinIO, PostgreSQL | No            |
| Metadata Catalog         | OpenMetadata            | Platform authority      | metadata authority, discovery, ownership, technical catalog  | PostgreSQL, Trino                       | No            |
| Lineage                  | OpenLineage             | Platform authority      | lineage event standard and derivation tracking               | PostgreSQL, Trino, NiFi                 | No            |
| Search / Retrieval       | OpenSearch              | Platform authority      | lexical/vector retrieval projection and search substrate     | PostgreSQL, MinIO                       | Yes           |
| Telemetry Ingest         | OpenTelemetry Collector | Platform authority      | central telemetry intake and forwarding                      | none                                    | No            |
| Metrics Store            | Prometheus              | Platform authority      | metrics backend and scrape authority                         | OpenTelemetry Collector                 | No            |
| Log Store                | Loki                    | Platform authority      | centralized log aggregation backend                          | OpenTelemetry Collector or log shipper  | No            |
| Monitoring UI            | Grafana                 | Required support system | monitoring, dashboards, alert visibility                     | Prometheus, Loki                        | No            |

---

## Table 2 — Phase 1 Core Summary

| Category                 | Systems                                                                                                                                                                          |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Platform authorities     | Traefik, Keycloak, Vault, PostgreSQL, Redis, MinIO, NiFi, Iceberg REST Catalog, Iceberg, Trino, OpenMetadata, OpenLineage, OpenSearch, OpenTelemetry Collector, Prometheus, Loki |
| Required support systems | PgBouncer, Tika, OCR service, Grafana                                                                                                                                            |
| Already installed        | PostgreSQL, Redis, MinIO, NiFi, Tika, OpenSearch                                                                                                                                 |
| Still missing            | Traefik, Keycloak, Vault, PgBouncer, OCR service, Iceberg REST Catalog, Iceberg, Trino, OpenMetadata, OpenLineage, OpenTelemetry Collector, Prometheus, Loki, Grafana            |

---

## Table 3 — Consumer Dependency Matrix

| Consumer / Target System | System Type         | Minimum Runnable Systems Online        | Platform-Correct Runnable Systems Online                                                                                                      | Installed Now |
| ------------------------ | ------------------- | -------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| Open WebUI               | Consumer app        | Traefik, one model backend             | Traefik, Keycloak, Vault, LiteLLM, vLLM, OpenSearch, MinIO, Tika, OCR service, OpenTelemetry Collector, Prometheus, Loki, Grafana             | No            |
| AnythingLLM              | Consumer app        | Traefik, one model backend, OpenSearch | Traefik, Keycloak, Vault, LiteLLM, vLLM, OpenSearch, MinIO, Tika, OCR service, PostgreSQL, OpenTelemetry Collector, Prometheus, Loki, Grafana | No            |
| Apache Superset          | Consumer app        | Traefik, Trino                         | Traefik, Keycloak, Vault, Trino, PostgreSQL, OpenTelemetry Collector, Prometheus, Loki, Grafana                                               | No            |
| JupyterHub               | Consumer app        | Traefik, Trino                         | Traefik, Keycloak, Vault, Trino, PostgreSQL, OpenTelemetry Collector, Prometheus, Loki, Grafana                                               | No            |
| WoodOps.Host             | Application runtime | PostgreSQL, Redis                      | Traefik, Keycloak, Vault, PostgreSQL, PgBouncer, Redis, MinIO, Trino, OpenSearch, OpenTelemetry Collector, Prometheus, Loki, Grafana          | No            |
| WoodOps.Workers          | Application runtime | PostgreSQL, Redis                      | Vault, PostgreSQL, PgBouncer, Redis, MinIO, NiFi, Trino, OpenSearch, OpenTelemetry Collector, Prometheus, Loki, Grafana                       | No            |
| WoodOps.Portal           | Application runtime | Traefik, WoodOps.Host                  | Traefik, Keycloak, Vault, WoodOps.Host, OpenTelemetry Collector, Prometheus, Loki, Grafana                                                    | No            |

---

## Table 4 — AI / Model Service Dependency Matrix

| Service          | System Type                    | Minimum Runnable Systems Online             | Platform-Correct Runnable Systems Online                                                                            | Installed Now |
| ---------------- | ------------------------------ | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------- |
| LiteLLM          | Core-adjacent support platform | Traefik                                     | Traefik, Keycloak, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana                                        | No            |
| vLLM             | Core-adjacent support platform | LiteLLM or direct ingress, GPU/runtime host | LiteLLM, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana                                                  | No            |
| MCP Gateway      | Core-adjacent support platform | Traefik, one auth path                      | Traefik, Keycloak, Vault, WoodOps.Host, OpenTelemetry Collector, Prometheus, Loki, Grafana                          | No            |
| RAG Indexer      | Core-adjacent support platform | MinIO, OpenSearch, one model backend        | MinIO, OpenSearch, Tika, OCR service, LiteLLM, vLLM, PostgreSQL, OpenTelemetry Collector, Prometheus, Loki, Grafana | No            |
| Reranker Service | Core-adjacent support platform | OpenSearch, one model backend               | OpenSearch, LiteLLM, vLLM, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana                                | No            |
| Langfuse         | Core-adjacent support platform | PostgreSQL                                  | PostgreSQL, LiteLLM, WoodOps.Host, OpenTelemetry Collector, Prometheus, Loki, Grafana                               | No            |

---

## Table 5 — Data / Processing Extension Dependency Matrix

| Extension System | System Type          | Minimum Runnable Systems Online       | Platform-Correct Runnable Systems Online                                                         | Installed Now |
| ---------------- | -------------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------ | ------------- |
| Kafka            | Extension platform   | none                                  | Traefik, Keycloak, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana                     | No            |
| Schema Registry  | Extension platform   | Kafka                                 | Kafka, PostgreSQL or its configured backend, OpenTelemetry Collector, Prometheus, Loki, Grafana  | No            |
| Kafka Connect    | Extension platform   | Kafka, Schema Registry                | Kafka, Schema Registry, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana                | No            |
| Kafka UI         | Consumer/admin       | Kafka                                 | Traefik, Keycloak, Kafka, OpenTelemetry Collector, Prometheus, Loki, Grafana                     | No            |
| Debezium         | Extension platform   | Kafka, Schema Registry, Kafka Connect | Kafka, Schema Registry, Kafka Connect, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana | No            |
| Apache Flink     | Extension platform   | Kafka                                 | Kafka, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana                                 | No            |
| Apache Airflow   | Extension platform   | PostgreSQL                            | PostgreSQL, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana                            | No            |
| Airbyte          | Extension platform   | PostgreSQL                            | PostgreSQL, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana                            | No            |
| dbt Runner       | Extension platform   | Trino                                 | Trino, Vault, PostgreSQL, OpenTelemetry Collector, Prometheus, Loki, Grafana                     | No            |
| ClickHouse       | Extension projection | none                                  | Traefik, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana                               | Yes           |
| Neo4j            | Extension projection | none                                  | Traefik, Vault, OpenTelemetry Collector, Prometheus, Loki, Grafana                               | No            |

---

## Table 6 — Phase 1 Decision Rule

| Rule                      | Meaning                                                                                    |
| ------------------------- | ------------------------------------------------------------------------------------------ |
| Include in Phase 1 Core   | The system is a platform authority, or another system cannot function correctly without it |
| Exclude from Phase 1 Core | The system is a consumer app, admin UI, projection engine, or workload-specific processor  |
| Minimum Runnable          | Smallest online set that lets the target system function                                   |
| Platform-Correct Runnable | Online set that makes the target system fit WoodOps correctly                              |
| Installed Now             | Confirmed only from your last `docker ps`                                                  |

---

## Table 7 — Immediate Recording View

| Phase                                        | Include                                                                                                                                                                                                                 |
| -------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Phase 1 Core Platform                        | Traefik, Keycloak, Vault, PostgreSQL, PgBouncer, Redis, MinIO, NiFi, Tika, OCR service, Iceberg REST Catalog, Iceberg, Trino, OpenMetadata, OpenLineage, OpenSearch, OpenTelemetry Collector, Prometheus, Loki, Grafana |
| Phase 1 Consumers Tracked By Dependency Only | Open WebUI, AnythingLLM, Superset, JupyterHub, WoodOps.Host, WoodOps.Workers, WoodOps.Portal                                                                                                                            |
| Phase 2+ Extensions                          | Kafka, Schema Registry, Kafka Connect, Kafka UI, Debezium, Flink, Airflow, Airbyte, dbt Runner, ClickHouse, Neo4j, LiteLLM, vLLM, MCP Gateway, RAG Indexer, Reranker, Langfuse                                          |

If you want the next version, I can convert these into a tighter **recording-ready master table** with exactly these columns only: `System | Phase | Type | Minimum Runnable | Platform-Correct Runnable | Installed Now`.
