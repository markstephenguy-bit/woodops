# PLATFORM_SERVICES.md

## Purpose

This document explains how WoodOps interacts with external operational software that provides capabilities rather than raw data.

Examples include:

- NiFi
- Superset
- local LLM runtimes
- vector databases
- MongoDB
- Wiki.js
- Moodle

These systems are referred to as **Platform Services**.

They are not internal subsystems of WoodOps and they are not traditional data integrations.

Instead they are **external capability providers that WoodOps orchestrates**.

---

## Architectural Distinction

WoodOps interacts with two types of external systems.

### External Data Systems

These systems provide operational data.

Examples:

- MES
- ERP
- CMMS
- PLC gateways
- sensor systems
- file repositories

Interaction pattern:


External System
↓
Integration Adapter
↓
WoodOps Kernel Objects


These systems are treated as **sources of records**.

---

### Platform Services

These systems provide **processing or operational capabilities**.

Examples:

- data pipelines
- analytics
- AI reasoning
- document storage
- knowledge systems
- training systems

Interaction pattern:


WoodOps
↓
Service Client
↓
External Capability


Examples:


WoodOps → NiFi → ingestion pipelines
WoodOps → Superset → analytics dashboards
WoodOps → LLM runtime → reasoning tasks
WoodOps → Vector DB → semantic search
WoodOps → WikiJS → knowledge management
WoodOps → Moodle → training systems


These systems perform work **on behalf of the platform**.

---

## Why This Distinction Exists

If all external systems are treated as integrations, the architecture becomes confused.

Data ingestion code and capability orchestration code become mixed.

Separating them clarifies responsibilities:

| Category | Role |
|---|---|
Adapters | translate external records into WoodOps objects |
Services | provide processing power or functionality |

---

## Integration Layer Structure

The integration layer should internally distinguish between:


WoodOps.Integrations.Adapters
WoodOps.Integrations.Services


### Adapters

Responsible for translating external records into platform objects.

Examples:


MES adapter
ERP adapter
CMMS adapter
PLC adapter
File ingestion


These adapters normalize foreign records into **WoodOps kernel objects**.

---

### Services

Responsible for communicating with external capability providers.

Examples:


LLM client
NiFi orchestration client
Superset API client
Vector database client
WikiJS client
Moodle client


Services expose operational capabilities to the platform runtime.

They do not directly translate records into kernel objects.

---

## Platform Runtime Relationship

WoodOps acts as a **control plane** over external capability services.

Typical interaction flow:


Portal / API
↓
Host
↓
Workers
↓
Core Kernel
↓
Integrations Layer
↓
Adapters OR Services
↓
External Systems


Adapters ingest data.

Services execute capability operations.

---

## Deployment Model

External platform services are expected to run independently, typically as containerized services.

Example deployment topology:


woodops-host
woodops-workers

postgres
mongodb
vector-db
ollama
nifi
superset
wikijs
moodle


WoodOps communicates with these services through network APIs.

The platform **does not embed or reimplement these systems**.

---

## Repository Layout Guidance

Infrastructure used to run platform services should be isolated from application code.

Recommended repository layout:


infrastructure/

docker/
docker-compose.yml

services/
nifi/
superset/
ollama/
vector-db/


Application code should remain inside:


src/


This separation prevents infrastructure concerns from leaking into application projects.

---

## Architectural Principle

WoodOps should focus on:

- object normalization
- operational orchestration
- capability composition

It should not attempt to rebuild mature systems that already exist.

Instead the platform composes capabilities from:

- its kernel object system
- external platform services
- processing pipelines
- projections and user interfaces

---

## Summary

External systems interacting with WoodOps fall into two categories:

### Data Adapters

Systems that provide operational records.

### Platform Services

Systems that provide operational capabilities.

Maintaining this distinction ensures the platform architecture remains clear and scalable as additional integrations and services are added.