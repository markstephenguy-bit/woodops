# WoodOps Canonical Data Platform Standard

## Purpose

Define a durable, generic, and extensible data platform standard for WoodOps that:
- supports current operational ingestion (images, SQL, files)
- enables future multimodal LLM interaction
- avoids coupling to any single AI or application layer
- can scale across multiple sources and domains

This standard prioritizes **long-term interoperability, composability, and reuse**.

---

## Core Principle

> The platform must separate **data truth**, **metadata/relationships**, and **AI interaction**.

The LLM is a **consumer of curated evidence**, not the owner of the data model.

---

## Canonical Platform Layers

### 1. Acquisition / Ingestion Layer

**Primary Tool:** NiFi

Responsibilities:
- ingest from external systems (cameras, SQL Server, APIs, filesystems)
- perform initial routing and enrichment
- assign correlation keys
- write to canonical storage layers

Characteristics:
- stateless processing where possible
- observable and traceable flows

---

### 2. Canonical Object Storage Layer

**Primary Tool:** MinIO (S3-compatible)

Responsibilities:
- store all binary and file-based artifacts
- images (SICK cameras)
- PDFs, logs, exports, intermediate artifacts

Rules:
- immutable object storage pattern
- no business logic embedded in storage paths
- reference objects via IDs, not paths

---

### 3. Open Table (Lakehouse) Layer

**Primary Standard:** Apache Iceberg

Responsibilities:
- canonical structured datasets
- normalized facts derived from source systems
- cross-source analytical tables

Characteristics:
- schema evolution
- ACID table behavior
- multi-engine compatibility (Trino, Spark, etc.)

---

### 4. Operational Control Plane

**Primary Tool:** Postgres

Responsibilities:
- object registry
- event ledger
- correlation model
- workflow state
- system configuration

This is the **source of truth for identity and relationships**, not for large data payloads.

---

### 5. Metadata and Lineage Layer

**Primary Tools:**
- OpenMetadata
- OpenLineage

Responsibilities:
- dataset catalog
- lineage tracking (jobs, datasets, transformations)
- schema visibility
- semantic relationships

Purpose:
- unify understanding of data across systems
- enable AI and human discoverability

---

### 6. Query / Access Layer

**Primary Tool:** Trino

Responsibilities:
- federated querying across datasets
- access Iceberg tables
- serve as SQL interface for tools and LLMs

Characteristics:
- read-optimized
- decoupled from storage

---

### 7. Optional Projection Layers

Used for performance or specialized access patterns.

Examples:
- OpenSearch (text/search projection)
- ClickHouse (high-performance analytics)

Rules:
- projections are **not canonical truth**
- must be reproducible from canonical layers

---

## Canonical Data Model (Conceptual)

### Core Entities

#### Object
- represents any ingested artifact
- examples: image, file, dataset row group, document

#### Event
- represents a change or occurrence
- ingestion event
- processing event
- operational event

#### Relationship
- links objects and events
- temporal
- causal
- structural

#### Source
- origin system (camera, SQL Server, MES, etc.)

---

## Required Properties

Every object must support:

- stable unique identifier
- source attribution
- timestamp (capture and ingest)
- correlation keys (machine, line, batch, etc.)
- pointer to storage location (MinIO, Iceberg, etc.)

---

## Correlation Model (Critical)

This is the most important design element.

All data must be linkable through shared dimensions such as:

- time (primary join axis)
- equipment / station
- line / process stage
- batch / run / unit identifiers

This enables:
- joining images to SQL facts
- aligning events across systems
- multimodal reasoning later

---

## AI Interaction Model (Future Layer)

The platform must not be designed around a specific AI tool.

Instead, it must expose **retrieval capabilities**.

### Required Retrieval Types

- structured queries (SQL via Trino)
- object lookup (MinIO references)
- metadata queries (Postgres / catalog)
- text search (OpenSearch or derived layer)

---

## AI Integration Pattern

### Retrieval-first architecture

1. classify user query
2. call appropriate retrieval tools
3. gather evidence bundle:
   - SQL facts
   - metadata
   - object references (images, files)
4. pass bundle to LLM
5. generate response with references

---

## Anti-Patterns (Must Avoid)

### 1. Single Database as Universal Store
- e.g., MongoDB for everything
- breaks structured querying and analytics

### 2. AI Tool as Canonical Layer
- do not use Open WebUI / AnythingLLM as data store
- they are consumers

### 3. Duplicate Knowledge Stores
- multiple AI tools ingesting same raw data independently
- causes drift and inconsistency

### 4. Loss of Correlation
- ingesting sources without shared keys
- prevents future cross-modal queries

---

## Extensibility Requirements

The platform must support adding new sources without redesign.

For each new source:

1. ingest via NiFi
2. assign object identity
3. extract metadata
4. map correlation keys
5. store binary/structured data appropriately
6. register in metadata layer

No changes should be required to:
- existing storage layers
- existing query layer
- AI interface layer

---

## Minimal Initial Stack

- NiFi
- MinIO
- Postgres
- Trino

Add later:
- Iceberg
- OpenMetadata
- OpenLineage

---

## Evolution Path

### Phase 1
- ingestion + storage + registry

### Phase 2
- introduce Iceberg tables
- enable cross-source analytics

### Phase 3
- add metadata/lineage layer

### Phase 4
- introduce AI retrieval orchestration

---

## Final Rule

> Design WoodOps as a **multimodal evidence platform**, not a database and not an AI app.

If the platform can:
- store objects
- track relationships
- expose retrieval

then any future LLM system can operate on it without redesign.

