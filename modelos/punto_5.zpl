# EJERCICIO 4

# DEFINICIÓN DE CONJUNTOS Y PARAMETROS

set P := {1 .. 5};              # Productos
set M := {1 .. 24};             # Meses
set M_ALT := {0 .. 24};         # Meses (incluyendo el mes previo al inicio)

param c_x := 370;               # Costo único p/u producida de cualquier producto
param c_t := 540;               # Costo único p/u tercerizada de cualquier producto
param cap_prod := 12;           # Capacidad máxima de producción de cualquier producto en lotes/mes
param lim_prod := 30;           # Límite de producción total entre productos en lotes/mes
param lim_sup_terc := 200;      # Límite superior de tercerización total entre productos en unidades/mes
param lim_inf_terc := 20;       # Límite inferior de tercerización total entre productos en unidades/mes

param d[M*P] :=       |  1,   2,   3,   4,   5|  # Demanda estimada en unidades de cada mes
                  | 1 | 20,  30,  10,  15,  15|  # i en M, en cada producto j en P
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
                  |24 | 20,  25,  10,  15,  20|;

# VARIABLES

var x[M*P] integer;              # Cantidad de lotes (de 10 unidades c/u) producida del mes i en M sobre el producto j en P
var t[M*P] integer;              # Cantidad de unidades tercerizadas del mes i en M sobre el producto j en P
var s[M_ALT*P] integer;          # Stock en unidades del mes i en M_ALT sobre el producto j en P
var t_solicitada[M*P] binary;    # Determina si en un mes i en M se terceriza el producto j en P (1) o no (0)
var cap_dep integer;             # Capacidad del depósito en unidades, entre todos los productos

# FUNCIÓN OBJETIVO

minimize costo: sum <i,j> in M*P: cap_dep;

# RESTRICCIONES

subto stock_inicial: forall <j> in P: s[0,j] == 0;                                                          # Stock incial nulo para todos los productos

subto stock_def: forall <i,j> in M*P: s[i,j] == s[i-1,j] + 10*x[i,j] + t_solicitada[i,j]*t[i,j] - d[i,j];   # Stock dependiente de la producción (definición)

subto prod_no_negativo: forall <i,j> in M*P: x[i,j] >= 0;                                                   # Producción no-negativa

subto stock_no_negativo: forall <i,j> in M*P: s[i,j] >= 0;                                                  # Stock no-negativo (no es necesario por las primeras dos reestricciones)

subto max_prod_mensual: forall <i,j> in M*P: x[i,j] <= cap_prod;                                            # Máxima producción mensual para todo producto es de 12 lotes

subto max_capacidad_stock: forall <i> in M: sum <j> in P: s[i,j] <= cap_dep;                                # Máxima capacidad de stock por mes

subto limite_produccion: forall <i> in M: sum <j> in P: x[i,j] <= lim_prod;                                 # Restricción (2): cota superior de producción total en lotes/mes

subto limite_sup_tercerizacion: forall <i> in M: sum <j> in P: t[i,j] <= lim_sup_terc;                      # Restricción (3): cota superior de tercerización total en unidades/mes

subto limite_inf_tercerizacion: forall <i,j> in M*P: t[i,j] >= t_solicitada[i,j]*lim_inf_terc;              # Restricción (4): cota inferior de tercerización total en unidades/mes

subto capacidad_no_negativa: cap_dep >= 0                                                                   # Restricción (5): capacidad del depósito no-negativa