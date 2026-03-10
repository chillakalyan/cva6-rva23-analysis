
# Cache Block Operation (CBO) Extension Notes

## Overview

Cache Block Operations are part of the Zicbom and Zicboz RISC-V extensions.

These instructions allow software to directly control cache maintenance
operations.

---

## Zicbom Instructions

Common cache management instructions include:
```
cbo.clean  
cbo.flush  
cbo.inval
```
These instructions allow software to:
```
- write back dirty cache lines
- invalidate cache blocks
- maintain cache coherency
```
---

## Zicboz Instructions

The Zicboz extension introduces cache block zeroing:
```
cbo.zero
```
This instruction initializes a cache block with zero data.

---

## Observations in CVA6

Search results revealed several internal signals related to CBO operations:
```
CBO_INVAL  
CBO_CLEAN  
CBO_FLUSH
```
These appear in the following modules:
```
core/store_unit.sv  
core/load_store_unit.sv  
core/cache_subsystem/
```
However, the following comment appears in the code:

"not implemented – requires Zicboz extension"

This suggests that full support for the ISA-level extension
may not yet be complete.

---

## Potential Implementation Path

Implementing cache block instructions would likely involve changes to:
```
1. Decoder logic (instruction recognition)
2. Execution stage control signals
3. Load/store unit integration
4. Cache subsystem interface
```
---

## Importance for RVA23 Compliance

The RVA23 profile requires support for cache block management
extensions.

Adding full support for Zicbom/Zicboz would help move CVA6 closer
to RVA23 compliance.
