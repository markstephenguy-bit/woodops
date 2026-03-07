# AI Development Guidelines

This document defines how AI assistants (ChatGPT, Copilot, or similar tools) should generate code, propose changes, and reason about development within the WoodOps repository.

These guidelines ensure that AI-generated contributions remain consistent with the architecture and development practices of the project.

---

# Repository Authority

The GitHub repository is the authoritative source for:

- architecture
- project structure
- code patterns
- documentation
- development conventions

Repository:

https://github.com/markstephenguy-bit/woodops

Primary branch:

main

When assisting with development, AI tools should align with the current repository state.

If repository information conflicts with chat discussion, **the repository should be considered authoritative**.

---

# Architectural Reference

The system architecture follows:

ISO/IEC/IEEE 42010 — Architecture Description

Primary architecture document:

docs/42010-ArchitectureDescription.md

AI assistants should review this document before proposing architectural changes.

---

# Development Principles

AI-generated code should follow these principles:

## 1. Respect Existing Structure

Do not introduce new project structures without considering the current layout.

Existing solution:


WoodOps.slnx
WoodOps.Portal/
docs/


Future projects may be added as the system grows.

---

## 2. Prefer Incremental Changes

AI assistants should:

- modify existing code where appropriate
- avoid large structural refactors
- avoid introducing unnecessary frameworks

Changes should be incremental and compatible with the existing system.

---

## 3. Follow .NET Conventions

Generated code should follow common .NET conventions:

- PascalCase for types
- camelCase for variables
- one class per file
- clear namespace organization

---

## 4. Keep UI and Logic Separated

The current project contains a portal UI.

AI assistants should avoid embedding business logic directly inside UI components.

Business logic should be isolated in services or domain objects when introduced.

---

## 5. Avoid Assumptions About Infrastructure

Unless explicitly documented in the repository, AI assistants should not assume the presence of:

- external databases
- container infrastructure
- cloud services
- message buses

If infrastructure is required, the assistant should ask for clarification.

---

# Code Generation Expectations

When generating code, AI assistants should:

- match the style used in existing files
- keep implementations simple and readable
- avoid unnecessary abstractions
- produce compilable code

Generated code should be suitable for direct inclusion in the repository.

---

# File Creation Guidelines

New files should follow existing naming conventions.

Examples:


ServiceName.cs
FeatureComponent.razor
FeatureService.cs


Avoid creating large files containing multiple unrelated classes.

---

# Documentation Updates

If architectural or structural changes are proposed, AI assistants should recommend updating:


docs/42010-ArchitectureDescription.md
README.md


to maintain accurate documentation.

---

# Conflict Handling

If an AI assistant cannot determine the correct design from the repository contents, it should request:

- the relevant source file
- the relevant project directory
- clarification about intended architecture

before proposing changes.

---

# Purpose of WoodOps

WoodOps is an operational software platform intended to support wood products manufacturing operations.

The system will evolve to support capabilities such as:

- operational dashboards
- process monitoring
- quality management
- system integrations
- analytics and decision support