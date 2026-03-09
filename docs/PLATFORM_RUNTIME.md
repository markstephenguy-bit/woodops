# PLATFORM_RUNTIME.md

## Purpose

This document describes the runtime architecture of the WoodOps platform.

While other documents define:

- platform philosophy
- kernel object model
- integration boundaries

this document explains **how the system executes in operation**.

The runtime architecture defines how:

- services start
- workloads are executed
- integrations run
- processing pipelines operate
- external platform services are orchestrated

---

# Runtime Overview

WoodOps is designed as a **platform control plane** that orchestrates:

- platform objects
- processing pipelines
- integrations
- external capability services

The runtime consists of several cooperating executables.


WoodOps.Host
WoodOps.Workers
WoodOps.Portal


These executables operate on top of the **Core kernel**.

         Portal
           │
           ▼
      WoodOps.Host
           │
           ▼
       WoodOps.Core
           │
  ┌────────┴────────┐
  ▼                 ▼

WoodOps.Workers Integrations


---

# Runtime Components

## Host

Project:


WoodOps.Host


The Host is the **primary runtime coordinator**.

Responsibilities:

- exposes the platform API
- manages configuration
- initializes platform services
- coordinates processing requests
- acts as the entry point for external systems
- controls runtime composition

The Host should remain lightweight and orchestration-focused.

It should not contain heavy processing logic.

---

## Workers

Project:


WoodOps.Workers


Workers perform **background processing tasks**.

Examples:

- ingestion pipelines
- object normalization
- enrichment processors
- classification tasks
- scheduled jobs
- intelligence workflows

Workers operate independently of the host API.

They should be designed to run as **scalable background executables**.

---

## Portal

Project:


WoodOps.Portal


The portal provides the **human interaction surface** for the platform.

Responsibilities:

- operational dashboards
- object exploration
- form-based interaction
- workflow participation
- analytics views

The portal communicates with the platform through the Host API.

The portal must not bypass the Host to access platform data.

---

# Core Runtime Layer

Project:


WoodOps.Core


The core runtime layer contains the **kernel primitives** used by all executables.

Responsibilities include:

- kernel object model
- processing primitives
- projection mechanisms
- classification structures
- provenance handling
- relationship management
- configuration primitives
- security primitives
- observability primitives

The core must remain **dependency-free from runtime hosts**.

---

# Integration Runtime

Project:


WoodOps.Integrations


Integrations provide runtime communication with external systems.

Two categories exist.

## Adapters

Adapters translate external records into platform objects.

Examples:


MES adapter
ERP adapter
CMMS adapter
file ingestion adapter
API ingestion adapter


Adapters produce kernel envelopes.

---

## Services

Services connect to external capability providers.

Examples:


LLM runtime
NiFi pipelines
Superset analytics
Vector databases
knowledge systems
training systems


These systems perform work on behalf of the platform.

---

# Processing Model

Processing is executed by **workers operating on kernel objects**.

Typical pipeline:


External System
↓
Integration Adapter
↓
Envelope Created
↓
Worker Processing
↓
Normalization
↓
Enrichment
↓
Relationship Creation
↓
Projection
↓
Portal or API Consumption


Workers should be stateless whenever possible.

Persistent state belongs in the persistence layer.

---

# External Platform Services

WoodOps relies on external services for specialized capabilities.

Examples:

| Service | Purpose |
|------|------|
NiFi | data pipelines |
Superset | analytics dashboards |
LLM runtime | reasoning and interpretation |
Vector database | semantic search |
MongoDB | document storage |
WikiJS | knowledge management |
Moodle | training |

These services run **outside the WoodOps application runtime**.

The platform interacts with them via APIs.

---

# Deployment Model

The platform is designed to run in containerized environments.

Typical deployment topology:


woodops-host
woodops-workers
woodops-portal

postgres
mongodb
vector-db
ollama
nifi
superset
wikijs
moodle


WoodOps services communicate with external services through network APIs.

The platform does not embed these systems.

---

# Runtime Scaling

Scaling should occur at the worker layer.


workers = horizontally scalable
host = moderate scale
portal = scale based on user load


Workers can run multiple instances for:

- ingestion throughput
- pipeline processing
- AI workloads

---

# Configuration

Runtime configuration should be provided through:

- environment variables
- configuration files
- secret providers

Configuration must not be embedded in code.

---

# Observability

All runtime components must support:

- structured logging
- tracing
- metrics emission

Observability primitives should be defined in:


WoodOps.Core


but implemented by runtime hosts.

---

# Security Model

Security enforcement occurs primarily in the Host.

Key responsibilities:

- authentication
- authorization
- access filtering
- API protection

Workers operate with internal trust and platform permissions.

External access must pass through the Host.

---

# Failure Model

Runtime components should be resilient to failure.

Key principles:

- workers may crash without data loss
- pipelines should be restartable
- integrations should retry safely
- platform services should degrade gracefully

External services must not be assumed to be always available.

---

# Runtime Philosophy

The runtime architecture follows several principles.

### Control Plane

WoodOps acts as the orchestration control plane.

### Capability Composition

Capabilities emerge from combinations of:

- objects
- processors
- projections
- services

### External Leverage

The platform prefers leveraging mature external systems rather than reimplementing them.

### Kernel Stability

The kernel object model must remain stable while runtime services evolve.

---

# Summary

WoodOps runtime consists of several cooperating executables operating on a shared kernel object model.

Core runtime components:


Host
Workers
Portal
Core
Integrations
Intelligence


These components orchestrate processing pipelines and external capability services to construct operational capabilities for wood products manufacturing environments.