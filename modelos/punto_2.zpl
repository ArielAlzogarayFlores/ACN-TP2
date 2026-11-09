# EJERCICIO 2

# DEFINICIÓN DE CONJUNTOS Y PARAMETROS

set P := {1 .. 5};          # Productos
set M := {1 .. 24};         # Meses
set M_ALT := {0 .. 24};     # Meses (incluyendo el mes previo al inicio)

param c := 370;             # Costo único p/u de cualquier producto
param cap_prod := 12;       # Capacidad máxima de producción de cualquier producto en lotes/mes
param cap_dep := 900;       # Capacidad del depósito en unidades, entre todos los productos

param d[P*M] :=       |  1,   2,   3,   4,   5|  # Demanda estimada en unidades de cada producto
                  | 1 | 20,  30,  10,  15,  15|  # i en P, en cada mes j en M
                  | 2 | 25,  40,  15,  20,  15|
                  | 3 | 30,  40,  15,  20,  20|
                  | 4 | 40,  45,  20,  20,  25|
                  | 5 | 60,  90,  30,  45,  70|
                  | 6 |100, 140,  50,  70, 100|
                  | 7 |180, 210,  90, 105, 150|
                  | 8 |210, 250, 105, 125, 160|
                  | 9 |150, 170,  75,  85, 140|
                  |10 | 60,  60,  30,  30,  70|
                  |11 | 30,  40,  15,  20,  40|
                  |12 | 20,  25,  10,  15,  20|
                  |13 | 20,  30,  10,  15,  15|
                  |14 | 25,  40,  15,  20,  15|
                  |15 | 30,  40,  15,  20,  20|
                  |16 | 40,  45,  20,  20,  25|
                  |17 | 60,  90,  30,  45,  70|
                  |18 |100, 140,  50,  70, 100|
                  |19 |180, 210,  90, 105, 150|
                  |20 |210, 250, 105, 125, 160|
                  |21 |150, 170,  75,  85, 140|
                  |22 | 60,  60,  30,  30,  70|
                  |23 | 30,  40,  15,  20,  40|
                  |24 | 20,  25,  10,  15,  20|

# VARIABLES

var x[P*M] integer              # Cantidad de lotes (de 10u) producida del producto i en P en el mes j en M
var s[P*M_ALT] integer          # Stock del producto i en P en el mes j en M_ALT

# FUNCIÓN OBJETIVO

minimize costo: sum <i,j> in P*M: 10*x[i,j]*c

# RESTRICCIONES

subto stock: forall <i,j> in P*M: s[i,j] == s[i,j-1] + 10*x[i,j] - d[i,j]               # Stock dependiente de la producción (definición)

subto stock_inicial: forall <i> in P: s[i,0] == 0                                       # Stock incial nulo para todos los productos

subto prod_no_negativo: forall <i,j> in P*M: x[i,j] >= 0                                # Producción no-negativa

subto stock_no_negativo: forall <i,j> in P*M: s[i,j] >= 0                               # Stock no-negativo (no es necesario por las primeras dos reestricciones)

subto max_prod_mensual: forall <i,j> in P*M: x[i,j] <= cap_prod                         # Máxima producción mensual para todo producto es de 12 lotes

subto max_capacidad_stock: forall <j> in M: sum <i> in P: x[i,j] <= cap_dep             # Máxima capacidad de stock por mes
