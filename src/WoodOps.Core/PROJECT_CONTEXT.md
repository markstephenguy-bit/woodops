# PROJECT_CONTEXT.md

## Project
WoodOps.Core

## Purpose
WoodOps.Core contains the foundational platform capabilities used by the WoodOps system.  
It provides the generic structures and operational primitives that all other components of the platform rely upon.

This project defines the canonical WoodOps model and the core processing capabilities that operate on it.

WoodOps.Core must remain **generic and domain-agnostic**.  
It is not responsible for implementing business workflows or specific operational capabilities.

---

## Architectural Role
WoodOps.Core acts as the **kernel library** of the WoodOps platform.

It provides:

• the canonical data structures used across the platform  
• core orchestration primitives  
• processing and projection mechanisms  
• foundational services used by runtime hosts and integrations  

All other WoodOps components depend on this project.

WoodOps.Core must never depend on:

• Integrations  
• Intelligence  
• UI projects  
• runtime hosts  

This ensures the kernel remains stable and reusable.

---

## Owns
WoodOps.Core owns the following architectural responsibilities:

### Canonical Model
Generic data structures used across the platform.

Examples:

- Envelope<T>
- Identity
- Metadata
- Provenance
- Classification
- Relationships
- Payload containers

These structures allow WoodOps to represent arbitrary operational data without embedding business semantics into the architecture.

---

### Kernel Coordination
Core orchestration primitives used by runtime hosts.

Examples:

- capability registration
- processing orchestration
- pipeline coordination
- system lifecycle support

---

### Processing Primitives
Generic mechanisms that operate on model objects.

Examples:

- processors
- transformation primitives
- evaluation pipelines
- workflow steps

Processing must remain generic and reusable.

---

### Projection Primitives
Structures for creating derived representations of model objects.

Examples:

- read models
- analytical views
- materialized projections
- reporting structures

Projections organize generic data for consumption but must not embed domain logic.

---

### Platform Services
Cross-cutting services required by the platform.

Examples:

- security primitives
- configuration structures
- observability hooks
- diagnostics interfaces

---

## Does Not Own

WoodOps.Core must **never contain**:

• integrations with external systems  
• UI components  
• API controllers  
• background job implementations  
• LLM integrations  
• external service clients  
• business-specific modules  

These responsibilities belong to other projects.

---

## Inputs
WoodOps.Core receives:

• normalized model objects produced by integrations  
• processing requests from runtime hosts  
• execution requests from workers  
• configuration supplied by runtime hosts

---

## Outputs
WoodOps.Core provides:

• model definitions used across the platform  
• processing and projection primitives  
• platform service interfaces  
• orchestration mechanisms used by hosts and workers

---

## Allowed Dependencies

WoodOps.Core may depend on:

• .NET standard libraries  
• minimal foundational utility libraries

Dependencies must remain lightweight.

---

## Dependency Restrictions

WoodOps.Core must **never depend on**:

• WoodOps.Integrations  
• WoodOps.Intelligence  
• WoodOps.Host  
• WoodOps.Portal  
• WoodOps.Workers  

These projects depend on the core kernel — never the reverse.

---

## Internal Namespace Guidance

Typical namespace layout inside this project should resemble:

WoodOps.Core.Model  
WoodOps.Core.Kernel  
WoodOps.Core.Persistence  
WoodOps.Core.Processing  
WoodOps.Core.Projection  
WoodOps.Core.Security  
WoodOps.Core.Configuration  
WoodOps.Core.Observability

Namespaces should remain **structural and capability-based**, not domain-based.

---

## Change Guidance

Changes to this project should be conservative.

Guidelines:

• avoid embedding domain knowledge  
• avoid coupling to external technologies  
• prioritize stability and reuse  
• prefer extension points over specialization  

Most feature work should occur in:

• Integrations  
• Intelligence  
• Workers  
• Host

---

## Notes

WoodOps.Core is the **long-term stability anchor** of the platform.

If designed correctly, the kernel should evolve slowly while capabilities expand around it.
