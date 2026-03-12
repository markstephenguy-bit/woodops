# SOLUTION_COMPOSITION_MODEL.md

## Purpose

This document defines how **business solutions are created on top of the WoodOps platform**.

WoodOps does not aim to provide pre-built business applications.

Instead, solutions are created by **composing platform capabilities**.

---

# Solution Philosophy

A solution should be built using the smallest possible amount of new code.

The preferred hierarchy is:

1. capability composition
2. thin extensions
3. platform capability additions
4. new standalone systems (rare)

---

# Composition Pattern

A typical solution is composed from the following building blocks.


Integration
↓
Object normalization
↓
Event generation
↓
Worker processing
↓
Projection / storage
↓
Portal or API exposure


This pattern forms the **standard operational pipeline**.

---

# Example Composition

Example: kiln drying analysis.

Possible composition:


Integration → kiln controller data
Object model → kiln charge object
Event → kiln charge completed
Worker → moisture analysis
Projection → drying performance dataset
Portal → analytics dashboard


No new application is created.

---

# Thin Extension Model

Some problems require small additions.

Examples:

- new integration adapter
- new worker
- new projection
- small portal component

These additions should remain **narrow in scope**.

They should avoid creating separate runtime environments.

---

# Platform Capability Expansion

Occasionally a problem reveals a missing **general capability**.

Examples:

- rule engine
- scheduling framework
- reconciliation engine
- workflow orchestration

When this occurs, the capability should be added to the platform itself.

Future solutions can then reuse it.

---

# Anti-Pattern: Application Per Problem

The following pattern should be avoided:


problem
↓
new application
↓
duplicate infrastructure


Consequences include:

- duplicated integrations
- duplicated data pipelines
- duplicated authentication
- operational fragmentation
- maintenance complexity

The platform model avoids these issues.

---

# Composition Workflow

When a new problem appears, use the following evaluation process.

### Step 1 — Define the problem shape

Identify:

- inputs
- outputs
- triggers
- required transformations

---

### Step 2 — Identify required capabilities

Map the problem to platform capabilities such as:

- integration
- events
- workers
- projections
- portal views

---

### Step 3 — Compose the solution

Construct the solution using existing platform capabilities.

---

### Step 4 — Identify gaps

If a capability is missing:

- implement a thin extension
- or expand the platform capability surface.

---

### Step 5 — Deliver the solution

Expose results through:

- portal interfaces
- APIs
- operational alerts
- data projections

---

# Architectural Discipline

A new standalone application should only be created if:

1. The problem cannot be solved using platform capabilities.
2. The problem represents a completely separate domain.
3. The system requires independent operational infrastructure.

These situations should be **rare**.

---

# Long-Term Goal

Over time, WoodOps should accumulate a broad capability surface.

As capability coverage grows, the need to build new applications should steadily decrease.

The platform becomes a **general operational problem-solving environment**.
