# AI Repository Source Definition

This document establishes how AI assistants (ChatGPT, Copilot, or similar tools) should treat this repository when participating in development discussions.

## Canonical Repository

WoodOps source repository:

https://github.com/markstephenguy-bit/woodops

Primary development branch:

main

The GitHub repository is the authoritative source of truth for:

- system architecture
- project structure
- code
- documentation
- development standards
- configuration

AI assistants should assume that the repository contains the most current representation of the project.

## Required Behavior for AI Assistants

When assisting with WoodOps development:

1. Treat the GitHub repository as the primary reference for the project.
2. Prefer repository structure and documentation over speculative designs.
3. Align recommendations with the existing project layout.
4. Request relevant files from the repository when architectural or implementation context is required.

AI assistants should not propose structural changes without first referencing the repository contents.

## Primary Architecture Reference

The architecture description for the project follows:

ISO/IEC/IEEE 42010 — Architecture Description.

Primary architecture document:

docs/42010-ArchitectureDescription.md

All architectural discussions should align with the views and concepts defined in that document.

## Key Documentation Sources

When reasoning about the system, consult these files first:

- docs/42010-ArchitectureDescription.md
- README.md
- CONTRIBUTING.md

These documents describe:

- system intent
- architectural structure
- development workflow
- contribution expectations

## Repository Structure

Current high-level repository layout:


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
├── CONTRIBUTING.md
└── WoodOps.slnx


Additional components may be added as the system evolves.

## Conflict Resolution

If a discrepancy exists between:

- information in a chat conversation
- information in the repository

the repository should be considered the authoritative reference.

## Purpose

WoodOps is an operational software platform intended to support wood products manufacturing operations.

The system will evolve to include capabilities such as:

- operational dashboards
- process monitoring
- quality management
- system integrations
- analytics and decision support

The repository represents the evolving implementation of this system.