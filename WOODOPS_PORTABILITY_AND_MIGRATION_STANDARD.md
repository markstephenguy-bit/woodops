  1. Objective

Establish a portable, host-agnostic WoodOps platform that can:

run on a temporary laptop

move to a new Ubuntu host without rebuild

later deploy to Azure or AWS

preserve all internal OSS system state

2. Core Principle

The platform is defined by:

service definitions (compose / config)

persistent data

environment configuration

The platform is NOT defined by:

running containers

Docker runtime state

UI-configured settings

3. Migration Strategy (Authoritative)
Selected Strategy: Exact Clone (State + Definition)

This provides:

zero reconfiguration during migration

preservation of all OSS system internals

minimal operational overhead

4. Migration Units
4.1 Required Transfer Components
A. Repository

service definitions

compose files

config

init scripts

B. Persistent Data (Critical)

Each service must own a deterministic data root:

/srv/woodops-data/
  postgres/
  minio/
  clickhouse/
  opensearch/
  redis/
  mongodb/
C. Environment Configuration
infra/env/.env.local
5. System-Level Data Ownership

Each OSS system must map to a single data root:

System	Data Type	Transfer Method
PostgreSQL	cluster directory	file copy
MinIO	object storage	file copy
ClickHouse	columnar data	file copy
OpenSearch	indexes/shards	file copy
Redis	RDB/AOF	file copy
MongoDB	dbPath	file copy
6. Required Repository Structure
infra/
  env/
    .env.local
    .env.example

  shared/
    networks/
    templates/
    scripts/

  services/
    postgres/
      compose.yml
      config/
      init/
      data-map.md

    minio/
    clickhouse/
    opensearch/
    redis/
    mongodb/
    pgbouncer/
    traefik/
    nifi/
    tika/
    ocr/
    trino/
    iceberg-rest/

  stacks/
    core/
      compose.yml
    data/
    document/
    edge/
    full/
7. Service Ownership Contract

Each service must define:

7.1 Compose Definition

pinned image version (no latest)

explicit ports

explicit network

explicit volume mapping

7.2 Data Mapping

Example:

SERVICE: postgres
DATA ROOT: /srv/woodops-data/postgres
TYPE: persistent relational
REBUILD: requires existing data or init scripts
BACKUP: rsync or pg_dump
7.3 Config Location
infra/services/<service>/config/
8. Volume Standard (Mandatory)
Prohibited

anonymous Docker volumes

implicit volume creation

Required

bind mounts OR named volumes with explicit mapping

Preferred
volumes:
  - /srv/woodops-data/postgres:/var/lib/postgresql/data
9. Migration Procedure (Authoritative)
On Source Host (Laptop)
docker compose down

rsync -avz /srv/woodops-data/ user@newhost:/srv/woodops-data/
On Target Host (Ubuntu Box)
git clone <repo>

cd repo
docker compose up -d
10. Cloud Portability Strategy
10.1 Stateless Services

Push images to registry:

Azure → ACR

AWS → ECR

Deploy to:

Azure Container Apps / App Service / AKS

AWS ECS / App Runner / EKS

10.2 Stateful Services

Handled separately via:

data migration

persistent storage configuration

optional managed service replacement

11. Non-Goals

The following are explicitly rejected as migration strategies:

docker export

docker commit

copying /var/lib/docker

UI-only configuration persistence

assuming containers are portable assets

12. Operational Rules
Rule 1

All persistent data must exist outside container layers.

Rule 2

All services must be reconstructable from repo + data.

Rule 3

All images must be version-pinned.

Rule 4

All config must exist in repo or declared external source.

13. Transition Plan (From Current State)
Phase 1 — Stabilize

identify all active services

map current volumes to real paths

stop creating anonymous volumes

Phase 2 — Externalize Data

move all service data to /srv/woodops-data/<service>

update compose definitions

Phase 3 — Service Isolation

create infra/services/<service> folders

relocate configs

Phase 4 — Stack Definition

create stack-level compose files

remove layered compose dependency

14. Target Outcome

A WoodOps platform where:

services are independently defined

data is explicitly owned and portable

environments can be moved across hosts

cloud deployment is optional, not forced

no hidden runtime state exists

15. Key Insight

You are not moving containers.
You are moving system state and definitions.

This is the foundation of:

local portability

host migration

cloud deployment

long-term platform stability
