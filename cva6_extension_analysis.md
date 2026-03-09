
# CVA6 Extension Analysis

## Objective

This document summarizes the investigation of RVA23 extension support
within the CVA6 RISC-V core.

The analysis was performed by searching the RTL source code and examining
key pipeline components such as:

- decoder
- ALU
- load/store unit
- cache subsystem

---

## Investigation Method

The following commands were used to search the RTL source:

grep -rn "clz" core/  
grep -rn "ctz" core/  
grep -rn "rol" core/  
grep -rn "cbo" core/

This helped identify where specific instructions or extension logic
appear within the codebase.

---

## Preliminary Findings

| Extension | RVA23 Requirement | CVA6 Status | Notes |
|----------|------------------|------------|------|
| Zba | Required | Likely implemented | Bit manipulation logic present |
| Zbb | Required | Likely implemented | clz and ctz instructions found |
| Zbs | Required | Likely implemented | Rotate instructions present |
| Zicbom | Required | Partial support | Internal CBO signals exist |
| Zicboz | Required | Not implemented | Marked as missing in comments |

---

## Relevant RTL Locations

Key modules containing relevant logic:

core/store_unit.sv  
core/load_store_unit.sv  
core/cache_subsystem/  
core/include/riscv_pkg.sv

Examples of detected operations:

CBO_INVAL  
CBO_CLEAN  
CBO_FLUSH

These appear in the store pipeline and cache interface.

---

## Interpretation

The presence of CBO-related signals suggests that CVA6 may contain
internal support for cache block operations, but the full ISA extension
may not yet be implemented.

Further investigation of the decode stage is required to confirm whether
these instructions are fully supported.

---

## Future Work

Further investigation steps:

1. Examine instruction decode logic
2. Verify CSR support for cache management extensions
3. Identify missing instruction encodings
4. Evaluate feasibility of implementing missing instructions
