# WoodOps OSS Platform Stack
Location: docs/WOODOPS_OSS_STACK.md

Purpose  
Define the **complete non-redundant open-source platform stack** required to operate WoodOps.  
This stack provides infrastructure for:

• operational data storage  
• ingestion and integration  
• streaming and processing  
• LLM and RAG services  
• analytics and KPI dashboards  
• AI workbenches  
• observability  

Security infrastructure is intentionally excluded at this stage.

The design rule is:


Shared platform services own capabilities.
Workbench applications consume shared services.
Duplicate infrastructure inside workbenches is avoided.


---

# 1. Core Data Systems

These systems form the **persistent storage layer**.

## PostgreSQL
Purpose:
- relational operational data
- service metadata
- job orchestration state
- configuration state

## PgBouncer
Purpose:
- PostgreSQL connection pooling
- connection protection under load

## MongoDB
Purpose:
- canonical document / item storage
- object envelopes
- flexible operational documents

## ClickHouse
Purpose:
- analytical queries
- KPI fact tables
- historian rollups
- time-series analytics

## ClickHouse Keeper
Purpose:
- ClickHouse cluster coordination
- replication metadata
- distributed table consistency

## Neo4j
Purpose:
- relationship graph
- lineage tracking
- dependency graphs
- causal relationship exploration

## Redis
Purpose:
- ephemeral cache
- distributed locks
- short-lived coordination state

Redis is not a system of record.

## MinIO
Purpose:
- object storage
- file attachments
- raw ingestion drops
- model artifacts
- exported datasets

## OpenSearch
Purpose:
- search indexing
- vector search
- hybrid lexical + vector retrieval
- RAG corpus storage

## OpenSearch Dashboards
Purpose:
- OpenSearch cluster administration
- index inspection
- search debugging
- retrieval validation

---

# 2. Event and Ingestion Infrastructure

These systems form the **data movement and processing layer**.

## Kafka
Purpose:
- event backbone
- durable message streams
- decoupled service communication
- replayable event history

## Schema Registry
Purpose:
- event schema governance
- schema evolution
- compatibility enforcement

## Kafka Connect
Purpose:
- connectorized ingestion and export
- database connectors
- file connectors
- CDC pipelines

## Kafka UI
Purpose:
- topic inspection
- consumer lag visibility
- connector monitoring

---

## Apache NiFi
Purpose:
- ingestion flow orchestration
- routing
- transformation
- file ingestion
- historian extraction pipelines

NiFi acts as the **data flow controller**.

---

## Airbyte
Purpose:
- connector-heavy source extraction
- SaaS and database replication
- structured source syncing

Rule:


Airbyte = extraction
NiFi = routing + transformation


---

## Apache Flink
Purpose:
- stream processing
- event-time computation
- stream joins
- real-time enrichment
- continuous aggregation

Flink computes over Kafka streams.

---

## Apache Airflow
Purpose:
- batch workflow orchestration
- reprocessing pipelines
- index rebuild jobs
- scheduled refresh jobs
- ingestion scheduling

Airflow manages **time-based workflows**.

---

## dbt Runner
Purpose:
- transformation modeling
- analytical data layers
- curated KPI marts
- semantic metric tables

dbt prepares analytical models for Superset.

---

# 3. LLM and RAG Platform Services

These services provide the **AI platform capabilities**.

## LiteLLM
Purpose:
- model gateway
- unified API for model providers
- request routing
- provider abstraction
- usage tracking

LiteLLM normalizes model access.

---

## vLLM
Purpose:
- local model inference
- embedding generation
- OpenAI-compatible API endpoint

vLLM is the **model serving engine**.

---

## MCP Gateway
Purpose:
- expose tools to LLM clients
- expose databases
- expose services
- standardize tool access

Examples:
- PostgreSQL tools
- ClickHouse tools
- Neo4j tools
- retrieval tools
- operational APIs

---

## Apache Tika
Purpose:
- document parsing
- PDF extraction
- Office document parsing
- text normalization

---

## OCR Service (OCRmyPDF or Tesseract)
Purpose:
- scanned document text extraction
- image OCR
- camera image text extraction

OCR complements Tika for image-based documents.

---

## RAG Indexer
Purpose:
- document chunking
- embedding generation
- metadata extraction
- vector index population
- reindex management
- provenance tracking

The RAG indexer writes to OpenSearch.

---

## Reranker Service
Purpose:
- second-stage retrieval ranking
- improved document relevance
- improved grounding accuracy

---

## Langfuse
Purpose:
- LLM tracing
- prompt version tracking
- tool call inspection
- retrieval analysis
- debugging AI workflows

Langfuse is **LLM observability**.

---

# 4. Analytics and KPI Layer

## Apache Superset
Purpose:
- KPI dashboards
- operational analytics
- business reporting
- ad-hoc exploration

Superset queries primarily:

- ClickHouse
- PostgreSQL analytical marts

---

# 5. AI Workbench Layer

These systems provide **human interaction with the AI platform**.

## Open WebUI
Purpose:
- LLM experimentation
- prompt testing
- tool testing
- developer AI workbench

Typical users:
- developers
- AI engineers
- platform designers

---

## AnythingLLM
Purpose:
- knowledge assistants
- document-based AI workspaces
- operational RAG assistants
- user-facing AI tools

Typical users:
- engineers
- analysts
- supervisors
- operational staff

---

# Workbench Design Rule

Workbench systems must **consume platform services**.

They must not own independent:

- vector stores
- embedding infrastructure
- model serving
- ingestion pipelines

All such capabilities are platform services.

---

# 6. Observability Infrastructure

These systems provide **platform monitoring**.

## OpenTelemetry Collector
Purpose:
- telemetry ingestion
- metrics pipeline
- trace forwarding

---

## Prometheus
Purpose:
- metrics storage
- time-series monitoring

---

## Grafana
Purpose:
- infrastructure dashboards
- system monitoring
- alert visualization

---

## Loki
Purpose:
- log aggregation
- log search
- application log retention

---

# 7. Operational Support Services

These are required to operate the platform reliably.

## Backup Runner
Purpose:
- database backups
- object storage backups
- snapshot automation

Targets include:
- PostgreSQL
- MongoDB
- ClickHouse
- Neo4j
- MinIO
- OpenSearch

---

## Maintenance Worker
Purpose:
- retention jobs
- reindex jobs
- cleanup tasks
- archive tasks
- lifecycle management

---

# Complete Container Stack


postgresql
pgbouncer

mongodb

clickhouse
clickhouse-keeper

neo4j

redis

minio

opensearch
opensearch-dashboards

kafka
schema-registry
kafka-connect
kafka-ui

apache-nifi
airbyte
apache-flink

apache-airflow
dbt-runner

litellm
vllm
mcp-gateway
apache-tika
ocrmypdf-or-tesseract
rag-indexer
reranker-service
langfuse

apache-superset

open-webui
anythingllm

otel-collector
prometheus
grafana
loki


---

# Architectural Capability Coverage

This stack provides capabilities for:

• relational storage  
• document storage  
• graph storage  
• analytical storage  
• object storage  
• search and vector retrieval  
• event streaming  
• ingestion pipelines  
• stream processing  
• workflow orchestration  
• analytical modeling  
• LLM inference  
• embeddings generation  
• document ingestion  
• RAG indexing  
• AI observability  
• analytics dashboards  
• AI workbenches  
• infrastructure observability

---

# Key Architecture Principle


Platform services provide capabilities.

Applications consume capabilities.

Workbenches never duplicate platform infrastructure.


This ensures the platform remains **consistent, extensible, and non-redundant**.
