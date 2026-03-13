# PROJECT_STRUCTURE

This document defines the **current WoodOps solution composition** and the responsibility of each project.

It is the authoritative reference for repository structure.

---

# Solution Layout


src/

WoodOps.Host
WoodOps.Portal
WoodOps.Workers
WoodOps.Shared


---

# Project Responsibilities

## WoodOps.Host

Runtime host for the platform.

Responsibilities:

- platform runtime bootstrapping
- service composition
- configuration loading
- environment setup
- infrastructure initialization

The host is responsible for **starting the platform runtime**.

---

## WoodOps.Portal

User interface for interacting with the platform.

Responsibilities:

- operational dashboards
- platform configuration
- platform data visualization
- human interaction with platform capabilities

The portal does **not implement platform capabilities**.

It consumes services exposed by the platform.

---

## WoodOps.Workers

Background processing runtime.

Responsibilities:

- asynchronous processing
- data transformation
- pipeline execution
- integration polling
- event processing

Workers execute **platform capabilities defined in Shared**.

---

## WoodOps.Shared

Shared platform kernel and capability library.

Responsibilities:

- core platform abstractions
- envelope definitions
- contracts
- integration adapters
- capability implementations

Shared contains **no runtime entrypoints**.

It is a pure platform library.

---

# Internal Structure of Shared

Example internal organization:


WoodOps.Shared/

Kernel/
Platform/
Contracts/
Envelopes/
Integrations/
Intelligence/


These are **namespaces and folders**, not separate projects.

---

# Dependency Direction

Allowed dependency flow:


Shared
↑
Workers
↑
Host
↑
Portal


Rules:

- Shared must not depend on other projects
- Workers may depend on Shared
- Host may depend on Shared and Workers
- Portal may depend on platform APIs only

---

# Architectural Principle

WoodOps is a **capability platform**.

Capabilities are implemented in:


WoodOps.Shared


Runtimes execute those capabilities through:


Host
Workers
Portal
