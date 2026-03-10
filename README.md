# CVA6 RVA23 Compliance Investigation

This repository documents an investigation of the CVA6 (Ariane) RISC-V core
with respect to the RVA23 application processor profile.

The goal of this work is to analyze which ISA extensions required by the
RVA23 profile are currently supported in CVA6 and identify potential gaps
that could be implemented to improve compliance.

This investigation includes:
```
• studying the RVA23 specification  
• analyzing the CVA6 RTL implementation  
• searching the source code for instruction support  
• documenting extension coverage and missing features  
```
---

# Background

CVA6 is a 64-bit in-order RISC-V processor developed by the OpenHW Group.
It implements the RV64GC ISA and is used in several research platforms
including OpenPiton.

The RVA23 profile defines a standardized set of RISC-V ISA extensions
for modern application processors.

Improving RVA23 compliance in CVA6 can help ensure compatibility with
software ecosystems and future hardware platforms.

---

# Repository Structure
```
cva6-rva23-analysis
│
├── diagrams
│   ├── cva6_pipeline.png
│   │
│   └── cva6_rva23_workflow.png
│
├── docs
│   ├── architecture_notes.md
│   │
│   ├── cbo_extension_notes.md
│   │
│   ├── cva6_extension_analysis.md
│   │
│   ├── rtl_instruction_mapping.md
│   │
│   └── rva23_requirements.md
│
├── scripts
│   └── search_extensions.sh
│
├── LICENSE
│
└── README.md
   
```

### File Descriptions
```
**rva23_requirements.md**
```
Summary of the RVA23 ISA requirements and required extensions.

**cva6_extension_analysis.md**

Analysis comparing RVA23 extension requirements with
the current CVA6 RTL implementation.

**cbo_extension_notes.md**

Notes on Cache Block Operations (Zicbom / Zicboz) and
their possible implementation in CVA6.

**architecture_notes.md**

Overview of the CVA6 pipeline architecture and major modules.

**scripts/search_extensions.sh**

Script used to search the CVA6 RTL source for instruction
and extension support.

**diagrams/**

Workflow and architecture diagrams created during the investigation.

---

# Investigation Method

The RTL source code of CVA6 was explored using command-line searches
to identify where instructions and extension support appear.

Example commands used:
```
grep -rn "clz" core/
grep -rn "ctz" core/
grep -rn "rol" core/
grep -rn "cbo" core/
```

These searches help locate instruction implementations in modules such as:
```
• decoder  
• ALU  
• load/store unit  
• cache subsystem  
```
---

# Preliminary Findings

Initial investigation suggests:

| Extension | RVA23 Requirement | Status in CVA6 |
|----------|------------------|---------------|
| Zba | Required | Likely implemented |
| Zbb | Required | Likely implemented |
| Zbs | Required | Likely implemented |
| Zicbom | Required | Partial / internal signals present |
| Zicboz | Required | Not implemented |

Some cache block operation signals were found in the store pipeline
(`CBO_CLEAN`, `CBO_FLUSH`, `CBO_INVAL`), but full ISA-level support
may not yet be implemented.

---

# Possible Future Work

Potential improvements for RVA23 compliance include:
```
• implementing missing cache block instructions  
• completing Zicbom/Zicboz ISA support  
• extending decoder logic for new instructions  
• integrating cache maintenance operations with the LSU  
```
---

# License

This repository is provided under the MIT License.

---
