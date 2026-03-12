# RELATIONSHIP_MODEL.md

## Purpose

This document defines the **canonical relationship model** used by the WoodOps platform.

While the **Envelope model** defines how objects exist independently, the **Relationship Model** defines how those objects connect to form operational meaning.

Relationships are **first-class architectural constructs**.

They enable the platform to behave as a **document + graph hybrid system**, allowing objects to be connected, traced, interpreted, and reasoned about without embedding domain assumptions into the kernel.

This model must remain **stable and generic** because many higher-level platform capabilities depend on it:

- processing pipelines
- projections
- workflow routing
- intelligence reasoning
- portal navigation
- provenance tracing

---

# Relationship Philosophy

The WoodOps kernel does not embed domain-specific structures.

Instead, operational meaning emerges from:


Envelope<T>
+
Relationships
+
Processing
+
Projection


Relationships connect otherwise independent objects into meaningful operational structures.

Examples:

- an inspection referencing a machine
- a sensor observation linked to a production batch
- a training record connected to a worker
- an anomaly derived from telemetry
- a report referencing evidence

These connections must exist outside the payload so that they can be:

- queried
- traversed
- reasoned about
- visualized
- validated

---

# Core Relationship Primitive

Relationships are represented by the **Edge** object.

Conceptual structure:


Edge
{
Id
FromId
ToId
RelationshipType
Source
Authority
CreatedAt
Metadata
}


Edges connect two kernel objects.

Both endpoints must reference **existing envelope identities**.

---

# Edge Field Definitions

## Id

Unique identifier for the relationship.

Requirements:

- globally unique
- immutable
- suitable for persistence key

Recommended implementation:


GUID / ULID


---

## FromId

Identifier of the **source object** in the relationship.

Represents the origin node in the graph.

Example:


Inspection → Machine


Inspection envelope ID would be `FromId`.

---

## ToId

Identifier of the **target object**.

Represents the destination node in the graph.

Example:


Inspection → Machine


Machine envelope ID would be `ToId`.

---

## RelationshipType

Describes the meaning of the relationship.

Examples:


references
derived-from
attached-to
belongs-to
evidence-for
observed-at
performed-by
affects
precedes
supersedes


RelationshipType must remain **flexible and extensible**.

The kernel must not depend on specific relationship types.

---

## Source

Indicates which system created the relationship.

Examples:


WoodOps
MES
ERP
IntegrationAdapter
IntelligenceProcessor
UserAction


This supports provenance tracing.

---

## Authority

Indicates which system is authoritative for the relationship.

Values:


External
WoodOps
Derived
Mixed


This affects reconciliation and update permissions.

---

## CreatedAt

Timestamp indicating when the relationship was established.

Used for:

- timeline analysis
- event reconstruction
- relationship versioning

---

## Metadata

Optional structure providing additional contextual information about the relationship.

Examples:


confidence score
relationship explanation
source identifier
relationship weight
processing notes


Metadata must remain optional and extensible.

---

# Relationship Direction

Relationships are **directed edges**.


FromId → ToId


Direction allows the system to represent:

- causality
- lineage
- ownership
- hierarchy
- flow

However, many queries may treat relationships as bidirectional for exploration purposes.

---

# Relationship Cardinality

The platform must support flexible relationship cardinalities.

Examples:

### One-to-One


Envelope A → Envelope B


Example:


Inspection → InspectionReport


---

### One-to-Many


Envelope A → Envelope B1
Envelope A → Envelope B2
Envelope A → Envelope B3


Example:


Batch → Observation


---

### Many-to-Many


Envelope A → Envelope B
Envelope C → Envelope B
Envelope A → Envelope D


Example:


Machine ↔ Inspection


---

# Relationship Categories

Relationships can broadly fall into several conceptual categories.

These categories are **not enforced by the kernel** but help guide interpretation.

---

## Reference Relationships

Simple links between objects.

Examples:


references
attached-to
linked-to


Example:


ShiftReport → Inspection


---

## Hierarchical Relationships

Represents containment or hierarchy.

Examples:


belongs-to
part-of
contains


Example:


Machine → ProductionLine
ProductionLine → Mill


---

## Lineage Relationships

Represents derivation or transformation.

Examples:


derived-from
transformed-from
aggregated-from


Example:


Anomaly → SensorObservation


---

## Evidence Relationships

Represents supporting information.

Examples:


evidence-for
supports
documents


Example:


Photo → Inspection


---

## Temporal Relationships

Represents sequence or progression.

Examples:


precedes
follows
supersedes


Example:


Inspection_v2 → supersedes → Inspection_v1


---

## Actor Relationships

Represents human or system involvement.

Examples:


performed-by
approved-by
generated-by


Example:


Inspection → performed-by → Operator


---

# Relationship Creation Sources

Relationships may originate from several sources.

---

## Integration Adapters

External data sources may include relationships.

Example:


MES record linking machine and production batch


Adapters must translate these into platform edges.

---

## Processing Pipelines

Processing stages may create relationships.

Examples:


analysis result → derived-from → observation
alert → triggered-by → event


---

## User Interaction

Portal actions may create relationships.

Examples:


attach photo to inspection
link document to issue
associate training with worker


---

## Intelligence Services

AI pipelines may infer relationships.

Examples:


knowledge document → references → inspection
incident summary → derived-from → events


These relationships may include **confidence metadata**.

---

# Relationship Integrity

Several integrity rules must be enforced.

---

## Rule 1

Relationships must reference **valid envelope identities**.

Invalid references must not persist.

---

## Rule 2

Relationships must be immutable once persisted unless versioned.

Relationship changes should normally produce **new edges**.

---

## Rule 3

Payload data must not be the primary location for object linking.

Canonical relationships must exist as edges.

---

## Rule 4

External system semantics must not define relationship structure in the kernel.

Adapters must translate foreign relationships into generic edge types.

---

# Relationship Querying

The relationship model enables graph-style traversal queries.

Examples:

Find all inspections linked to a machine.


Machine → Inspection


Find the evidence for an issue.


Issue → Evidence


Find the lineage of a derived object.


DerivedObject → derived-from → SourceObjects


Query capabilities may include:

- depth traversal
- relationship filtering
- path discovery
- subgraph extraction

---

# Relationship Use in Processing

Processing pipelines may use relationships for:

- context expansion
- dependency evaluation
- evidence aggregation
- lineage tracing

Example pipeline:


SensorObservation
→ anomaly detection
→ anomaly envelope
→ derived-from relationship created


---

# Relationship Use in Intelligence

AI and semantic reasoning systems depend heavily on relationships.

Examples:

- context retrieval
- document linking
- operational reasoning
- anomaly explanation

Relationships enable the platform to construct **context graphs**.

---

# Relationship Use in the Portal

The portal may use relationships for:

- navigation between related objects
- graph visualization
- evidence exploration
- operational drill-down

Example:


Inspection
→ Machine
→ ProductionLine
→ Shift


Users can traverse operational context through relationships.

---

# Persistence Considerations

Persistence systems must support efficient relationship storage and traversal.

Key capabilities:

- index by `FromId`
- index by `ToId`
- filter by `RelationshipType`
- support graph traversal queries

Possible storage models:

- relational edge tables
- graph databases
- document stores with edge collections

Implementation technology is not mandated by this specification.

---

# Architectural Guardrails

The relationship model must obey the following rules.

### Rule 1

Relationships are **first-class objects**, not payload decorations.

### Rule 2

Relationship types must remain **flexible and extensible**.

### Rule 3

External system semantics must not shape the kernel.

### Rule 4

All relationships must reference **stable object identities**.

### Rule 5

Relationships must support lineage, hierarchy, and evidence structures.

---

# Summary

The WoodOps relationship model treats connections between objects as **first-class graph edges**.

Conceptually:


Envelope<T>
+
Edge


Edges allow the platform to represent:

- operational structure
- lineage
- evidence
- hierarchy
- actor involvement
- temporal sequencing

Together with the envelope model, this forms the **structural substrate of the WoodOps platform**.

All higher-level capabilities are constructed on top of this object and relationship graph.