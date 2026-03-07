# AI_INDEX.md

## Project

WoodOps is an operational software platform for wood products manufacturing operations.

It is intended to support capabilities such as:

- operational dashboards
- process monitoring
- quality management
- mill system integration
- analytics and decision support

This file provides a structured repository map for AI-assisted development.
It should be used to realign reasoning after repository changes.
It is not intended to document every file or every commit.

---

## Source of Truth Order

Use this precedence order when reasoning about the system:

1. implementation source code
2. project and solution structure
3. architecture and design documents in `docs/`
4. repository guidance files such as `README.md` and `CONTRIBUTING.md`
5. prior chat context

If prior chat context conflicts with the repository, the repository is authoritative.

---

## Architectural Stance

WoodOps should be treated as a structured operational platform with clear separation of responsibilities.

Default expectations:

- UI concerns remain separate from business and domain logic
- infrastructure concerns remain separate from core application behavior
- integrations with mill systems or external systems should have explicit boundaries
- recommendations should extend the existing repository rather than redesign it without evidence
- changes should be incremental, explainable, and consistent with repository patterns

Primary architectural reference:

- `docs/42010-ArchitectureDescription.md`

Primary AI guidance references:

- `docs/AI_CONTEXT.md`
- `docs/AI-Repository-Source.md`
- `docs/AI-Development-Guidelines.md`

---

## Repository Layout

Current top-level structure should be interpreted from the repository itself.

Key known areas:

- `docs/` — architecture, AI guidance, and repository-level documentation
- `WoodOps.Portal/` — Blazor-based user interface layer

Other projects or folders should be interpreted according to their actual repository presence and naming.

When new projects are added, this file should only be updated if their addition changes architectural reasoning.

---

## Project Responsibility Map

### WoodOps.Portal
Purpose:
- user-facing web interface for interacting with the WoodOps system

Expected responsibility:
- presentation
- UI composition
- user workflows
- view models / page interaction patterns as appropriate to the codebase

Should avoid:
- owning deep domain rules
- absorbing infrastructure-specific logic
- becoming the default place for unrelated application behavior

---

## Document Map

Use these documents first when relevant:

### `docs/42010-ArchitectureDescription.md`
Use for:
- system structure
- architectural boundaries
- major design reasoning
- layer or component decisions

### `docs/AI_CONTEXT.md`
Use for:
- general repository bootstrap
- low-maintenance context refresh
- source-of-truth behavior

### `docs/AI-Repository-Source.md`
Use for:
- repository-first reasoning expectations

### `docs/AI-Development-Guidelines.md`
Use for:
- development behavior
- implementation expectations
- consistency rules

### `README.md`
Use for:
- project overview
- setup intent
- contributor orientation

### `CONTRIBUTING.md`
Use for:
- expected contribution behavior
- repository standards

---

## Current Development Shape

This section should describe only high-value structural reality.

Example entries:

- The repository currently contains a Blazor portal as the visible application entry point.
- Architecture documentation is maintained under `docs/`.
- The repository should be interpreted as an evolving operational platform rather than a single-purpose application.
- Additional layers or projects should only be inferred from the repository when they are actually present.

Replace or extend these statements only when the architectural shape materially changes.

---

## Development Guardrails

When assisting with this repository:

- follow existing project boundaries
- preserve naming consistency
- prefer extending current code over introducing parallel structures
- avoid speculative frameworks or abstractions
- keep UI logic and domain logic separated
- request specific files before proposing major structural changes when evidence is missing
- use the smallest sound change that satisfies the request

---

## Expansion Points

These are categories of likely future growth, not commitments:

- domain and application layers
- infrastructure and integration layers
- plant or mill system connectors
- quality or operational workflow modules
- analytics and decision-support components

AI assistance should not assume any specific implementation exists unless the repository shows it.

---

## AI Working Instructions

When asked to continue work after commits:

1. realign to repository structure first
2. use this file to re-establish subsystem understanding
3. use `docs/AI_CONTEXT.md` for stable project intent
4. consult architecture documentation for structural questions
5. request specific files only when implementation details are required

Do not let stale chat assumptions override the current repository.
Do not invent missing layers or services without repository evidence.
Preserve continuity with the codebase that exists.