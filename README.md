🗂🗂 SQL Portfolio – Análisis y Automatización de Datos
Autor: Michael Paul Collado Morales

Este repositorio contiene un conjunto de proyectos y ejercicios avanzados de SQL aplicados a escenarios reales de negocio.
Incluye consultas de análisis, KPIs, automatización, métricas móviles y diagnósticos sobre un dataset simulado de ventas, clientes y productos entre enero 2023 y julio 2025.

El objetivo es demostrar dominio en:
- Modelado y limpieza de datos
- Consultas avanzadas (CTEs, ventanas, agregaciones)
- Generación de KPIs y métricas de negocio
- Identificación de insights accionables
- Creación de datasets reproducibles
- Estructuración profesional de un proyecto de datos

🗂 Contenido del Repositorio
01-SQL-Portafolio/
- datasets/
  - ventas.csv
  - clientes.csv
  - productos.csv
  - empleados.csv
  - departamentos│
- queries-nivel_basico
- queris-nivel-intermedio
- queries-nivel-avanzado

🗂 Información Tablas
Ventas table:
- Columna Tipo Tamaño PermiteNulos
- id_venta	smallint	2	0
- id_cliente	smallint	2	1
- id_producto	tinyint	1	1
- id_vendedor	tinyint	1	1
- fecha_venta	date	3	1
- cantidad	tinyint	1	1
- precio_unitario	float	8	1
- canal	nvarchar	100	1
- region	nvarchar	100	1
- estado_entrega	nvarchar	100	1

Clientes table:
- Columna Tipo Tamaño PermiteNulos
- id_cliente	smallint	2	0
- nombre	nvarchar	100	1
- fecha_registro	date	3	1
- pais	nvarchar	100	1
- ciudad	nvarchar	100	1
- edad	tinyint	1	1
- genero	nvarchar	100	1

Productos table:
- Columna Tipo Tamaño PermiteNulos
- id_producto	tinyint	1	0
- nombre_producto	nvarchar	100	1
- categoria	nvarchar	100	1
- precio_lista	float	8	1
- costo	float	8	1
- fecha_lanzamiento	date	3	1

Empleados table:
- Columna Tipo Tamaño PermiteNulos
- id_vendedor	tinyint	1	0
- nombre	nvarchar	100	1
- cargo	nvarchar	100	1
- id_jefe	nvarchar	2	1
- id_departamento	tinyint	1	1
- fecha_contratacion	date	3	1
- salario	float	8	1

Departamentos table:
- Columna Tipo Tamaño PermiteNulos
- id_departamento	tinyint	1	0
- nombre_departamento	nvarchar	100	1
- ubicacion	nvarchar	100	1

🛠 Habilidades Demostradas

✔ SQL Avanzado
- Uso de CTEs
- Joins complejos
- Funciones ventana
- Subqueries correlacionadas
- Manejo de fechas
- KPIs dinámicos

✔ Análisis de negocio
- Product performance
- Cohortes
- Clientes recurrentes
- Basket analysis básico
- Tendencias y estacionalidad

✔ Automatización
- Construcción de KPIs mensuales
- Métricas móviles
- Ranking dinámico



🟡 NIVEL BÁSICO
==== Consultas introductorias ====
1.	Mostrar todos los registros de la tabla clientes.
2.	Listar los nombres de todos los productos disponibles.
3.	Obtener los nombres y salarios de todos los empleados.
4.	Mostrar las ventas realizadas en el año 2024.
5.	Listar los clientes registrados en el último mes.
6.	Calcular el total de ingresos (cantidad * precio_unitario) de la tabla ventas.
7.	Contar cuántas ventas se registraron por canal de venta.
8.	Mostrar los productos vendidos en la región 'NORTE'.
9.	Obtener el número total de clientes por país.
10.	Mostrar los 10 clientes más recientes (ordenados por fecha_registro).
==== Filtros y agregaciones ====
11.	Listar las ventas donde la cantidad vendida sea mayor a 10 unidades.
12.	Calcular el precio promedio por categoría de producto.
13.	Mostrar los empleados cuyo salario es superior a 3000.
14.	Listar las ventas realizadas en el canal 'WEB' durante 2024.
15.	Mostrar las categorías de producto distintas.
16.	Calcular el total de ventas por producto (SUM(cantidad * precio_unitario)).
17.	Contar cuántos empleados tiene cada departamento.
18.	Mostrar las ventas agrupadas por región y canal.
19.	Calcular el monto promedio de venta por cliente.
20.	Obtener las fechas de la primera y última venta por cliente.
==== Subconsultas simples y ordenaciones ====
21.	Mostrar los clientes cuyo país es igual al país del cliente con id_cliente = 10.
22.	Listar los 5 productos más caros según precio_lista.
23.	Mostrar los clientes que no tienen edad registrada (edad IS NULL).
24.	Calcular el total de ventas del producto más vendido.
25.	Mostrar las 5 ventas de mayor valor total (cantidad * precio_unitario).

🟡 NIVEL INTERMEDIO
1.	Obtener todos los empleados cuyo salario sea mayor al promedio general.
2.	Listar los clientes que realizaron más de 5 compras en el último mes.
3.	Mostrar los productos que nunca fueron vendidos.
4.	Calcular el salario promedio por departamento.
5.	Listar los empleados contratados en el mismo año que su jefe.
6.	Encontrar las ventas cuyo monto sea mayor que el promedio del mismo mes.
7.	Mostrar los clientes que no tienen pedidos registrados.
8.	Listar los productos cuyo precio está por encima del promedio del catálogo.
9.	Mostrar los empleados con el segundo salario más alto por departamento.
10.	Calcular el total de ventas por mes y año.
11.	Encontrar los empleados que ganan igual que otro empleado (salarios duplicados).
12.	Mostrar los productos vendidos al menos en 3 países distintos.
13.	Listar los pedidos que incluyen más de 5 productos diferentes.
14.	Mostrar los departamentos que no tienen empleados.
15.	Obtener el cliente con la compra más alta del año.
16.	Calcular la diferencia entre el salario más alto y el más bajo de cada departamento.
17.	Mostrar los empleados cuyo nombre comienza con 'A' y terminan con 'Z'.
18.	Listar los productos que no se vendieron en los últimos 6 meses.
19.	Obtener los tres clientes con más pedidos totales.
20.	Mostrar el promedio de ventas por tipo de producto.
21.	Calcular el porcentaje que representa cada categoría sobre las ventas totales.
22.	Mostrar los empleados que ganan más que su jefe.
23.	Listar los pedidos entregados fuera de plazo.
24.	Obtener la cantidad de clientes por país.
25.	Calcular el total de ingresos por canal de venta.
26.	Mostrar los 5 productos más vendidos por región.
27.	Listar los empleados que llevan más de 10 años en la empresa.
28.	Mostrar los clientes que compraron productos de todas las categorías.
29.	Calcular el promedio móvil de ventas de los últimos 3 meses.
30.	Mostrar la diferencia en ventas entre el mes actual y el mes anterior.

🟡 NIVEL AVANZADO
1.	Calcular la variación porcentual de ventas mes a mes por producto.
2.	Identificar clientes con tres meses consecutivos de crecimiento en compras.
3.	Calcular la mediana de salarios por departamento.
4.	Mostrar los productos con ventas crecientes en los últimos tres periodos.
5.	Obtener el top 3 de vendedores por región usando funciones analíticas.
6.	Detectar empleados que nunca tuvieron una reducción salarial.
7.	Calcular el acumulado de ventas (running total) por cliente.
8.	Determinar el tiempo promedio entre compras por cliente.
9.	Identificar los 10 productos con mayor rentabilidad (ingresos - costo).
10.	Calcular la distribución porcentual de ventas por canal y mes.
11.	Mostrar la tendencia de ventas trimestral (subida/bajada).
12.	Encontrar empleados cuyo salario está por encima del percentil 90.
13.	Determinar los clientes inactivos por más de 90 días.
14.	Calcular la tasa de retención mensual de clientes.
15.	Mostrar el crecimiento acumulado de ventas año a año.
16.	Identificar productos con ventas duplicadas en diferentes regiones.
17.	Calcular el promedio de ventas ponderado por cantidad.
18.	Mostrar el top 5% de vendedores según facturación total.
19.	Detectar clientes con patrones de compra anómalos (fuera de rango promedio).
20.	Calcular la cantidad de días promedio entre pedido y entrega por región.
21.	Obtener las 3 categorías con mayor aumento de ventas interanual.
22.	Analizar qué porcentaje de clientes genera el 80% de los ingresos (regla 80/20).
23.	Encontrar el producto con mayor caída de ventas mes a mes.
24.	Calcular la media móvil de 6 meses por categoría de producto.
25.	Crear un ranking de clientes con base en su ticket promedio.
26.	Calcular el promedio y desviación estándar de ventas por vendedor.
27.	Detectar duplicados en registros de transacciones.
28.	Analizar clientes nuevos vs recurrentes en un periodo determinado.
29.	Calcular el crecimiento relativo del top 10 de clientes.
30.	Crear un resumen mensual con ventas acumuladas, ranking y porcentaje sobre total.




