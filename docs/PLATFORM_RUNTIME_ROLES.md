# PLATFORM_RUNTIME_ROLES

This document defines the responsibilities and boundaries of the runtime components in the WoodOps platform.

These definitions replace the per-project `PROJECT_CONTEXT.md` files and act as the authoritative reference for runtime responsibilities.

---

# Runtime Components

The WoodOps platform is executed through three runtime components:

Portal  
Host  
Workers

All platform capabilities and core abstractions are implemented in:

WoodOps.Shared

The runtime components host and execute those capabilities.

---

# WoodOps.Host

WoodOps.Host is the **primary runtime host of the platform**.

It exposes platform capabilities to external systems and user interfaces.

## Responsibilities

Host is responsible for:

- exposing platform APIs
- composing platform services through dependency injection
- initializing the platform runtime
- loading configuration
- registering integrations and processors
- exposing operational endpoints
- coordinating runtime infrastructure

Host acts as the **entry point to the platform** for:

- the Portal UI
- external automation
- analytics systems
- integration tools
- operational scripts

Controllers should remain thin and delegate logic to platform services implemented in `WoodOps.Shared`.

## Boundary

Host must **not implement platform logic**.

Host should not contain:

- domain models
- integration translation logic
- processing algorithms
- projection logic
- business workflows

These belong to the shared platform capability layer.

Host is responsible for **exposing and composing capabilities**, not implementing them.

---

# WoodOps.Portal

WoodOps.Portal is the **presentation layer** of the platform.

It provides the primary user interface for interacting with platform capabilities.

## Responsibilities

Portal is responsible for:

- dashboards
- operational visualization
- navigation and layout
- user interaction workflows
- operational control surfaces
- data visualization

Portal translates user interaction into API requests directed to the platform host.

## Boundary

Portal must **not contain platform logic**.

Portal should not implement:

- business processing
- platform models
- persistence logic
- integration logic
- processing pipelines

All operational behavior originates from services exposed by `WoodOps.Host`.

Portal is a **consumer of platform capabilities**.

---

# WoodOps.Workers

WoodOps.Workers is the **background execution runtime** of the platform.

Workers execute asynchronous and scheduled processing tasks.

## Responsibilities

Workers execute:

- ingestion pipelines
- scheduled jobs
- integration polling
- background data processing
- event-driven processing
- operational automation tasks

Workers allow the platform to operate continuously without user interaction.

## Boundary

Workers should **execute platform capabilities but not define them**.

Workers should not implement:

- platform kernel models
- core capability primitives
- integration translation logic
- UI behavior
- API controllers

Workers run processing logic defined in the shared platform capability layer.

---

# WoodOps.Shared

WoodOps.Shared is the **platform capability library**.

It contains the reusable primitives and mechanisms used by all runtime components.

## Responsibilities

Shared provides:

- platform kernel primitives
- object and envelope structures
- processing contracts
- integration adapters
- projection mechanisms
- intelligence capabilities
- governance and policy enforcement
- observability mechanisms

All runtime projects depend on this library.

Shared contains **no runtime entrypoints**.

---

# Kernel Layer

Inside the shared library exists a **protected kernel layer**.

This layer defines the most stable primitives of the platform.

Examples include:

- identity primitives
- envelope structures
- relationship models
- event records
- processing contracts
- projection contracts

Kernel components must remain:

- stable
- domain neutral
- dependency light

Other platform capabilities may depend on the kernel, but the kernel must not depend on them.

---

# Capability Areas

The shared library organizes platform functionality into capability areas.

Typical areas include:

Kernel  
Model  
Relationships  
Processing  
Projection  
Integrations  
Intelligence  
Security  
Observability

These are logical partitions implemented through namespaces and folders.

They are **not separate assemblies**.

---

# Dependency Direction

Dependency flow inside the platform must follow this direction:

Shared  
↑  
Workers  
↑  
Host  
↑  
Portal

Rules:

Shared must not depend on runtime projects.

Workers may depend on Shared.

Host may depend on Shared and Workers.

Portal should interact with the platform primarily through Host APIs.

---

# Architectural Principle

WoodOps is a **capability-first platform**.

Platform capabilities are implemented in the shared library.

Runtime components exist only to host, execute, and expose those capabilities.

New operational problems should be solved by **composing existing platform capabilities** rather than creating separate applications.
