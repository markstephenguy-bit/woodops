```markdown
# WoodOps.Shared — PROJECT_CONTEXT.md

## Purpose

`WoodOps.Shared` is the **single shared library for the WoodOps platform**.

It contains the reusable platform capabilities, primitives, and abstractions used by all WoodOps runtime components.

All executable projects depend on this library.

Examples of runtime projects that consume this library include:

- `WoodOps.Host`
- `WoodOps.Workers`
- `WoodOps.Portal`

This library represents the **platform capability layer**, not a specific application or business system.

---

# Architectural Role

`WoodOps.Shared` provides the **generic operational capabilities** used to solve many kinds of problems across different operational domains.

The platform is intentionally **not designed around specific business processes**.

Instead, it provides capabilities that allow new problems to be solved through **composition of existing mechanisms** rather than building a new application.

This supports the WoodOps design principle:

> Solve new operational problems by composing platform capabilities, not by creating separate applications.

---

# Design Philosophy

The library follows several architectural principles.

## Capability-first platform

The platform exposes reusable capabilities such as:

- object modeling
- event processing
- worker pipelines
- projections and views
- integrations
- intelligence and analysis
- policy enforcement
- scheduling
- observability

Solutions are constructed by combining these capabilities.

---

## Domain-agnostic kernel

The platform core must remain **domain neutral**.

The library must not encode:

- lumber mill process assumptions
- MES-specific models
- ERP-specific logic
- operational workflows tied to one environment

Business models belong in **solution composition layers**, not the platform kernel.

---

## Composition over application creation

When a new operational problem appears, the expected workflow is:

1. Identify the required capabilities
2. Compose them using platform mechanisms
3. Add small extensions only if necessary

Creating a completely new application should be rare.

---

# Internal Structure

The library is organized into logical capability areas using namespaces and folders.

Example structure:

```

WoodOps.Shared
Kernel/
Model/
Relationships/
Processing/
Projection/
Integrations/
Intelligence/
Security/
Observability/

```

These represent **logical capability partitions**, not separate assemblies.

---

# Kernel Boundary

Inside the shared library there exists a **protected kernel layer**.

This layer contains the most stable and foundational primitives of the platform.

Examples include:

- identity primitives
- envelope structures
- relationship models
- event records
- processing contracts
- projection contracts
- authority and provenance models

These primitives must remain:

- stable
- dependency-light
- domain-agnostic

Other capability areas may depend on the kernel, but the kernel must not depend on them.

---

# Integrations Capability

The integrations capability provides mechanisms for interacting with external systems.

Responsibilities include:

- external protocol adapters
- API clients
- file and database connectors
- translation of external payloads into platform objects

External systems may include:

- MES
- ERP
- CMMS
- external APIs
- file systems
- message queues

Integration logic should translate foreign data into platform models without allowing external semantics to contaminate the kernel.

---

# Intelligence Capability

The intelligence capability provides mechanisms for analyzing and enriching operational data.

Examples include:

- statistical analysis
- anomaly detection
- forecasting
- semantic enrichment
- machine learning integration
- AI-assisted reasoning

These capabilities operate on normalized platform objects but do not define the core platform model.

---

# Processing Capability

Processing mechanisms enable the platform to perform operational tasks.

Examples include:

- background workers
- data transformation
- event processing
- workflow execution
- reconciliation
- scheduled jobs

Processing capabilities are typically executed by the `WoodOps.Workers` runtime.

---

# Projection Capability

Projection mechanisms allow the platform to create derived representations of operational data.

Examples include:

- queryable read models
- analytics datasets
- dashboards
- operational views

These projections support both the portal UI and external analytics systems.

---

# Security and Governance

The platform must support governance features such as:

- access control
- data authority tracking
- provenance
- auditing
- operational policy enforcement

These mechanisms ensure operational traceability and system safety.

---

# Observability

The platform must expose operational visibility mechanisms.

Examples include:

- system health metrics
- event tracing
- processing logs
- audit records
- performance telemetry

These capabilities support monitoring and diagnostics of the WoodOps environment.

---

# Dependency Rules

`WoodOps.Shared` must remain usable by all runtime components.

Therefore it must avoid unnecessary dependencies.

The shared library should not depend on:

- UI frameworks
- runtime host frameworks
- application-specific logic

External integrations and intelligence components may introduce dependencies, but they should remain isolated within their capability areas.

---

# Relationship to Runtime Projects

Runtime projects host the execution environments that use the shared capabilities.

Typical responsibilities:

## WoodOps.Host

Platform control plane and API surface.

Provides:

- system APIs
- configuration
- orchestration endpoints
- operational health interfaces

---

## WoodOps.Workers

Background processing environment.

Executes:

- ingestion pipelines
- scheduled tasks
- analysis workflows
- integration processing

---

## WoodOps.Portal

User interaction interface.

Provides:

- dashboards
- operational views
- system management tools
- interaction surfaces for platform capabilities

---

# Architectural Goal

Over time the WoodOps platform should accumulate a broad set of reusable operational capabilities.

As capability coverage expands, the need to create new applications for individual problems should decrease.

The platform becomes a **general operational problem-solving environment**.

New solutions should primarily be created through **capability composition** rather than application development.
```

