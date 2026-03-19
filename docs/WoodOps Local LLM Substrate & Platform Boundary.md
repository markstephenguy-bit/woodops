# WoodOps — Local LLM Substrate & Boundary Strategy

## 1. Objective

Provide a GPT-like local experience over WoodOps data using:
- OSS-first components
- Local model execution
- Governed data exposure

---

## 2. Core Requirement

All data admitted into WoodOps must be queryable by a local LLM.

This requires explicit exposure paths:

### Structured Data
- Governed SQL access
- Curated read models
- Controlled query generation

### Unstructured Data
- Parsing
- Chunking
- Embedding
- Indexing
- Retrieval with citation grounding

---

## 3. System Layers

### Interaction Layer (Integral)
- OpenWebUI
  - Primary LLM interface

### Model Layer (External OSS)
- Ollama (or equivalent)

### Data Substrate (External OSS)
- PostgreSQL → canonical + metadata
- MinIO → object/artifacts
- ClickHouse → analytics
- OpenSearch → retrieval/index

### Integration Layer (.NET + NuGet)
- adapters to external systems
- query routing (SQL vs retrieval)
- policy enforcement
- light orchestration
- exposure rules
- minimal metadata coordination

---

## 4. Capability Classification

### MUST BE EXTERNAL (OSS)
- PostgreSQL
- MinIO
- ClickHouse
- OpenSearch
- OpenWebUI
- Ollama

### LIKELY EXTERNAL (WHEN NEEDED)
- Redis
- OCR service
- Tika

### .NET + NUGET
- ingestion adapters (not pipeline engine)
- indexing triggers
- SQL exposure layer
- retrieval routing
- LLM query orchestration (thin)
- provider abstractions
- lightweight metadata registry

### DEFER
- NiFi
- OpenMetadata
- OpenLineage
- Keycloak
- Vault
- Trino
- Iceberg
- full observability stack

---

## 5. LLM Query Path

1. User → OpenWebUI  
2. OpenWebUI → Ollama  
3. Routing decision:
   - structured → SQL
   - unstructured → retrieval (OpenSearch)  
4. Data returned with grounding  
5. Response generated locally  

---

## 6. Constraints

- OpenWebUI is integral but not authoritative
- No custom NiFi-class system in .NET
- Storage does not equal LLM exposure
- External services must justify existence
- Avoid duplicate responsibility across systems

---

## 7. Target Outcome

- Data lands once
- Data is exposed correctly
- Local LLM answers are grounded
- OSS handles heavy responsibilities
- .NET remains thin and controlled
