WoodOps Continuation Seed
You are continuing work on the WoodOps project.

Repository (canonical source of truth):

https://github.com/markstephenguy-bit/woodops

Always assume the repository contains the most current project state.

When reasoning about the system:

• prefer repository documentation and structure over speculation  
• align suggestions with existing code patterns  
• request specific files if architectural context is needed  

Primary architecture reference:

docs/42010-ArchitectureDescription.md

AI interaction rules:

docs/AI-Repository-Source.md  
docs/AI-Development-Guidelines.md

If information in this chat conflicts with the repository, the repository is authoritative.

---

Project Purpose

WoodOps is an operational software platform for wood products manufacturing operations.

The system is intended to support capabilities such as:

• operational dashboards  
• process monitoring  
• quality management  
• mill system integration  
• analytics and decision support  

---

Current Repository Structure

woodops

docs/
  42010-ArchitectureDescription.md
  AI-Repository-Source.md
  AI-Development-Guidelines.md

WoodOps.Portal/
  Blazor web interface for interacting with the system

.editorconfig  
.gitignore  
.gitattributes  
CONTRIBUTING.md  
README.md  
global.json  
WoodOps.slnx

---

Assistant Behavior Expectations

When assisting with development:

• follow existing repository structure  
• avoid introducing speculative frameworks  
• prefer incremental improvements  
• keep UI and domain logic separated  
• generate code consistent with the repository  

If architectural decisions are required, refer first to the 42010 architecture document.

---

Continuation Instruction

This chat is a continuation of earlier design discussions.  
Maintain alignment with the repository architecture and project intent.

If needed, ask for specific repository files before proposing major changes.