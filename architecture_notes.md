
# CVA6 Architecture Notes

## Overview

CVA6 is a 64-bit in-order RISC-V core designed for high-performance
applications.

It implements the RV64GC ISA and supports a multi-stage pipeline.

---

## Pipeline Structure

The typical CVA6 pipeline follows these stages:
```
Fetch → Decode → Execute → Memory → Writeback
```
Each stage performs a specific role in instruction processing.

---

## Key Modules

### Instruction Fetch

Responsible for fetching instructions from memory.

Main components:
```
- instruction cache
- branch prediction logic
```
---

### Decode Stage

The decoder interprets the instruction bits and generates
control signals for the pipeline.

Key file:
```
core/decoder.sv
```
Responsibilities:
```
- opcode detection
- funct3 / funct7 decoding
- instruction classification
```
---

### Execute Stage

Arithmetic and logical operations are performed here.

Key file:
```
core/alu.sv
```
Operations include:
```
- integer arithmetic
- bit manipulation
- shift and rotate operations
```
---

### Memory Stage

Handles load and store instructions.

Key files:
```
core/load_store_unit.sv  
core/store_unit.sv
```
Responsibilities:
```
- memory access
- interaction with cache subsystem
- store buffering
```
---

### Cache Interaction

CVA6 communicates with the cache subsystem through the LSU.

Cache block operations (CBO) appear in the store pipeline.

---

## Notes for Extension Implementation

Adding new ISA extensions typically requires modifications to:
```
1. decoder logic
2. execution stage logic
3. load/store unit
4. CSR registers (if applicable)
```
Understanding the pipeline flow is important when adding
new instructions or architectural features.
