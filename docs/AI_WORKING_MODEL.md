# AI_WORKING_MODEL

This document defines how AI assistants are used in the WoodOps project.

AI is used as a development assistant and sounding board.

AI does not control platform architecture.

---

# AI Responsibilities

AI can assist with:

- code scaffolding
- documentation generation
- test creation
- algorithm refinement
- design critique.

---

# AI Limitations

AI must not:

- redefine architecture
- introduce new frameworks without approval
- restructure the repository.

---

# Repository as Source of Truth

The GitHub repository is authoritative.

AI suggestions must follow repository structure and documentation.

---

# Recommended AI Workflow


Architecture Context
↓
Atomic Task Definition
↓
AI Draft
↓
Human Review
↓
Integration


---

# Prompt Structure

Effective prompts include:


Context
Task
Constraints
Expected Output


Example:


Context:
docs/ARCHITECTURE.md

Task:
Generate worker processing logic.

Constraints:
C#
No external libraries.

Output:
Single file.


---

# Goal

AI should accelerate development while preserving architectural discipline.

The developer remains responsible for final decisions.
