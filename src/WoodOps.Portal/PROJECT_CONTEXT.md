# PROJECT_CONTEXT.md

## Project
WoodOps.Portal

## Purpose
WoodOps.Portal provides the primary user interface for interacting with the WoodOps platform.

This project implements the web-based experience for users to view, manage, and operate capabilities exposed by the WoodOps platform.

The Portal is a **consumer of platform capabilities**, not the owner of business logic.

All operational behavior must originate from the platform services exposed by WoodOps.Host.

---

## Architectural Role
WoodOps.Portal is the **presentation layer** of the WoodOps platform.

Responsibilities include:

• user interaction
• navigation and layout
• dashboards and operational views
• data entry and control surfaces
• visualization of projections and analytics

The Portal communicates with the WoodOps platform primarily through APIs exposed by WoodOps.Host.

The Portal must remain independent of the internal kernel implementation.

---

## Owns

### User Interface
Defines the user-facing experience of WoodOps.

Examples:

- navigation structure
- dashboards
- operational screens
- management panels
- visualization components

---

### Interaction Workflows
Implements UI-level workflows.

Examples:

- submitting requests to the platform
- viewing operational state
- browsing projections and analytics
- managing operational artifacts

These workflows coordinate user interaction but do not implement platform logic.

---

### Visualization
Responsible for presenting platform information to users.

Examples:

- charts
- tables
- dashboards
- status indicators
- operational summaries

Visualization may integrate with external analytics platforms such as Superset when appropriate.

---

## Does Not Own

WoodOps.Portal must **never contain**:

• business logic
• platform processing logic
• integration logic
• persistence logic
• model definitions
• LLM orchestration

These responsibilities belong to:

• WoodOps.Core
• WoodOps.Integrations
• WoodOps.Intelligence
• WoodOps.Host
• WoodOps.Workers

The Portal only interacts with these through APIs.

---

## Inputs

WoodOps.Portal receives:

• API responses from WoodOps.Host
• projection data from platform queries
• configuration values supplied by the host environment

User interaction is translated into API requests.

---

## Outputs

WoodOps.Portal produces:

• API requests to WoodOps.Host
• UI events initiated by users
• visualization and reporting surfaces

The Portal does not directly communicate with platform subsystems.

All communication should flow through the host.

---

## Allowed Dependencies

WoodOps.Portal may depend on:

• ASP.NET / Blazor UI frameworks
• HTTP client libraries
• UI component libraries

Direct references to kernel libraries should be avoided unless absolutely required.

The preferred interaction path is through the platform API.

---

## Dependency Restrictions

WoodOps.Portal must **not be referenced by**:

• WoodOps.Core
• WoodOps.Integrations
• WoodOps.Intelligence
• WoodOps.Workers

The UI layer must remain isolated.

---

## Internal Namespace Guidance

Typical namespace layout:

WoodOps.Portal.Pages  
WoodOps.Portal.Components  
WoodOps.Portal.Services  
WoodOps.Portal.Layout  
WoodOps.Portal.Shared  

Pages should focus on presentation while services handle API communication.

---

## Change Guidance

Changes should prioritize:

• clarity of user workflows
• operational usability
• clear visualization of platform state
• minimal coupling with platform internals

Avoid introducing platform logic in UI code.

---

## Notes

WoodOps.Portal represents the **operational face of the WoodOps platform**.

Its responsibility is to make platform capabilities accessible and understandable to users without embedding the platform’s internal mechanics into the UI.
