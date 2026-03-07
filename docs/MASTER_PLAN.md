# MASTER_PLAN.md

## Purpose

This document is the working master plan for the early development of WoodOps.

It exists to guide greenfield development before the system has matured enough for detailed roadmaps, stable domain boundaries, or extensive project decomposition.

This file should help answer:

- what WoodOps is intended to become
- what problem space it serves
- how early work should be prioritized
- what constraints should govern decisions
- what has been decided
- what remains intentionally open

This document is expected to be appended over time.
Earlier entries are part of the historical reasoning trail.
Newer entries may refine direction, but should not silently erase prior intent.

---

## Role of WoodOps

WoodOps is a lightweight operational application platform for wood products manufacturing operations.

It is intended to fill ad hoc and underserved needs that are not well handled by existing enterprise systems.

WoodOps is not the system of record for the major business domains already covered by enterprise platforms.

Instead, it provides targeted applications, utilities, workflows, and decision-support tools that can integrate with those systems where needed.

---

## Existing Enterprise System Context

WoodOps exists alongside established systems such as:

- MES
- ERP
- O365 suite
- CMMS
- vendor or machine-specific systems
- plant databases and exports

These systems remain authoritative in their own domains.

WoodOps should integrate with them when useful, but should not casually duplicate their responsibilities.

### Authority boundaries

Typical default understanding:

- MES is authoritative for production execution and plant operational state where implemented
- ERP is authoritative for business, inventory, and planning functions
- CMMS is authoritative for maintenance management
- O365 is authoritative for collaboration, forms, and general office workflows
- vendor systems are authoritative for their specialized machine or process areas unless replaced deliberately

WoodOps should only take on responsibility where there is a clear operational gap, integration need, engineering need, or custom utility need.

---

## What WoodOps Is Not

WoodOps should not begin by trying to become:

- a replacement MES
- a replacement ERP
- a replacement CMMS
- a generic workflow engine
- a large internal framework without proven need
- a speculative platform built ahead of real use cases

If the system starts absorbing broad responsibilities already owned elsewhere, that is architectural drift and should be challenged directly.

---

## Greenfield Development Posture

Early development should be disciplined by the following principles:

1. Build for real operational gaps
2. Prefer narrow useful tools over broad speculative platforms
3. Keep integration boundaries explicit
4. Keep UI, application logic, and integration concerns separate
5. Preserve the ability to grow without forcing premature architecture
6. Let real use cases reveal reusable patterns
7. Promote stable patterns only after repetition proves them necessary

WoodOps should start as a small number of well-aimed capabilities, not as a theoretical enterprise platform.

---

## Initial Strategic Objective

The first stage of WoodOps should establish a stable base for building operational tools that:

- solve real ad hoc problems
- integrate with existing systems when needed
- can be delivered quickly
- do not create uncontrolled architectural debt
- can accumulate into a coherent platform over time

The early objective is not scale for its own sake.
The objective is disciplined usefulness.

---

## Early Success Criteria

WoodOps is succeeding in the early stage if it can do the following:

- host one or more useful operational tools
- connect to external systems in a controlled way
- avoid duplicating enterprise responsibilities
- maintain a clean enough structure that new tools do not become chaos
- support incremental extension without major rewrites
- preserve enough architectural clarity for later formalization

---

## First Principles for Prioritization

When deciding whether WoodOps should own a capability, prefer work that meets one or more of these conditions:

- existing enterprise systems do not solve it well
- the solution is highly site-specific or process-specific
- the need is urgent but too small for enterprise prioritization
- the work mainly requires integration, visibility, or light workflow support
- the users are operational, engineering, quality, or technical support roles needing focused tools
- the solution can be built and validated incrementally

Avoid work that primarily belongs in another enterprise platform unless WoodOps is serving only as a bridge, view, or utility layer.

---

## Initial Architectural Intent

At the beginning, WoodOps should be developed as a small application platform with clear internal boundaries.

The exact project structure should remain aligned with the repository and architecture documentation, but the conceptual model should remain close to:

- host application / portal
- shared tool surface
- integration boundary
- common supporting services
- optional lightweight persistence where needed

The architecture should support multiple tools without requiring every tool to become its own separate system.

At the same time, the architecture should avoid over-centralizing logic into one uncontrolled application layer.

---

## Tool-First Development Model

WoodOps should initially grow through tools or capabilities that are:

- operationally meaningful
- bounded in scope
- integration-aware
- independently understandable
- valuable on their own

Each tool should answer:

- what operational problem it solves
- who uses it
- what systems it reads from
- what systems it writes to, if any
- what data it owns, if any
- what system remains authoritative for the underlying domain

A tool should not be added unless these points can be stated clearly.

---

## Integration Philosophy

Integration should be treated as a first-class concern.

WoodOps will often be valuable because it can connect systems that do not naturally work together in the way operations or engineering needs.

Integration design expectations:

- external system boundaries should be explicit
- adapters/connectors should not silently absorb business rules
- the authoritative source for each data element should be understood
- local caching or persistence should be justified, not assumed
- writeback behavior should be deliberate and constrained
- temporary imports and exports should still be designed cleanly

---

## Data Ownership Guidance

Before storing or generating data in WoodOps, determine which category applies:

### External authoritative data
Data owned by MES, ERP, CMMS, O365, or a vendor system.
WoodOps may read, transform, display, correlate, or lightly annotate it, but should not silently become the new source of truth.

### WoodOps-managed operational data
Data that exists only because WoodOps provides a capability not covered elsewhere.
Examples may include tool settings, user annotations, derived analysis state, reconciliation state, or workflow support records.

### Derived data
Computed results, views, alerts, rollups, correlations, and diagnostics created by WoodOps from external or mixed sources.

The category should be understood early for each feature.

---

## Early Repository Working Rules

Until the architecture matures further, early repository work should follow these rules:

- prefer incremental additions over structural churn
- keep responsibilities separated
- do not introduce large frameworks without repeated evidence of need
- use repository documentation as the authoritative reference
- preserve naming consistency
- keep tools understandable and independently testable
- document important architectural decisions when they change the project direction

---

## Recommended Early Work Sequence

### Stage 1 — Establish working baseline
- confirm the repository builds and runs
- confirm the portal or host application is the usable starting shell
- confirm current architecture documents and AI guidance documents are in place

### Stage 2 — Define the first real tool candidates
For each candidate, capture:
- problem
- users
- source systems
- outputs
- authority boundaries
- expected value

### Stage 3 — Establish integration pattern
Define how WoodOps will connect to:
- databases
- APIs
- files
- manual input
- background jobs if needed

This should be simple and explicit.

### Stage 4 — Build the first tool end-to-end
Choose one bounded operational need and implement it fully enough to validate:
- host structure
- integration pattern
- deployment approach
- maintainability of the code organization

### Stage 5 — Generalize only where repetition exists
After one or two tools exist, identify repeated patterns and promote only those into shared abstractions.

---

## Candidate Early Tool Types

These are categories, not commitments:

- engineering analysis tools
- process troubleshooting dashboards
- quality investigation utilities
- ad hoc operational reporting tools
- reconciliation or exception tracking tools
- data extraction and transformation utilities
- visibility layers over existing system data
- targeted workflow aids for operational gaps

A candidate is stronger if it solves a clear pain point without overlapping heavily with enterprise system ownership.

---

## Decision Filter for New Work

Before starting a new feature or tool, answer:

1. What exact problem is being solved?
2. Who is the user?
3. Why is this not already best handled in MES, ERP, CMMS, O365, or the vendor system?
4. What systems must WoodOps integrate with?
5. What data is authoritative externally?
6. What data, if any, will WoodOps own?
7. Is this a one-off utility, a reusable capability, or the start of a broader module?
8. What is the smallest useful version?

If these questions cannot be answered, the work is not yet ready.

---

## Architectural Guardrails

The following should be challenged immediately if they appear:

- WoodOps taking ownership of major domains already covered elsewhere
- portal/UI code absorbing deep operational logic
- integration adapters becoming unbounded business logic containers
- speculative abstractions created before repeated need
- storing large replicated copies of enterprise data without clear purpose
- building a framework before proving real tool demand
- broad platform language without an actual operational use case behind it

---

## Open Questions

This section should be appended as real uncertainty becomes visible.

Examples:
- What kinds of operational tools are expected most often?
- Will most tools be read-only, read-mostly, or transactional?
- Is there a preferred deployment target for the earliest usable versions?
- What authentication and authorization assumptions should govern early internal use?
- What degree of shared UI shell should tools have?
- What degree of local persistence is justified in phase 1?

Do not force answers too early.
Capture the questions and resolve them when evidence exists.

---

## Decisions Log

Append decisions here in compact form.

### Decision template

- Date:
- Topic:
- Decision:
- Reason:
- Impact:

### Entries

- Date:
- Topic:
- Decision:
- Reason:
- Impact:

---

## Near-Term Plan

This section should reflect the current working horizon only.

Initial near-term intent:

- establish the repository baseline
- define the first real tool candidates
- choose one bounded tool for first implementation
- establish the minimum integration pattern needed to support that tool
- validate that WoodOps can host and deliver small operational capabilities cleanly

This section can be revised as work progresses.

---

## Append-Only Working Notes

Use this section for short planning increments that should remain part of the reasoning trail.

### Entry template

- Date:
- Context:
- Observation:
- Action:
- Follow-up:
