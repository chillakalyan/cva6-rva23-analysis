# CVA6 RTL Instruction Investigation
Analysis of Bit-Manipulation and Cache Management related functionality in the CVA6 RISC-V core.

This document records the investigation requested by the mentor to verify
whether Bitmanip instructions and Cache Management Operations (CMO)
exist in the current RTL implementation.

Repository analyzed:
https://github.com/openhwgroup/cva6

---

# 1. Bit-Manipulation Extension Investigation

The Bit-Manipulation extension (Bitmanip) improves performance for common
bit operations such as counting zeros and bit rotations.

Examples include:

- CLZ (Count Leading Zeros)
- CTZ (Count Trailing Zeros)
- ROL / ROR (Rotate)
- ANDN / ORN / XNOR
- PCNT

---

## Search Command
```
grep -Rni "bitmanip" .
grep -Rni "clz" .
```

---

## Observed Results

Bitmanip references appear in configuration and verification infrastructure.

| File | Observation |
|-----|-------------|
| config/gen_from_riscv_config/.../isa.adoc | Bitmanip extensions Zbb and Zbkb referenced |
| config/gen_from_riscv_config/.../isa.rst | Documentation describing bit manipulation extension |
| verif/docs/coverage_status/isacov_status.rst | Coverage model referencing CLZ |
| verif/docs/VerifPlans/... | Verification plan contains CLZ instruction tests |
| verif/sim/cva6.hvp | Coverage group defined for CLZ |
| verif/tests/testlist_riscv-arch-test-* | Architecture tests include CLZ instructions |

---

## Interpretation

The presence of CLZ in:

- ISA verification plans
- coverage models
- architecture tests

indicates that **the core is expected to support Bitmanip instructions**.
```
core/alu
core/execution_units
```

---

# 2. Decoder Investigation

Instruction decoding logic is implemented in:
```
core/compressed_decoder.sv
```

This module maps instruction encoding fields into internal operations.

Example instruction format:
```
I-Type:
| imm[11:0] | rs1 | funct3 | rd | opcode |

S-Type:
| imm[11:5] | rs2 | rs1 | funct3 | imm[4:0] | opcode |
```

Example decoded instruction groups:
```
riscv::OpcodeLoad
riscv::OpcodeStore
riscv::OpcodeOpImm
```

These signals determine which execution unit receives the instruction.

---

# 3. Cache Management / Flush Behavior

Search command:
```
grep -Rni "flush" .
```

Results show flush logic mainly related to **pipeline and fence.i behavior**.

Example locations:

| File | Description |
|-----|-------------|
| verif/docs/VerifPlans/source/dvplan_FENCEI.md | Pipeline flush verification plan |
| verif/docs/VerifPlans/source/dvplan_FRONTEND.md | Frontend pipeline flush behaviour |
| regress/riscv-tests-env.patch | Flush handling in environment |

These appear related to **pipeline flush and fence instructions**, not
direct CMO instructions.

---

# 4. Cache Clean Operation

Search command:
```
grep -Rni "clean" .
```

Important result:
```
core/cache_subsystem/cva6_hpdcache_if_adapter.sv
```

Example line:

```
ariane_pkg::CBO_CLEAN: store_op = hpdcache_pkg::HPDCACHE_REQ_CMO_FLUSH_NLINE;
```

Interpretation:

This strongly suggests that **CBO_CLEAN is supported through cache subsystem
logic**.

---

# 5. Cache Invalidation

Search command:
```
grep -Rni "invalidate" .
```

Key RTL locations:

| File | Description |
|----|----|
| core/cache_subsystem/cva6_hpdcache_if_adapter.sv | cache invalidate control |
| core/cache_subsystem/cva6_icache.sv | icache invalidate logic |
| core/cache_subsystem/miss_handler.sv | invalidate behavior in miss handling |
| core/cache_subsystem/wt_cache_subsystem.sv | invalidate selected cache ways |

Example signals:
```
InvalidateOnFlush
invalidate
l15_invalidate_cacheline
```

These confirm that **cache invalidation mechanisms exist in the RTL**.

---

# 6. Initial Conclusions

Based on the current investigation:

### Bitmanip

Evidence exists in:

- ISA configuration
- verification plans
- architecture tests
- coverage models

Further investigation is required in ALU execution units.

---

### Cache Management Operations

Evidence found in cache subsystem modules including:
```
core/cache_subsystem/cva6_hpdcache_if_adapter.sv
```

Specifically:

```
CBO_CLEAN
invalidate
flush
```

This suggests that **CMO functionality is already integrated in the cache subsystem**.

---

# 7. Next Steps

Further analysis will focus on tracing:

Instruction → Decoder → Execution Unit → Cache / LSU

The following modules will be inspected next:
```
core/alu
core/execution_units
core/cache_subsystem
core/load_store_unit
```

to determine the exact execution paths for Bitmanip and CMO instructions.

---

# Purpose

This investigation documents the current state of RVA23-related functionality
in the CVA6 core and aims to identify:

- implemented extensions
- RTL locations
- instruction execution paths

However, the actual execution logic must still be confirmed inside:
