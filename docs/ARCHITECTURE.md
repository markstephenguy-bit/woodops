# ARCHITECTURE

This document defines the structural architecture of the WoodOps platform.

---

# Runtime Components

The system consists of three runtime components.


Portal
Host
Workers


All shared logic exists in the platform library:


WoodOps.Shared


---

# Component Responsibilities

## Portal

Human interaction layer.

Provides:

- dashboards
- administrative interfaces
- operational tooling.

---

## Host

Primary platform runtime.

Responsibilities:

- platform initialization
- service composition
- runtime orchestration
- API hosting.

---

## Workers

Background execution runtime.

Responsibilities:

- pipeline processing
- integration polling
- transformation jobs
- asynchronous processing.

Workers execute platform capabilities defined in Shared.

---

# Shared Platform Library

All platform logic exists in:


WoodOps.Shared


Examples:

- platform abstractions
- object envelopes
- integration adapters
- domain contracts
- processing pipelines.

---

# Architectural Layers


Portal
↓
Host
↓
Workers
↓
Shared Platform Kernel


Shared is the lowest layer.

---

# Key Architectural Constraints

Shared must remain:

- runtime independent
- infrastructure independent
- framework minimal.

Runtimes implement:

- hosting
- scheduling
- orchestration.

---

# Architectural Goal

Maintain a **clean separation between capability logic and runtime execution**.

Capabilities live in Shared.

Execution happens in Host and Workers.
