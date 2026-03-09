                         # PROJECT_CONTEXT.md

## Project
WoodOps.Intelligence

## Purpose
WoodOps.Intelligence provides advanced reasoning, enrichment, and analysis capabilities for the WoodOps platform.

This project hosts intelligence services such as large language model (LLM) orchestration, semantic processing, retrieval pipelines, and knowledge augmentation.

The intelligence layer allows the platform to derive insight from platform data and external knowledge sources without embedding these concerns in the kernel.

---

## Architectural Role
WoodOps.Intelligence functions as the **reasoning and semantic augmentation layer** of the platform.

Responsibilities include:

• orchestrating LLM interactions  
• performing semantic analysis of platform data  
• building retrieval and enrichment pipelines  
• generating insights or structured interpretations  
• enabling AI-assisted workflows  

The intelligence layer operates on normalized platform data but does not define the canonical data structures themselves.

---

## Owns

### LLM Orchestration
Coordinates interactions with local or remote large language models.

Examples:

- prompt construction
- model invocation
- context assembly
- response parsing
- result evaluation

LLM integrations may include local models, hosted APIs, or containerized inference services.

---

### Retrieval Pipelines
Supports retrieval-augmented reasoning.

Examples:

- document retrieval
- context assembly
- embedding search
- semantic similarity evaluation

Retrieval pipelines may interact with document stores, vector databases, or indexed platform content.

---

### Knowledge Enrichment
Provides mechanisms to augment platform data with derived insights.

Examples:

- summarization
- classification
- semantic tagging
- structured interpretation

Enrichment results should ultimately produce normalized model objects compatible with the platform.

---

### AI-Assisted Workflows
Enables automated or assisted reasoning tasks.

Examples:

- knowledge discovery
- operational recommendations
- anomaly interpretation
- document analysis

These workflows may be invoked by workers, APIs, or future automation systems.

---

## Does Not Own

WoodOps.Intelligence must **never contain**:

• canonical model definitions  
• kernel orchestration logic  
• external system adapters  
• UI components  
• runtime host configuration  

These responsibilities belong to:

• WoodOps.Core  
• WoodOps.Integrations  
• WoodOps.Host  
• WoodOps.Workers  
• WoodOps.Portal  

The intelligence layer only consumes and enriches platform data.

---

## Inputs

WoodOps.Intelligence receives:

• normalized platform data  
• documents or artifacts retrieved through integrations  
• user requests requiring analysis  
• prompts or reasoning tasks initiated by workers or APIs

Inputs may originate from:

• platform projections  
• document repositories  
• external knowledge sources  
• user queries

---

## Outputs

WoodOps.Intelligence produces:

• enriched model objects  
• semantic annotations  
• classification metadata  
• reasoning results  
• derived insights

Outputs should be compatible with the platform model and persistable through platform persistence mechanisms.

---

## Allowed Dependencies

WoodOps.Intelligence may depend on:

• WoodOps.Core  
• external AI or ML libraries  
• model inference clients  
• embedding or vector database clients

Dependencies related to AI infrastructure are expected here.

---

## Dependency Restrictions

WoodOps.Intelligence must **not be referenced by**:

• WoodOps.Core  

The kernel must remain independent of AI capabilities.

Other projects may optionally depend on this layer when intelligence features are required.

---

## Internal Namespace Guidance

Typical namespace layout:

WoodOps.Intelligence.Models  
WoodOps.Intelligence.Prompts  
WoodOps.Intelligence.Retrieval  
WoodOps.Intelligence.Analysis  
WoodOps.Intelligence.Pipelines  

Namespaces should reflect intelligence capabilities rather than external model providers.

---

## Change Guidance

Changes should focus on:

• improving reasoning pipelines  
• improving context construction  
• improving semantic accuracy  
• enabling additional intelligence workflows  

Avoid tightly coupling logic to specific AI providers where possible.

Prefer abstractions that allow model providers to be swapped.

---

## Notes

WoodOps.Intelligence extends the platform with reasoning capabilities while preserving the separation between platform infrastructure and analytical intelligence.
