# WoodOps Iceberg-Aligned Standards
## Greenfield Platform Instantiation Guide

---

# 1. Purpose

This document defines the **standards stack that coincides with Apache Iceberg** and provides a **greenfield bring-up sequence** aligned to the WoodOps canonical data platform.

This is not a tooling list.
This is a **contract-first instantiation plan**.

---

# 2. Core Principle

Iceberg is not a database.

Iceberg is a **table abstraction layer** that requires:
- object storage
- metadata catalog
- query engine

The platform must be built around these dependencies in the correct order.

---

# 3. Standards Stack (Aligned to Iceberg)

## 3.1 Storage Standard

### S3-Compatible Object Storage

**Implementation:** MinIO

**Responsibilities:**
- immutable object storage
- raw file landing
- Iceberg data files
- artifact storage (images, documents)

**Rules:**
- no identity encoded in paths
- no schema implied by folder structure
- all objects referenced via canonical IDs

---

## 3.2 Table Format Standard

### Apache Iceberg

**Responsibilities:**
- canonical structured datasets
- schema evolution
- partition abstraction
- snapshot isolation
- time travel

**Rules:**
- all structured facts must land in Iceberg
- no source-shaped schemas allowed
- no direct writes outside controlled pipelines

---

## 3.3 File Format Standard

### Parquet (Primary)

**Responsibilities:**
- columnar storage
- compression
- analytical performance

**Rules:**
- standardize on Parquet unless exception justified
- enforce consistent encoding and compression

---

## 3.4 Catalog Standard

### Iceberg REST Catalog (Preferred)

**Responsibilities:**
- table metadata management
- schema tracking
- versioning

**Alternatives:**
- JDBC (Postgres-backed)

**Decision Constraint:**
- REST = decoupled, future-proof
- JDBC = simpler, but tighter coupling

---

## 3.5 Query Standard

### Trino (ANSI SQL Layer)

**Responsibilities:**
- query Iceberg tables
- federate across sources
- enforce access patterns

**Rules:**
- no direct access to Iceberg files
- all queries go through Trino

---

## 3.6 Metadata Standard

### OpenMetadata

**Responsibilities:**
- dataset catalog
- schema discovery
- ownership
- classification

**Rules:**
- metadata is not inferred ad hoc
- all datasets must be registered

---

## 3.7 Lineage Standard

### OpenLineage

**Responsibilities:**
- track data transformations
- record pipeline execution
- establish derivation graph

**Rules:**
- lineage emitted at ingestion and transformation boundaries

---

## 3.8 Retrieval Standard

### OpenSearch

**Responsibilities:**
- text search
- vector search
- hybrid retrieval

**Rules:**
- projection only
- never source of truth

---

# 4. System Responsibility Model

## Control Plane (Postgres)

Owns:
- identity
- source registry
- correlation
- relationships
- workflow state

Constraints:
- no large data storage
- no analytical workloads

---

## Data Plane

### MinIO
- object storage

### Iceberg
- structured data

---

## Query Plane

### Trino
- all structured access

---

## Metadata Plane

### OpenMetadata
- catalog and discovery

### OpenLineage
- lineage events

---

## Retrieval Plane

### OpenSearch
- search and vector retrieval

---

# 5. Greenfield Bring-Up Sequence

## Phase 0 (Already Complete)

- Postgres
- NiFi
- MinIO
- OpenSearch
- Tika

---

## Phase 1 – Foundation Alignment

Define before installs:
- canonical identity model
- canonical timestamp model
- source registration schema
- correlation model

No ingestion beyond raw landing allowed before this.

---

## Phase 2 – Data Plane Activation

Install:
1. Trino
2. Iceberg catalog (REST or JDBC)

Configure:
- MinIO as Iceberg warehouse
- Parquet as default format

Validate:
- create test Iceberg table
- query via Trino

---

## Phase 3 – Controlled Ingestion

NiFi responsibilities:
- land raw data in MinIO
- transform into canonical schema
- write to Iceberg

Constraints:
- NiFi does not define schema
- NiFi does not assign identity

---

## Phase 4 – Metadata Layer

Install:
- OpenMetadata

Connect:
- Trino
- Iceberg catalog

Validate:
- dataset discovery
- schema visibility

---

## Phase 5 – Lineage Layer

Install:
- OpenLineage

Integrate:
- NiFi
- Trino

Validate:
- lineage graph creation

---

## Phase 6 – Retrieval Layer

Extend:
- OpenSearch

Add:
- indexing pipelines
- vector embeddings

Constraints:
- all indexed data must reference canonical IDs

---

# 6. Critical Constraints

## Single Source of Truth

- structured → Iceberg
- objects → MinIO

Any violation creates fragmentation.

---

## No Dual Data Planes

Disallowed:
- Postgres as fact store
- ClickHouse as canonical analytics
- MongoDB as document truth

---

## Schema Discipline

All schemas must be:
- canonical
- source-agnostic
- evolution-capable

---

## Access Discipline

All access must go through:
- Trino (structured)
- OpenSearch (retrieval)

---

# 7. Failure Modes

## Early Schema Lock-in
- caused by ingesting source-shaped tables

## Hidden Coupling
- caused by embedding logic in NiFi

## Dual Truth Systems
- caused by multiple storage authorities

## Metadata Drift
- caused by lack of OpenMetadata integration

---

# 8. Final Model

MinIO (S3)
→ Iceberg (tables)
→ Catalog (REST/JDBC)
→ Trino (SQL)
→ OpenMetadata (catalog)
→ OpenLineage (lineage)
→ OpenSearch (retrieval)

---

# 9. Decision Required

Iceberg catalog selection:

- REST catalog (recommended)
- JDBC catalog (simpler bootstrap)

This decision must be made before Phase 2.

---

# End of Document

