#!/bin/bash
for p in 1 2 3 4 5; do
  scip -c "read modelos/punto_$p.zpl" \
       -c "optimize" \
       -c "write solution soluciones/punto_$p.sol" \
       -c "quit"
done