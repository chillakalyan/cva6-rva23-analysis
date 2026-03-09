#!/bin/bash

echo ""
echo "CVA6 RVA23 Extension Investigation Script"
echo ""

echo "Checking clz instruction"
grep -rn "clz" core/

echo "Checking ctz instruction"
grep -rn "ctz" core/

echo "Checking rol instruction"
grep -rn "rol" core/

echo "Checking ror instruction"
grep -rn "ror" core/

echo ""
echo "Checking bitwise instructions"

grep -rn "andn" core/
grep -rn "orn" core/
grep -rn "xnor" core/

echo ""
echo "Checking Cache Block Operations"

grep -rn "cbo" core/
grep -rn "CBO_CLEAN" core/
grep -rn "CBO_FLUSH" core/
grep -rn "CBO_INVAL" core/

echo ""
echo "Checking decoder related fields"

grep -rn "opcode" core/
grep -rn "funct3" core/
grep -rn "funct7" core/

echo ""
echo "Checking Zicbom / Zicboz mentions"

grep -rn "zicbom" .
grep -rn "zicboz" .

echo ""
echo "Investigation Complete"
