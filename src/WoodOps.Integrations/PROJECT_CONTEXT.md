# PROJECT_CONTEXT.md

## Project
WoodOps.Integrations

## Purpose
WoodOps.Integrations provides the boundary between the WoodOps platform and external systems.

This project is responsible for interacting with external software, services, and data sources and translating those interactions into the generic structures used by the WoodOps platform.

The integrations layer ensures that external system semantics do not leak into the WoodOps kernel.

---

## Architectural Role
WoodOps.Integrations functions as the **anti-corruption boundary** of the platform.

Responsibilities include:

• communicating with external systems  
• retrieving and submitting external data  
• translating foreign payloads into WoodOps model objects  
• managing external authentication and protocols  
• isolating platform code from external system complexity  

This layer protects the platform kernel from coupling to external technologies.

---

## Owns

### External System Adapters
Implements connectors to external systems.

Examples may include:

- MES systems
- ERP systems
- Moodle
- Wiki.js
- Superset
- file systems
- REST APIs
- databases
- message queues

Each adapter should be isolated and focused on a specific external protocol or system.

---

### Protocol Handling
Responsible for communicating with external systems using appropriate protocols.

Examples:

- HTTP / REST
- database queries
- file ingestion
- message queue consumption
- webhook handling

---

### External Authentication
Handles credentials and authentication mechanisms required to interact with external systems.

Examples:

- API keys
- OAuth
- service credentials
- token exchange

Credential storage should be delegated to configuration systems where possible.

---

### Data Translation
Transforms external payloads into WoodOps model structures.

Examples:

- converting external JSON/XML to model envelopes
- mapping external identifiers to internal identities
- translating timestamps and metadata

The final output should always be compatible with the canonical structures defined in WoodOps.Core.

---

## Does Not Own

WoodOps.Integrations must **never contain**:

• platform model definitions  
• kernel orchestration logic  
• processing algorithms  
• projection logic  
• UI components  
• LLM orchestration logic  

Those responsibilities belong to:

• WoodOps.Core  
• WoodOps.Intelligence  
• WoodOps.Host  
• WoodOps.Workers  
• WoodOps.Portal  

This layer only communicates with external systems and translates their data.

---

## Inputs

WoodOps.Integrations receives:

• instructions from workers or host services  
• configuration for external connections  
• requests to retrieve or push external data  

External inputs may include:

• API responses  
• database records  
• file contents  
• webhook payloads  
• message queue events

---

## Outputs

WoodOps.Integrations produces:

• normalized model objects  
• ingestion events  
• translated data ready for processing  

Outputs should be compatible with the canonical model structures defined by the platform kernel.

---

## Allowed Dependencies

WoodOps.Integrations may depend on:

• WoodOps.Core  
• external SDKs or client libraries required to communicate with external systems  

Dependencies should remain limited to communication concerns.

---

## Dependency Restrictions

WoodOps.Integrations must **not be referenced by**:

• WoodOps.Core  
• WoodOps.Intelligence  

Kernel components must remain independent of external systems.

Integrations exist at the platform boundary.

---

## Internal Namespace Guidance

Typical namespace layout:

WoodOps.Integrations.Adapters  
WoodOps.Integrations.Connectors  
WoodOps.Integrations.Protocols  
WoodOps.Integrations.Translators  
WoodOps.Integrations.Authentication  

External system adapters should be isolated to avoid cross-contamination between integrations.

---

## Change Guidance

Changes should focus on:

• improving reliability of external connections  
• improving translation accuracy  
• improving resilience to external system changes  
• maintaining clear separation between platform logic and external semantics

Avoid embedding business logic inside integration adapters.

---

## Notes

WoodOps.Integrations protects the internal platform architecture from external system complexity.

It ensures that WoodOps remains generic and adaptable regardless of which external systems are connected to it.
