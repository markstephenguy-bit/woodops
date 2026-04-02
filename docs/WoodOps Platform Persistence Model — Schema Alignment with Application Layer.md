
# WoodOps Platform Persistence Model — Schema Alignment with Application Layer

## Purpose

This document validates that the current Postgres schema architecture supports the **WoodOps application platform**, not just data ingestion.

It clarifies:

- the **big picture architecture**
- the **role of Postgres**
- how schemas support both **application execution** and **data ingestion**
- what must remain disciplined to avoid architectural drift

---

## Big Picture

WoodOps is a **federated operational platform**, not a single-purpose database or data lake.

### Core Characteristics

- Multiple external systems feed data into the platform
- The platform executes internal application logic via .NET
- Data is normalized, tracked, and enriched centrally
- Data is projected outward into specialized systems

### System Model

```

[ Source Systems ]
↓
Postgres
(coordination + canonical layer)
↓
[ ClickHouse | Neo4j | Qdrant | OpenSearch | etc. ]

```

### Postgres Role

Postgres is:

- the **ingestion hub**
- the **canonical coordination layer**
- the **identity authority**
- the **semantic enforcement layer**
- the **application persistence layer**

Postgres is NOT:

- the analytics engine
- the graph engine
- the vector store
- the search index
- the only persistence system

---

## Architectural Principles (Locked)

1. **Schema = concern boundary**
2. **Domains span schemas**
3. **Intake and ownership are separate**
4. **Identity is central**
5. **Projection awareness is required**
6. **Lineage is externalized**
7. **Ingestion does not require canonical first**

---

## Schema Set (Confirmed)

### Platform Schemas

- `reference`
- `source`
- `lake`
- `canonical`
- `lineage`
- `artifact`
- `operation`
- `workflow`
- `notification`
- `annotation`

### System Schemas

- `public`
- `iceberg`

---

## Key Clarification

### The Database Exists to Support the Application

WoodOps is a **.NET application platform**, not just a data system.

The database must support:

- ingestion
- canonical data
- application execution
- workflow
- human interaction
- output generation
- external projection

This is not a “data lake only” design.

---

## Critical Design Correction

Schemas are **NOT**:

- UI modules
- application screens
- service boundaries

Schemas are:

- **durable responsibility boundaries**

The .NET application layer composes across schemas.

---

## Schema Roles in the Platform

### `reference` — Semantic Standards

**Purpose**
- Controlled vocabulary
- Standardized meaning
- Units and definitions

**Supports Application**
- UI picklists
- validation rules
- shared interpretation of data

**Must NOT contain**
- source systems
- configuration
- mappings tied to specific systems

---

### `source` — Source Registry & Mapping

**Purpose**
- source system registration
- source identity tracking
- source-specific mapping

**Supports Application**
- ingestion configuration
- traceability of source origin
- mapping external fields to internal meaning

---

### `lake` — Intake Zone

**Purpose**
- landed raw data
- pre-canonical storage

**Supports Application**
- ingestion inspection
- replay/debug capability
- staging before normalization

---

### `canonical` — Platform-Owned Data

**Purpose**
- normalized entities
- platform identity
- cross-source unified records

**Supports Application**
- primary read/write layer for business objects
- stable application data model

---

### `lineage` — Provenance & Traceability

**Purpose**
- track transformations
- track derivation chains
- explain data origin

**Supports Application**
- auditing
- explainability
- trust in derived values

---

### `artifact` — Produced Outputs

**Purpose**
- generated files
- reports
- snapshots
- documents

**Supports Application**
- export features
- reporting outputs
- persisted generated content

---

### `operation` — Internal Execution State

**Purpose**
- jobs
- commands
- execution events

**Supports Application**
- background processing
- system actions
- execution tracking

---

### `workflow` — Process Orchestration

**Purpose**
- multi-step processes
- approval flows
- task coordination

**Supports Application**
- business workflows
- state transitions
- user-driven processes

---

### `notification` — Outbound Communication

**Purpose**
- alerts
- delivery tracking
- notification routing

**Supports Application**
- user alerts
- system messaging
- delivery auditing

---

### `annotation` — Human Interaction Layer

**Purpose**
- comments
- flags
- reviews
- interpretations

**Supports Application**
- human-in-the-loop workflows
- data enrichment
- review processes

---

## Why This Supports the Application Layer

The application layer does not require schemas to match modules.

Instead:

- UI composes across `canonical`, `annotation`, `reference`
- workflows interact with `workflow`, `operation`, `notification`
- ingestion interfaces use `source` and `lake`
- outputs use `artifact`
- traceability uses `lineage`

This allows:

- flexible application composition
- multiple application surfaces over time
- separation of concerns

---

## What Would Break the Model

### 1. Making Schemas Match UI or Services

Incorrect:
- `quality_schema`
- `kiln_schema`
- `inventory_schema`

This ties persistence to UI and limits evolution.

---

### 2. Polluting `reference`

If `reference` becomes:

- config store
- shared junk drawer
- source mapping container

Then semantic integrity is lost.

---

### 3. Misusing `source` as Data Storage

If raw ingestion records accumulate in `source` instead of `lake`, intake boundaries collapse.

---

### 4. Overloading `canonical`

If `canonical` absorbs:

- lineage
- workflow state
- operational events

Then it becomes a monolith and loses clarity.

---

### 5. Keeping App State Outside Postgres

If workflow, operations, or annotations are stored outside the database:

- the database stops supporting the application
- state becomes fragmented
- traceability breaks

---

### 6. Treating `canonical` as Read-Only

If `canonical` is treated as a warehouse:

- application write capability is lost
- platform ownership disappears

---

## Correct Mental Model

### The Database

- is a **platform persistence layer**
- supports **both application and data**
- enforces **durable boundaries**

### The Application (.NET)

- composes across schemas
- defines behavior, not storage boundaries
- orchestrates reads/writes across concerns

---

## Validation Statement

The current schema architecture:

- aligns with the WoodOps platform model
- supports application execution
- supports ingestion and canonicalization
- supports projection to other systems
- maintains separation of concerns

## Status

**VALID — aligned with big picture**

---

## Forward Constraint

This alignment only holds if:

- table design respects schema boundaries
- schemas are not repurposed for convenience
- application structure does not dictate persistence structure

The next phase (table emergence) is where this can still fail.

Maintain discipline.
