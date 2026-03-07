# ChatGPT Repository Context

This document establishes how AI assistants (ChatGPT, Copilot, etc.) should treat this repository when participating in development discussions.

## Repository

Canonical source:

https://github.com/markstephenguy-bit/woodops

Branch used for development:

main

The GitHub repository is the **authoritative source of truth** for:

- architecture
- project structure
- documentation
- code
- configuration
- development standards

AI assistants must treat the repository contents as the primary reference when answering questions or generating code.

---

## AI Interaction Policy

When assisting with development of **WoodOps**, the AI should follow this workflow:

1. Inspect the repository structure.
2. Read relevant files from the repository.
3. Base all recommendations on the existing architecture.
4. Avoid inventing structures that conflict with the repository.

The assistant should prefer:

- existing code patterns
- existing project layout
- existing documentation

over speculative designs.

---

## Primary Documentation Sources

The following files should be consulted first when reasoning about the system:


docs/42010-ArchitectureDescription.md
README.md
CONTRIBUTING.md


These documents describe:

- system architecture
- development workflow
- project intent

---

## Architectural Authority

The architecture description follows:

ISO/IEC/IEEE 42010 — Architecture Description.

Primary architecture file:


docs/42010-ArchitectureDescription.md


All system design discussions should remain consistent with this architecture description.

---

## Repository Structure

The repository currently contains:


woodops
│
├── docs/
│ └── 42010-ArchitectureDescription.md
│
├── WoodOps.Portal/
│
├── .editorconfig
├── .gitignore
├── .gitattributes
├── README.md
└── WoodOps.slnx


Future components may include additional services, integrations, and operational modules.

---

## AI Behavior Guidelines

When assisting in development:

The AI should:

- read repository documentation first
- align suggestions with existing architecture
- avoid proposing unrelated frameworks or redesigns
- treat the GitHub repository as the canonical context

If repository information conflicts with chat discussion, **the repository wins**.

---

## Purpose of WoodOps

WoodOps is an operational software platform intended to support wood products manufacturing operations.

The system will evolve to include:

- operational dashboards
- process monitoring
- quality management tools
- integration with mill systems
- analytics and decision support

The repository is the evolving implementation of that system.

---

## Maintenance

If repository structure or architecture changes, update this document to reflect the new authoritative sources.