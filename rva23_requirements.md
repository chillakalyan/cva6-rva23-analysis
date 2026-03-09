
# RVA23 Profile Requirements

## Overview

The RVA23 profile defines a standard configuration of the RISC-V ISA for
64-bit application processors. The goal is to ensure compatibility across
hardware implementations and software ecosystems.

This document summarizes the key extensions required by the RVA23 profile
and compares them with the current CVA6 implementation.

---

## Base ISA

Required base architecture:

RV64I

Required standard extensions:

- M – Integer Multiplication/Division
- A – Atomic Instructions
- F – Single-Precision Floating Point
- D – Double-Precision Floating Point
- C – Compressed Instructions

These extensions form the commonly used **RV64GC** configuration.

---

## Additional RVA23 Extensions

RVA23 requires several additional extensions to support modern software
environments.

### Bit Manipulation Extensions

These extensions improve performance of bit operations commonly used
in compilers, cryptography, and low-level software.

Zba – Address generation instructions  
Zbb – Basic bit manipulation instructions  
Zbs – Single-bit operations

Example instructions:

- clz (count leading zeros)
- ctz (count trailing zeros)
- rol (rotate left)
- ror (rotate right)

---

### Cache Block Operations

These extensions provide software control over cache block management.

Zicbom – Cache block management operations  
Zicboz – Cache block zero operations

Example instructions:

- cbo.clean
- cbo.flush
- cbo.inval
- cbo.zero

These instructions interact with the cache subsystem and memory hierarchy.

---

## Goal of Investigation

The purpose of this analysis is to determine which RVA23 extensions are:

- already implemented in CVA6
- partially implemented
- missing

This information can help identify potential development targets for
improving RVA23 compliance.
