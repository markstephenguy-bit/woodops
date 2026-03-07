# AI_CONTEXT.md

## Purpose

This repository contains the source for **WoodOps**.

WoodOps is an operational software platform for wood products manufacturing operations.  
Its purpose is to support software capabilities around plant operations, process visibility, quality-related workflows, system integration, analytics, and operator or management decision support.

This file exists to provide a **stable, low-maintenance context seed** for AI-assisted development.  
It is intentionally general and should not require frequent updates as the repository evolves.

---

## Source of Truth

When working in this repository, treat the repository itself as the authoritative source of truth.

Priority order:

1. actual source code
2. architecture and design documents in `docs/`
3. repository structure and naming patterns
4. README and contributing guidance
5. chat context or prior discussion

If chat guidance conflicts with the repository, the repository is authoritative.

---

## Architectural Intent

WoodOps should be treated as a structured operational platform rather than a loose collection of scripts or disconnected utilities.

General architectural expectations:

- separate UI concerns from business/domain logic
- prefer incremental extension over speculative redesign
- keep boundaries clear between application logic, infrastructure concerns, and external integrations
- align new code with the existing repository structure and coding patterns
- avoid introducing major frameworks or patterns unless the repository clearly supports that direction
- prefer maintainable, explicit code over clever abstraction

The repository may evolve, but AI assistance should default to **continuity with what already exists**.

---

## Development Expectations for AI Assistance

When assisting with this repository:

- inspect existing structure before proposing new structure
- prefer extending existing projects over creating new ones without cause
- keep recommendations implementation-oriented and repository-aligned
- avoid speculative architecture when direct evidence is missing
- request specific files when major design decisions depend on details not present in the prompt
- preserve naming consistency with the repository
- keep solutions simple unless complexity is clearly justified by the codebase

When generating code:

- follow existing code style and file organization
- keep responsibilities separated
- avoid mixing UI, domain, and infrastructure logic in one place
- prefer small, explainable changes
- generate code that could reasonably belong in the current repository

---

## Repository Guidance

Useful places to inspect first:

- `docs/` for architectural or development guidance
- `README.md` for project intent and setup
- solution and project files for actual composition
- existing application folders for naming, layering, and conventions

If a request depends on architecture, design rules, or system boundaries, consult relevant files in `docs/` first.

If a request depends on implementation details, consult the existing source files first.

---

## Safe Default Assumptions

Unless the repository clearly indicates otherwise, assume the following:

- WoodOps is under active development
- the current repository structure reflects intentional direction
- existing names and project boundaries should be preserved
- new capabilities should be added in a way that supports future operational growth
- documentation may describe intent, but source code shows current reality
- incomplete areas should be extended carefully rather than reinvented

---

## When More Context Is Required

Ask for specific files before making major changes when needed.

Examples:

- architecture document for structural changes
- project files for solution composition changes
- existing service or component files for pattern alignment
- README or docs content for intended usage and scope

Prefer asking for **specific file paths** rather than broad repository summaries.

---

## AI Working Rule

Default behavior:

- use the repository as the baseline
- stay aligned with existing patterns
- make the smallest sound change that satisfies the request
- do not invent architecture without evidence
- do not let old chat context override current repository reality

---

## Practical Use in New Chats

Use this repository as the source of truth for WoodOps.

When helping with design or implementation:

- prefer repository evidence over speculation
- align with existing structure and code patterns
- inspect `docs/` first for architectural guidance
- request specific files if needed before proposing major structural changes

This file is intentionally general so it remains useful without requiring maintenance for every commit.