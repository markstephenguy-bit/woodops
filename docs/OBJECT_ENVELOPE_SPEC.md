# OBJECT_ENVELOPE_SPEC.md

## Purpose

This document defines the **canonical envelope structure** used throughout the WoodOps platform.

All operational data entering, created within, or derived by the platform must ultimately be represented as an **Envelope**.

The envelope provides system context around arbitrary payload data.

Conceptually:

Envelope<T>

The envelope is responsible for:

- identity
- provenance
- authority
- classification
- relationships
- access control
- versioning
- temporal semantics

The payload contains the operational content.

The envelope contains the **platform context required to safely operate on that content**.

---

# Canonical Envelope Structure

Minimum conceptual structure:


Envelope
{
Id
Kind
Classification
SchemaRef
Source
Authority
Scope
CreatedAt
ModifiedAt
EffectiveAt
Payload
Provenance
Relationships
Annotations
Version
Access
Tags
}


This structure must remain stable once platform persistence begins.

---

# Envelope Field Definitions

## Id

Unique identifier for the object.

Requirements:

- globally unique
- stable for object lifetime
- suitable for persistence key
- suitable for relationship targeting

Recommended implementation:


GUID / ULID


Id must never be reused.

---

## Kind

Defines the structural category of the object.

Examples:


Document
Event
Schema
FormDefinition
GridDefinition
QueryDefinition
WorkflowDefinition
ViewDefinition
AttachmentReference


Kind determines how the platform treats the object structurally.

Kind is **not business domain meaning**.

---

## Classification

Classification expresses domain interpretation.

Examples:


Inspection
ShiftReport
MachineObservation
QualityFinding
KnowledgeArticle
TrainingRecord
OperationalEvent


Classification is flexible and may evolve.

The kernel must not depend on specific classification values.

---

## SchemaRef

Reference to the schema that governs payload structure.

Purpose:

- validation
- interpretation
- UI rendering
- transformation

Example reference formats:


schema://inspection/v1
schema://machine-observation/v2
schema://knowledge-article/v1


Schemas should themselves exist as kernel objects.

---

## Source

Indicates the originating system.

Examples:


MES
ERP
CMMS
PLC
FileImport
SensorGateway
ManualEntry
WoodOps


Source is informational.

It must not affect kernel processing rules.

---

## Authority

Indicates the authoritative system for the object.

Values:


External
WoodOps
Derived
Mixed


Authority determines:

- whether the object may be edited
- whether synchronization is required
- whether reconciliation is needed

---

## Scope

Defines the contextual boundary in which the object exists.

Examples:


Site
Mill
Line
Machine
Shift
Team
Department
KnowledgeDomain
Course


Scope allows grouping without enforcing rigid domain models.

---

## CreatedAt

Timestamp representing object creation.

This represents **platform creation**, not necessarily source creation.

---

## ModifiedAt

Timestamp representing the last mutation of the envelope.

Used for:

- synchronization
- caching
- projections

---

## EffectiveAt

Domain-effective timestamp.

Examples:

- inspection time
- machine observation time
- report time

EffectiveAt allows temporal interpretation independent of ingestion time.

---

## Payload

The operational content.

Conceptually:


T


Payload should normally be represented as structured JSON-like data.

The kernel must treat payload as opaque.

Examples:

Inspection payload


{
inspector: "A. Smith",
boardCount: 250,
defectsObserved: 3
}


Sensor observation payload


{
sensorId: "MM-102",
moisture: 17.2,
temperature: 98.1
}


---

## Provenance

Provenance describes **how the object came to exist**.

Example structure:


Provenance
{
OriginSystem
OriginIdentifier
ImportMethod
ProcessorChain
Actor
ImportedAt
}


Provenance must support full traceability.

This is critical for:

- audit
- reconciliation
- AI reasoning

---

## Relationships

References to related objects.

Relationships should normally be materialized through **Edges**.

Example references:


belongs-to
attached-to
derived-from
evidence-for
observed-at
precedes
supersedes


Relationships must remain first-class.

Do not bury relationships inside payloads.

---

## Annotations

Supplemental metadata that does not alter payload.

Examples:


human review notes
AI summaries
processing flags
review comments
classification hints


Annotations allow incremental enrichment without payload mutation.

---

## Version

Envelope version.

Purpose:

- concurrency control
- audit history
- document evolution

Version should increment when the envelope or payload changes.

---

## Access

Access metadata describing visibility and permissions.

Examples:


roles allowed
site restrictions
sensitivity markers
classification security


Access rules should be interpreted by the Host security layer.

---

## Tags

Free-form labels used for grouping and discovery.

Examples:


kiln
inspection
shift-report
training
safety
maintenance


Tags should not replace classification.

---

# Envelope Lifecycle

Typical lifecycle:


Acquire
Normalize
Create Envelope
Persist
Process
Enrich
Relate
Project
Consume


Envelopes may evolve through processing pipelines but should retain identity.

---

# Envelope Creation Sources

Envelopes may originate from several sources.

## Integration

External systems.

Examples:


MES
ERP
CMMS
PLC
Files


---

## User Interaction

Objects created through forms in the portal.

Examples:


inspection forms
shift notes
quality findings
knowledge entries


---

## Derived Processing

Objects generated through processing pipelines.

Examples:


analysis results
aggregations
alerts
AI interpretations


Authority should typically be **Derived**.

---

# Persistence Guidance

Persistence systems must store:


Envelope metadata
Payload
Provenance
Relationships
Access metadata
Version history


Persistence technology is intentionally not mandated by this specification.

---

# Design Constraints

The envelope structure must obey several rules.

## Rule 1

Envelope structure must remain **small and stable**.

## Rule 2

Domain meaning belongs in **classification and payload**, not the kernel.

## Rule 3

Relationships must be first-class.

## Rule 4

External systems must normalize into envelopes.

## Rule 5

Business capabilities emerge from **processing and projection**, not envelope specialization.

---

# Summary

The Envelope is the fundamental object of the WoodOps platform.

Conceptually:


Envelope<T>


The envelope provides:

- identity
- provenance
- authority
- context
- relationships
- access control

The payload carries operational meaning.

All platform processing operates on envelopes and their relationships.