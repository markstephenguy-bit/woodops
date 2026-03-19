# WoodOps — OSS vs .NET Decision Framework

## 1. Objective

Establish a consistent rule for deciding:
- when to adopt OSS platforms
- when to implement capability in .NET

Goal:
Avoid building unnecessary subsystems while maintaining control and simplicity.

---

## 2. Governing Principle

Adopt mature OSS for substantial platform capabilities.  
Use .NET + NuGet for thin integration and limited-scope logic.

---

## 3. Decision Rules

### OSS Wins When

- A mature OSS tool already solves the problem
- The capability represents a full subsystem (not a feature)
- Building it would require significant engineering effort
- The OSS tool is operationally reasonable

Examples:
- databases
- object storage
- search/index engines
- model runtimes
- full orchestration systems

---

### .NET + NuGet Wins When

- The capability is thin
- It can be implemented with limited code
- No new subsystem needs to be created
- It acts as glue between systems

Examples:
- adapters/connectors
- API layers
- query routing
- policy enforcement
- light orchestration
- provider abstraction

---

### Defer When

- No strong OSS exists
- .NET implementation would create a large subsystem
- The capability is not yet required

---

## 4. Anti-Patterns

### Do Not

- Build NiFi-class systems in .NET
- Recreate database or search engines
- Add containers for trivial capabilities
- Split responsibility across multiple tools unnecessarily

---

## 5. Boundary Test

For each capability:

1. Does a mature OSS tool already solve this well?
   → Use OSS

2. Can this be done with small .NET + NuGet effort?
   → Use .NET

3. Would this require building a new subsystem?
   → Reject or defer

---

## 6. Role of .NET in WoodOps

.NET is responsible for:

- integration
- coordination
- control plane logic
- policy enforcement
- routing decisions

.NET is NOT responsible for:

- heavy data storage engines
- full workflow/orchestration platforms
- search/index engines
- model runtimes

---

## 7. Target Outcome

- Minimal custom subsystems
- Maximum leverage of OSS
- Clear ownership boundaries
- Reduced operational complexity
- Faster iteration without architectural debt
