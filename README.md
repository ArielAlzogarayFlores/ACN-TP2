# Aplicaciones Computacionales en Negocios — Trabajo Práctico N°2

Este repositorio contiene todo el código fuente correspondiente al *Trabajo Práctico N°2*
de la materia de *Aplicaciones Computacionales en Negocios*.

El trabajo plantea un modelo de **lot sizing** para planificar la producción mensual de
5 productos a lo largo de 24 meses, minimizando los costos de fabricación.

**Integrantes:** Ariel Alzogaray Flores, Camila Valdman, Josefina Deserti Gotta.

## Estructura

- `data/` — estimaciones de demanda por producto y mes (Tabla 1 de la consigna).
- `modelos/` — modelos en ZIMPL (`.zpl`), uno por cada ejercicio de la consigna.
- `scripts/` — archivos de comandos para SCIP (`.txt`) y script para correr todos los ejercicios (`.sh`).
- `soluciones/` — soluciones generadas por el solver (`.sol`).
- `informe/` — informe con la descripción de los modelos y los resultados obtenidos.

## Requisitos

- [SCIP](https://scipopt.org/) (incluye ZIMPL).

## Ejecución

Desde la raíz del repositorio, para un punto en particular:

```
read modelos/punto_1.zpl
optimize
display solution
write solution soluciones/punto_1.sol
```

De modo más directo pero solo con salida en terminal sin guardar nada:

```
scip -f modelos/punto_1.zpl
```

De modo más directo y guardando la solución:

```
scip -b comandos/punto_1.txt
```