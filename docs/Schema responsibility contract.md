## Schema responsibility contract

| Schema         | Platform role                                               | May contain                                                                                                                | Must not contain                                                                                                                  | Primary writers                                                         | Primary readers                                                   | Boundary risk                                             |
| -------------- | ----------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------- | --------------------------------------------------------- |
| `reference`    | Controlled semantic standards                               | vocabularies, standard terms, units, semantic relationship types, canonical definitions                                    | source systems, source field mappings, connector config, runtime settings, raw data                                               | platform admins, controlled migration scripts                           | app layer, ingestion/mapping logic, validation logic              | drifting into generic shared/config schema                |
| `source`       | Concrete source registry and source-facing identity/mapping | source systems, source endpoints/assets, source object types, source-side identifiers, source-to-platform mapping metadata | raw landed records, canonical business records, semantic standards, workflow/runtime execution state                              | ingestion setup processes, platform admins, system integration services | ingestion services, admin UI, reconciliation logic                | overlap with `reference` and `lake`                       |
| `lake`         | Intake and landed persistence zone                          | raw payloads, staged records, ingestion batches, unnormalized extracts, landing metadata                                   | canonical mastered records, semantic standards, workflow state, user annotations                                                  | ingestion pipelines, import jobs, system loaders                        | normalization jobs, reconciliation tools, ingestion inspection UI | overlap with `source` and `canonical`                     |
| `canonical`    | Platform-owned normalized data layer                        | mastered entities, normalized records, cross-source unified identities, platform-owned business facts                      | raw payloads, connector config, execution logs, notification delivery details                                                     | normalization logic, app services, controlled internal writes           | UI, APIs, services, projections, analytics export processes       | becoming “everything important”                           |
| `lineage`      | Provenance and derivation traceability                      | source-to-canonical trace, transformation events, derivation links, provenance metadata, projection trace                  | business master records, semantic vocabularies, raw payload bodies, app workflow state                                            | ingestion/transform pipelines, projection jobs, system processes        | audit UI, explainability services, support/admin tools            | being collapsed into `canonical` as loose columns         |
| `artifact`     | Persisted produced outputs                                  | exports, generated documents, report metadata, snapshots, packaged output references                                       | raw intake, semantic standards, workflow engine state, source registry                                                            | app services, reporting/export jobs, users through app features         | UI, downstream delivery processes, audit/support tools            | storing arbitrary blobs without artifact identity/context |
| `operation`    | Internal platform execution state                           | jobs, commands, task execution events, system actions, processing runs, technical status records                           | business approval flow state, semantic standards, source master data, human comments                                              | workers, background services, app services                              | ops/admin UI, support tooling, monitoring surfaces                | confusion with `workflow`                                 |
| `workflow`     | Stateful business/process orchestration                     | workflow instances, steps, approvals, assignments, state transitions, process context                                      | low-level technical job logs, raw ingestion records, source registry, semantic terms                                              | app services, users through app actions, orchestration logic            | UI, APIs, supervisors, process automation                         | confusion with `operation` and `notification`             |
| `notification` | Outbound communication and delivery tracking                | alerts, notices, delivery attempts, message routing metadata, channel-specific send records                                | workflow logic, semantic standards, raw source data, canonical business facts except refs                                         | app services, workflow triggers, system processes                       | UI, support/admin tooling, delivery retry logic                   | becoming a generic event bus dump                         |
| `annotation`   | Human-added interpretive overlay                            | comments, flags, review marks, classifications, human notes linked to records                                              | canonical mastered facts as originals, workflow engine internals, source config, raw ingestion batches unless explicitly reviewed | users, reviewers, app services acting on behalf of users                | UI, review tools, audit contexts                                  | leaking into canonical as ungoverned editable fields      |

---

## Cross-schema boundary rules

### `reference` vs `source`

* `reference` owns **shared meaning**
* `source` owns **concrete participating systems and their local representations**

Test:

* “Is this a standard meaning independent of system?” → `reference`
* “Is this how system X identifies or names something?” → `source`

---

### `source` vs `lake`

* `source` owns **who the source is and how it is understood**
* `lake` owns **what was landed from the source**

Test:

* source registry/mapping/identifier model → `source`
* landed extract/payload/batch/staged rows → `lake`

---

### `lake` vs `canonical`

* `lake` is **pre-ownership**
* `canonical` is **platform-owned normalized record space**

Test:

* not yet normalized, source-shaped, replayable → `lake`
* normalized, unified, platform-trusted → `canonical`

---

### `canonical` vs `lineage`

* `canonical` owns **the record**
* `lineage` owns **how the record came to be**

Test:

* “what is true in platform terms?” → `canonical`
* “where did it come from and what transformed it?” → `lineage`

---

### `operation` vs `workflow`

* `operation` owns **technical execution**
* `workflow` owns **business/process progression**

Test:

* job run, command execution, retry, worker status → `operation`
* approval, review path, task assignment, state progression → `workflow`

---

### `workflow` vs `notification`

* `workflow` decides **that communication should occur**
* `notification` owns **the communication record and delivery trail**

Test:

* process state and business trigger → `workflow`
* send attempt, channel, recipient routing, delivery result → `notification`

---

### `annotation` vs `canonical`

* `annotation` is **overlay**
* `canonical` is **platform fact/state**

Test:

* comment, flag, reviewer interpretation → `annotation`
* durable mastered business value → `canonical`

---

## Application interaction model

### App writes heavily to

* `canonical`
* `workflow`
* `annotation`
* `artifact`
* `notification`
* some `operation`

### Ingestion writes heavily to

* `source`
* `lake`
* `lineage`
* some `canonical`

### System/background processes write heavily to

* `operation`
* `lineage`
* `artifact`
* `notification`

### App reads broadly from

* `canonical`
* `annotation`
* `workflow`
* `reference`
* `artifact`
* selective `source`, `lineage`, `operation`

---

## Table emergence rule by schema

### `reference`

Start with the smallest semantic tables only.
No source-aware records.

### `source`

Start with source registry and source identity/mapping tables only.
Do not store landed data first.

### `lake`

Start with batch/intake container tables and landed record envelope tables.
Do not normalize here.

### `canonical`

Start with identity-bearing core records only.
Do not mix in provenance or workflow state.

### `lineage`

Start with derivation/provenance link tables only.
Do not duplicate full canonical records.

### `artifact`

Start with artifact registry tables only.
Do not start with storage implementation detail tables.

### `operation`

Start with execution run / job / command tracking tables only.
Do not mix in business approvals.

### `workflow`

Start with workflow instance and step/state tables only.
Do not store delivery attempts here.

### `notification`

Start with notification record and delivery attempt tables only.
Do not turn this into generic event history.

### `annotation`

Start with comment/flag/review marker tables only.
Do not let annotations become mutable canonical facts.

---

## High-level validation

This contract still matches the big picture because it preserves all of the following:

* Postgres as platform persistence and coordination layer
* support for .NET application behavior
* support for ingested raw data
* support for canonical platform-owned data
* support for traceability
* support for human interaction
* support for downstream projection
* separation between technical execution and business process state

