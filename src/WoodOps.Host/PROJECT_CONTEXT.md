# PROJECT_CONTEXT.md

## Project
WoodOps.Host

## Purpose
WoodOps.Host is the primary runtime host for the WoodOps platform.

It provides the API surface and runtime composition environment in which the
WoodOps kernel, integrations, intelligence systems, and workers operate.

This project exposes the platform capabilities through network interfaces
while delegating actual platform behavior to WoodOps.Core.

WoodOps.Host is responsible for *hosting*, not implementing, platform logic.

---

## Architectural Role
WoodOps.Host functions as the **platform service host**.

Responsibilities include:

• exposing platform APIs  
• composing platform services via dependency injection  
• initializing the WoodOps kernel  
• registering integrations and processors  
• coordinating runtime infrastructure  
• exposing endpoints for external systems  

WoodOps.Host is typically deployed as a **Docker container**.

It acts as the primary entry point for:

• the Portal UI  
• external applications  
• automation scripts  
• analytics tools  
• integration systems  

---

## Owns

### API Surface
Defines the external API interface to the platform.

Examples:

- REST endpoints
- future gRPC endpoints
- system status endpoints
- ingestion endpoints
- projection/query endpoints

Controllers should remain thin and delegate all logic to platform services.

---

### Runtime Composition
Responsible for wiring the platform together.

Examples:

- dependency injection configuration
- module registration
- integration registration
- configuration loading
- startup lifecycle management

---

### Platform Bootstrapping
Initializes core platform components.

Examples:

- loading configuration
- initializing persistence services
- registering processors
- enabling integrations
- initializing observability systems

---

### External Entry Point
Provides access to WoodOps functionality for:

- user interfaces
- integration tools
- automation systems
- analytics platforms

---

## Does Not Own

WoodOps.Host must **never contain**:

• domain logic  
• kernel model definitions  
• integration translation logic  
• processing algorithms  
• projection logic  
• LLM orchestration  

Those responsibilities belong to:

• WoodOps.Core  
• WoodOps.Integrations  
• WoodOps.Intelligence  
• WoodOps.Workers  

The host only exposes them.

---

## Inputs

WoodOps.Host receives:

• API requests from clients  
• configuration from environment variables or configuration providers  
• normalized model objects submitted by integrations  
• runtime service registrations

Clients may include:

• WoodOps.Portal  
• automation systems  
• analytics tools  
• integration services  
• external applications

---

## Outputs

WoodOps.Host provides:

• API responses  
• platform service endpoints  
• ingestion interfaces  
• query and projection endpoints  
• system diagnostics endpoints

These outputs expose platform capabilities without embedding domain logic.

---

## Allowed Dependencies

WoodOps.Host may depend on:

• WoodOps.Core  
• WoodOps.Integrations  
• WoodOps.Intelligence  
• standard ASP.NET runtime libraries

These dependencies allow the host to compose the platform.

---

## Dependency Restrictions

WoodOps.Host must **not be referenced by**:

• WoodOps.Core  
• WoodOps.Integrations  
• WoodOps.Intelligence  

The host sits at the runtime edge of the system.

Kernel libraries must remain host-agnostic.

---

## Internal Namespace Guidance

Typical namespace layout:

WoodOps.Host.Api  
WoodOps.Host.Controllers  
WoodOps.Host.Configuration  
WoodOps.Host.Composition  
WoodOps.Host.Diagnostics  

Controllers should remain thin and delegate work to platform services.

---

## Change Guidance

Changes to this project should focus on:

• improving API structure  
• improving platform composition  
• improving runtime configuration  
• improving operational diagnostics  

Avoid adding platform logic here.

If logic begins accumulating inside the host, it likely belongs in:

• WoodOps.Core  
• WoodOps.Integrations  
• WoodOps.Intelligence

---

## Notes

WoodOps.Host is the **platform runtime shell**.

Its role is to make the WoodOps platform accessible without embedding
the platform's intelligence directly into the host itself.
