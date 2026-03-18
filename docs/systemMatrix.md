Yes. The cleaner complete model is:

* **Platform systems**: independent runtime authorities that must exist
* **ASP.NET capabilities**: client-side libraries/protocols used by your API/worker hosts to consume those systems
* **Reduced redundancy rule**: one primary platform per responsibility unless a second platform exists only as a derived projection

Iceberg supports multi-engine access and standard catalog patterns, including REST and JDBC catalogs; OpenMetadata supports Iceberg ingestion; Airflow has provider support around Iceberg and Trino. ([Apache Iceberg][1])

## 1) Platform systems matrix

| Domain                   | Platform System         | Mandatory | Role                                                                   | Class      | Installed Now |
| ------------------------ | ----------------------- | --------: | ---------------------------------------------------------------------- | ---------- | ------------: |
| Edge                     | Traefik                 |       Yes | ingress, TLS termination, host/path routing                            | Platform   |            No |
| Identity                 | Keycloak                |       Yes | SSO, OIDC, token issuance, federation                                  | Platform   |            No |
| Secrets                  | Vault                   |       Yes | secrets authority, leases, rotation                                    | Platform   |            No |
| Control Plane            | PostgreSQL              |       Yes | canonical control-plane state, identity, correlation, config, workflow | Canonical  |           Yes |
| Control Plane Protection | PgBouncer               |       Yes | connection pooling/protection for Postgres                             | Platform   |            No |
| Cache / Coordination     | Redis                   |       Yes | ephemeral cache, distributed locks, short-lived coordination           | Support    |           Yes |
| Object Storage           | MinIO                   |       Yes | canonical object and artifact storage                                  | Canonical  |           Yes |
| Structured Data          | Apache Iceberg          |       Yes | canonical open-table structured data substrate                         | Canonical  |            No |
| Iceberg Catalog          | REST Catalog service    |       Yes | decoupled catalog authority for Iceberg metadata                       | Canonical  |            No |
| Query Layer              | Trino                   |       Yes | canonical SQL/query access across Iceberg and approved sources         | Canonical  |            No |
| Metadata Catalog         | OpenMetadata            |       Yes | metadata authority, discovery, ownership, glossary                     | Canonical  |            No |
| Lineage                  | OpenLineage             |       Yes | lineage event standard and derivation tracking                         | Canonical  |            No |
| Search / Retrieval       | OpenSearch              |       Yes | lexical and vector retrieval projection                                | Projection |           Yes |
| Search Admin             | OpenSearch Dashboards   |       Yes | admin/inspection UI for OpenSearch                                     | Support    |           Yes |
| Ingestion / Flow         | Apache NiFi             |       Yes | ingestion routing, transformation orchestration, controlled landing    | Platform   |           Yes |
| Document Parsing         | Apache Tika             |       Yes | text and metadata extraction from documents                            | Platform   |           Yes |
| OCR                      | OCR service             |       Yes | OCR for scanned/image-native docs                                      | Platform   |            No |
| Event Backbone           | Kafka                   |       Yes | durable event transport and replay backbone                            | Platform   |            No |
| Event Schema             | Schema Registry         |       Yes | event schema governance and compatibility                              | Platform   |            No |
| Connector Runtime        | Kafka Connect           |       Yes | managed connectors and sink/source runtimes                            | Platform   |            No |
| CDC                      | Debezium                |       Yes | CDC capture into Kafka backbone                                        | Platform   |            No |
| Stream Processing        | Flink                   |       Yes | event-time streaming transforms and joins                              | Platform   |            No |
| Batch Orchestration      | Airflow                 |       Yes | scheduled DAG orchestration and reprocessing                           | Platform   |            No |
| External Extraction      | Airbyte                 |       Yes | connector-heavy source extraction and sync                             | Platform   |            No |
| Transformation Modeling  | dbt runtime             |       Yes | curated models, marts, semantic SQL transforms                         | Platform   |            No |
| Analytical Projection    | ClickHouse              |       Yes | high-speed derived analytics projection                                | Projection |           Yes |
| Graph Projection         | Neo4j                   |       Yes | graph projection for relationships/dependencies/causality              | Projection |            No |
| AI Gateway               | LiteLLM                 |       Yes | unified model/provider gateway                                         | Platform   |            No |
| AI Inference             | vLLM                    |       Yes | local inference and embedding serving                                  | Platform   |            No |
| Tool Access              | MCP Gateway             |       Yes | standard tool access layer for LLM systems                             | Platform   |            No |
| Retrieval Processing     | RAG Indexer             |       Yes | chunking, extraction, embedding, index population                      | Platform   |            No |
| Retrieval Quality        | Reranker Service        |       Yes | second-stage ranking and grounding                                     | Platform   |            No |
| AI Observability         | Langfuse                |       Yes | LLM traces, prompt/tool/retrieval telemetry                            | Platform   |            No |
| Analytics UI             | Apache Superset         |       Yes | dashboards and analytical exploration                                  | Consumer   |            No |
| AI Workbench             | Open WebUI              |       Yes | developer/operator AI workbench                                        | Consumer   |            No |
| AI Workbench             | AnythingLLM             |       Yes | user-facing AI workspace                                               | Consumer   |            No |
| Telemetry Pipeline       | OpenTelemetry Collector |       Yes | unified telemetry intake and forwarding                                | Platform   |            No |
| Metrics Store            | Prometheus              |       Yes | metrics scrape/storage backbone                                        | Platform   |            No |
| Alerting                 | Alertmanager            |       Yes | alert routing and notification                                         | Platform   |            No |
| Monitoring UI            | Grafana                 |       Yes | dashboards, alert visualization, ops visibility                        | Consumer   |            No |
| Logs                     | Loki                    |       Yes | centralized log aggregation and search                                 | Platform   |            No |
| Log Shipping             | Fluent Bit              |       Yes | log shipping from containers/hosts                                     | Platform   |            No |
| Uptime Monitoring        | Uptime Kuma             |       Yes | external synthetic uptime/availability checks                          | Support    |            No |
| Image Registry           | Harbor                  |       Yes | internal image registry and image governance                           | Platform   |            No |
| Container Ops            | Portainer               |       Yes | container management surface                                           | Support    |            No |
| Package / Artifact Repo  | Nexus Repository        |       Yes | package and artifact repository                                        | Platform   |            No |
| Backup Orchestration     | Backup Runner           |       Yes | scheduled backups across platform systems                              | Support    |            No |
| Maintenance              | Maintenance Worker      |       Yes | retention, cleanup, archive, rebuild, reindex                          | Support    |            No |

## 2) ASP.NET client capability matrix

| Domain                      | ASP.NET Capability                         | Primary Target System(s)                  | Role                                                | Mandatory |
| --------------------------- | ------------------------------------------ | ----------------------------------------- | --------------------------------------------------- | --------: |
| Web/API                     | ASP.NET Core API host                      | all                                       | API surface, orchestration, control-plane endpoints |       Yes |
| Background                  | .NET Worker host                           | all                                       | jobs, daemons, consumers, schedulers                |       Yes |
| Auth                        | OIDC/JWT auth packages                     | Keycloak                                  | token validation, SSO, policy enforcement           |       Yes |
| Secrets                     | Vault client                               | Vault                                     | secret retrieval and lease handling                 |       Yes |
| Data Access                 | Npgsql + EF Core/Dapper                    | PostgreSQL / PgBouncer                    | control-plane persistence and reads                 |       Yes |
| Cache                       | Redis client                               | Redis                                     | cache and lock usage                                |       Yes |
| Object Storage              | MinIO/S3 client                            | MinIO                                     | artifact/object operations                          |       Yes |
| Query Access                | Trino client wrapper / REST or ODBC bridge | Trino                                     | canonical SQL access from API/workers               |       Yes |
| Metadata Client             | OpenMetadata REST client                   | OpenMetadata                              | metadata queries, ownership, catalog automation     |       Yes |
| Lineage Emitter             | HTTP/Kafka lineage emitter                 | OpenLineage / Kafka                       | lineage event publication                           |       Yes |
| Search Client               | OpenSearch client                          | OpenSearch                                | indexing, search, retrieval orchestration           |       Yes |
| Ingestion Control           | NiFi REST client                           | NiFi                                      | manage flows, trigger runs, inspect states          |       Yes |
| Parsing Client              | HTTP client wrapper                        | Tika / OCR                                | document parse and OCR orchestration                |       Yes |
| Event Client                | Kafka producer/consumer                    | Kafka                                     | event publish/consume                               |       Yes |
| Schema Client               | Schema Registry client                     | Schema Registry                           | schema registration and compatibility use           |       Yes |
| Stream/Batch Control        | REST clients                               | Kafka Connect / Flink / Airflow / Airbyte | operational control from API if needed              |       Yes |
| Transformation Control      | job/API wrapper                            | dbt runtime                               | run models/tests/docs jobs                          |       Yes |
| Analytics Projection Client | ClickHouse client                          | ClickHouse                                | projection writes/reads where required              |       Yes |
| Graph Client                | Neo4j driver                               | Neo4j                                     | graph projection queries/writes                     |       Yes |
| LLM Gateway Client          | OpenAI-compatible SDK                      | LiteLLM / vLLM                            | chat, embeddings, completions                       |       Yes |
| MCP Client/Server SDK       | MCP Gateway                                | tool exposure and tool invocation         | Yes                                                 |       Yes |
| RAG Pipeline Client         | internal service HTTP/queue client         | RAG Indexer / Reranker                    | retrieval pipeline orchestration                    |       Yes |
| AI Telemetry Client         | Langfuse SDK or HTTP client                | Langfuse                                  | trace and eval submission                           |       Yes |
| Telemetry                   | OpenTelemetry SDK + OTLP exporter          | OTEL Collector / Prometheus / Loki        | traces, metrics, logs                               |       Yes |
| Logging                     | structured logger sink stack               | Loki / OTEL                               | structured operational logging                      |       Yes |
| Health Checks               | ASP.NET health check packages              | all                                       | readiness/liveness/dependency checks                |       Yes |
| OpenAPI                     | Swagger/OpenAPI package                    | API host                                  | contract publication and admin testing              |       Yes |
| Resilience                  | Polly / resilience handlers                | all outbound systems                      | retries, circuit breaks, timeout policies           |       Yes |
| Validation                  | DTO/command validation                     | API/worker boundaries                     | input and command validation                        |       Yes |
| Test Harness                | Testcontainers + integration test host     | all major dependencies                    | integration testing                                 |       Yes |

## 3) System-to-capability mapping

| Platform System    | Primary ASP.NET Capability      | Secondary Capability               | Notes                                     |
| ------------------ | ------------------------------- | ---------------------------------- | ----------------------------------------- |
| Traefik            | none                            | health endpoints exposed behind it | platform-owned edge, not app-owned        |
| Keycloak           | OIDC/JWT auth                   | policy handlers                    | identity stays outside app                |
| Vault              | Vault client                    | config bootstrap                   | secrets authority stays outside app       |
| PostgreSQL         | Npgsql + EF Core/Dapper         | health checks                      | canonical control plane                   |
| PgBouncer          | same Postgres capability        | none                               | transparent to app                        |
| Redis              | Redis client                    | health checks                      | ephemeral only                            |
| MinIO              | MinIO/S3 client                 | health checks                      | canonical object store                    |
| Iceberg            | Trino client wrapper            | metadata client via OpenMetadata   | avoid direct app writes unless deliberate |
| REST Catalog       | indirect via Trino/admin API    | none                               | keep catalog authority external           |
| Trino              | Trino client wrapper            | health checks                      | canonical structured query path           |
| OpenMetadata       | REST client                     | metadata automation jobs           | metadata authority                        |
| OpenLineage        | lineage emitter                 | Kafka client                       | standard lineage publication              |
| OpenSearch         | OpenSearch client               | health checks                      | retrieval/index projection                |
| NiFi               | NiFi REST client                | lineage emitter                    | flow control only                         |
| Tika               | HTTP wrapper                    | health checks                      | parse service                             |
| OCR service        | HTTP wrapper                    | health checks                      | OCR service                               |
| Kafka              | producer/consumer client        | health checks                      | event backbone                            |
| Schema Registry    | schema client                   | Kafka client                       | event contract governance                 |
| Kafka Connect      | REST client                     | none                               | operational surface                       |
| Debezium           | indirect via Kafka              | monitoring client                  | CDC service, not app-owned                |
| Flink              | REST/job client                 | Kafka client                       | stream compute                            |
| Airflow            | REST client                     | none                               | batch orchestration                       |
| Airbyte            | REST client                     | none                               | extraction service                        |
| dbt runtime        | job wrapper                     | artifact parsing                   | transform runner                          |
| ClickHouse         | ClickHouse client               | health checks                      | projection-only analytics                 |
| Neo4j              | Neo4j driver                    | health checks                      | projection graph                          |
| LiteLLM            | OpenAI-compatible SDK           | resilience handlers                | model gateway                             |
| vLLM               | OpenAI-compatible SDK           | resilience handlers                | local inference                           |
| MCP Gateway        | MCP SDK                         | auth client                        | tools layer                               |
| RAG Indexer        | internal service client         | OpenSearch client                  | retrieval pipeline stage                  |
| Reranker           | HTTP wrapper                    | resilience handlers                | retrieval quality stage                   |
| Langfuse           | Langfuse client                 | OTEL correlation                   | AI observability                          |
| Superset           | SSO/embed only                  | none                               | consumer UI, not system API               |
| Open WebUI         | SSO only                        | none                               | consumer UI                               |
| AnythingLLM        | SSO only                        | none                               | consumer UI                               |
| OTEL Collector     | OpenTelemetry SDK/OTLP exporter | logging stack                      | telemetry ingress                         |
| Prometheus         | metrics endpoint exposure       | none                               | scrape-based                              |
| Alertmanager       | none                            | webhook callbacks if needed        | platform-owned                            |
| Grafana            | SSO/embed only                  | none                               | consumer UI                               |
| Loki               | structured logger sink          | OTEL logs                          | log backend                               |
| Fluent Bit         | stdout/OTEL only                | none                               | shipper-owned                             |
| Uptime Kuma        | none                            | health endpoints exposed           | external monitor                          |
| Harbor             | CI/CD only                      | none                               | not runtime app concern                   |
| Portainer          | none                            | none                               | admin surface only                        |
| Nexus Repository   | CI/CD and package restore       | none                               | not runtime app concern                   |
| Backup Runner      | HTTP/job trigger only           | artifact/status client             | support system                            |
| Maintenance Worker | internal API or queue           | scheduler                          | can be .NET-native                        |

## Reduction rules applied

| Rule                           | Result                                              |
| ------------------------------ | --------------------------------------------------- |
| One canonical structured store | Iceberg only                                        |
| One canonical object store     | MinIO only                                          |
| One canonical control-plane DB | PostgreSQL only                                     |
| One canonical SQL access layer | Trino only                                          |
| One search/retrieval engine    | OpenSearch only                                     |
| One event backbone             | Kafka only                                          |
| One stream processor           | Flink only                                          |
| One batch orchestrator         | Airflow only                                        |
| One metadata authority         | OpenMetadata only                                   |
| One lineage standard           | OpenLineage only                                    |
| One AI gateway                 | LiteLLM only                                        |
| One local inference runtime    | vLLM only                                           |
| Keep projections explicit      | ClickHouse and Neo4j are projection-only, not truth |

## Current completion snapshot

| Category                     |      Count Installed / Total |
| ---------------------------- | ---------------------------: |
| Canonical + platform systems |                       8 / 41 |
| Canonical truth systems only |                        3 / 7 |
| Projection systems           |                        3 / 4 |
| ASP.NET capability groups    | 0 / 26 verified from runtime |

If you want the next step in table form, the correct one is a **bring-up wave table** with columns: `Wave | System | Depends On | Why In That Wave | Installed Now`.

[1]: https://iceberg.apache.org/?utm_source=chatgpt.com "Apache Iceberg - Apache Iceberg™"

Below is the **complete bring-up wave table** using the current Path A model, the current solution/runtime shape, and the installed-state reflected in your last `docker ps`. The current repo/runtime shape is Host + Portal + Workers + Shared, and the canonical data platform standard in the repo sets NiFi, MinIO, Postgres, Iceberg, Trino, OpenMetadata, OpenLineage, and projection layers as the governing model.  

| Wave | Domain                        | System / Platform            | Role                                            | Depends On                                       | Installed Now |
| ---- | ----------------------------- | ---------------------------- | ----------------------------------------------- | ------------------------------------------------ | ------------- |
| 0    | Runtime                       | WoodOps.Shared               | shared capability/kernel library                | none                                             | No            |
| 0    | Runtime                       | WoodOps.Host                 | primary API/runtime host                        | Shared                                           | No            |
| 0    | Runtime                       | WoodOps.Workers              | background processing host                      | Shared                                           | No            |
| 0    | Runtime                       | WoodOps.Portal               | UI/runtime consumer                             | Host                                             | No            |
| 1    | Edge                          | Traefik                      | ingress, TLS termination, host/path routing     | none                                             | No            |
| 1    | Identity                      | Keycloak                     | SSO, OIDC, token issuance                       | Traefik                                          | No            |
| 1    | Secrets                       | Vault                        | secrets authority and rotation                  | Traefik                                          | No            |
| 1    | Certificate / PKI             | step-ca                      | internal PKI / service certificates             | Vault                                            | No            |
| 1    | Control Plane                 | PostgreSQL                   | canonical control-plane state                   | none                                             | Yes           |
| 1    | Control Plane Protection      | PgBouncer                    | Postgres connection pooling                     | PostgreSQL                                       | No            |
| 1    | Cache / Coordination          | Redis                        | cache, locks, ephemeral coordination            | none                                             | Yes           |
| 1    | Object Storage                | MinIO                        | canonical object and artifact storage           | none                                             | Yes           |
| 1    | Ingestion / Flow              | Apache NiFi                  | ingestion routing and controlled landing        | PostgreSQL, MinIO                                | Yes           |
| 1    | Document Parsing              | Apache Tika                  | document text/metadata extraction               | none                                             | Yes           |
| 1    | OCR                           | OCRmyPDF / Tesseract service | OCR for scanned documents/images                | none                                             | No            |
| 1    | Search / Retrieval Projection | OpenSearch                   | lexical/vector retrieval projection             | PostgreSQL, MinIO                                | Yes           |
| 1    | Search Admin                  | OpenSearch Dashboards        | OpenSearch inspection/admin UI                  | OpenSearch                                       | Yes           |
| 2    | Lakehouse Catalog             | Iceberg REST Catalog         | catalog authority for Iceberg tables            | PostgreSQL, MinIO                                | No            |
| 2    | Structured Data               | Apache Iceberg               | canonical structured/open-table substrate       | MinIO, Iceberg REST Catalog                      | No            |
| 2    | Query Layer                   | Trino                        | canonical SQL/query layer                       | Iceberg REST Catalog, MinIO, PostgreSQL          | No            |
| 2    | Metadata Catalog              | OpenMetadata                 | metadata authority, discovery, ownership        | PostgreSQL, Trino                                | No            |
| 2    | Lineage                       | OpenLineage                  | lineage event standard                          | PostgreSQL, Trino, NiFi                          | No            |
| 3    | Event Backbone                | Kafka                        | durable event transport                         | none                                             | No            |
| 3    | Event Schema                  | Schema Registry              | schema governance for Kafka events              | Kafka                                            | No            |
| 3    | Connector Runtime             | Kafka Connect                | managed connectors                              | Kafka, Schema Registry                           | No            |
| 3    | Connector UI                  | Kafka UI                     | topic/consumer/connector inspection             | Kafka, Kafka Connect                             | No            |
| 3    | CDC                           | Debezium                     | CDC capture into Kafka                          | Kafka, Schema Registry, Kafka Connect            | No            |
| 3    | Stream Processing             | Apache Flink                 | event-time streaming transforms                 | Kafka                                            | No            |
| 3    | Batch Orchestration           | Apache Airflow               | scheduled orchestration / reprocessing          | PostgreSQL                                       | No            |
| 3    | External Extraction           | Airbyte                      | connector-heavy source extraction               | PostgreSQL                                       | No            |
| 3    | Transformation Modeling       | dbt Runner                   | modeled marts / semantic transforms             | Trino, PostgreSQL                                | No            |
| 4    | Analytics Projection          | ClickHouse                   | high-speed derived analytics projection         | Trino or Kafka                                   | Yes           |
| 4    | Analytics Coordination        | ClickHouse Keeper            | ClickHouse coordination                         | ClickHouse                                       | No            |
| 4    | Graph Projection              | Neo4j                        | relationship/dependency/causal graph projection | PostgreSQL, OpenLineage                          | No            |
| 5    | AI Gateway                    | LiteLLM                      | unified model/provider gateway                  | Vault, Keycloak                                  | No            |
| 5    | AI Inference                  | vLLM                         | local model/embedding serving                   | LiteLLM, Vault                                   | No            |
| 5    | Tool Access                   | MCP Gateway                  | standard tool access layer for LLM clients      | Keycloak, Vault, Host                            | No            |
| 5    | Retrieval Processing          | RAG Indexer                  | chunking, embedding, indexing pipeline          | Tika, OCR, OpenSearch, MinIO, LiteLLM/vLLM       | No            |
| 5    | Retrieval Quality             | Reranker Service             | second-stage ranking                            | OpenSearch, LiteLLM/vLLM                         | No            |
| 5    | AI Observability              | Langfuse                     | LLM/prompt/tool telemetry                       | PostgreSQL, LiteLLM, Host                        | No            |
| 6    | Analytics UI                  | Apache Superset              | dashboards and ad hoc analytics                 | Trino, Keycloak                                  | No            |
| 6    | AI Workbench                  | Open WebUI                   | developer/operator AI workbench                 | LiteLLM/vLLM, Keycloak                           | No            |
| 6    | AI Workbench                  | AnythingLLM                  | user-facing AI workspace                        | LiteLLM/vLLM, OpenSearch, MinIO, Keycloak        | No            |
| 6    | Data Science                  | JupyterHub                   | notebooks and ad hoc research                   | Trino, Keycloak                                  | No            |
| 7    | Telemetry Pipeline            | OpenTelemetry Collector      | metrics/traces/log ingestion and forwarding     | none                                             | No            |
| 7    | Metrics Store                 | Prometheus                   | metrics backend                                 | OpenTelemetry Collector                          | No            |
| 7    | Alerting                      | Alertmanager                 | alert routing                                   | Prometheus                                       | No            |
| 7    | Monitoring UI                 | Grafana                      | dashboards and alert visibility                 | Prometheus, Loki, Keycloak                       | No            |
| 7    | Log Aggregation               | Loki                         | centralized log aggregation                     | OpenTelemetry Collector or Fluent Bit            | No            |
| 7    | Log Shipping                  | Fluent Bit                   | log shipping from containers/hosts              | none                                             | No            |
| 7    | Uptime Monitoring             | Uptime Kuma                  | synthetic availability checks                   | Traefik                                          | No            |
| 8    | Container Registry            | Harbor                       | internal image registry and governance          | PostgreSQL, Traefik, Keycloak                    | No            |
| 8    | Package / Artifact Repo       | Nexus Repository             | package and artifact repository                 | PostgreSQL, Traefik, Keycloak                    | No            |
| 8    | Container Ops                 | Portainer                    | container admin surface                         | Docker environment, Traefik, Keycloak            | No            |
| 8    | Backup                        | Backup Runner                | scheduled backups across systems                | PostgreSQL, MinIO, OpenSearch, ClickHouse, Neo4j | No            |
| 8    | Restore Catalog               | Restic                       | snapshot catalog / restore control              | MinIO or backup target                           | No            |
| 8    | Maintenance                   | Maintenance Worker           | cleanup, retention, reindex, archive            | PostgreSQL, Trino, OpenSearch, MinIO             | No            |

| Summary                               | Value                                                                               |
| ------------------------------------- | ----------------------------------------------------------------------------------- |
| Total platform systems                | 48                                                                                  |
| Installed now                         | 8 platform systems + 0 runtime hosts verified                                       |
| Installed now list                    | PostgreSQL, Redis, MinIO, NiFi, Tika, OpenSearch, OpenSearch Dashboards, ClickHouse |
| Canonical truth systems installed now | PostgreSQL, MinIO                                                                   |
| Canonical truth systems still missing | Iceberg REST Catalog, Iceberg, Trino, OpenMetadata, OpenLineage                     |

| ASP.NET Capability Group                                  | Primary Target Systems                                         |
| --------------------------------------------------------- | -------------------------------------------------------------- |
| ASP.NET Core API host                                     | Host-facing orchestration across all systems                   |
| .NET Worker host                                          | Kafka, NiFi, Trino, OpenSearch, Airflow, dbt, maintenance jobs |
| OIDC/JWT auth                                             | Keycloak                                                       |
| Secret client                                             | Vault                                                          |
| Postgres access (`Npgsql` / EF / Dapper)                  | PostgreSQL / PgBouncer                                         |
| Redis client                                              | Redis                                                          |
| S3 client                                                 | MinIO                                                          |
| Trino client / wrapper                                    | Trino                                                          |
| Metadata REST client                                      | OpenMetadata                                                   |
| Lineage emitter                                           | OpenLineage / Kafka                                            |
| OpenSearch client                                         | OpenSearch                                                     |
| NiFi REST client                                          | NiFi                                                           |
| Tika / OCR HTTP clients                                   | Tika / OCR                                                     |
| Kafka client + Schema Registry client                     | Kafka / Schema Registry                                        |
| Airflow / Airbyte / Kafka Connect / Flink control clients | corresponding orchestration systems                            |
| ClickHouse client                                         | ClickHouse                                                     |
| Neo4j driver                                              | Neo4j                                                          |
| OpenAI-compatible SDK                                     | LiteLLM / vLLM                                                 |
| MCP client/server SDK                                     | MCP Gateway                                                    |
| Langfuse client                                           | Langfuse                                                       |
| OpenTelemetry SDK + OTLP exporter                         | OTEL Collector / Prometheus / Loki                             |
| Structured logging + health checks + resilience           | platform-wide support against all systems                      |

| Reduction Rules Applied                 | Result            |
| --------------------------------------- | ----------------- |
| One canonical control-plane DB          | PostgreSQL only   |
| One canonical object store              | MinIO only        |
| One canonical structured substrate      | Iceberg only      |
| One canonical SQL/query layer           | Trino only        |
| One metadata authority                  | OpenMetadata only |
| One lineage standard                    | OpenLineage only  |
| One event backbone                      | Kafka only        |
| One search/retrieval engine             | OpenSearch only   |
| One model gateway                       | LiteLLM only      |
| One local inference runtime             | vLLM only         |
| Projection systems remain non-canonical | ClickHouse, Neo4j |

Next artifact should be the same table with one more column: **Compose Layer**.
