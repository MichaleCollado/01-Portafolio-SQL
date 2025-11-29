/*
use BD_SQL_;

CREATE TABLE ventas (
    id_venta        SMALLINT      NOT NULL PRIMARY KEY,
    id_cliente      SMALLINT      NULL,
    id_producto     TINYINT       NULL,
    id_vendedor     TINYINT       NULL,
    fecha_venta     DATE          NULL,
    cantidad        TINYINT       NULL,
    precio_unitario FLOAT         NULL,
    canal           NVARCHAR(100) NULL,
    region          NVARCHAR(100) NULL,
    estado_entrega  NVARCHAR(100) NULL);
BULK INSERT ventas
FROM 'C:/Users/USER/Desktop/SQL/ventas.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);


CREATE TABLE clientes (
    id_cliente       SMALLINT       NOT NULL PRIMARY KEY,
    nombre           NVARCHAR(100)  NULL,
    fecha_registro   DATE           NULL,
    pais             NVARCHAR(100)  NULL,
    ciudad           NVARCHAR(100)  NULL,
    edad             TINYINT        NULL,
    genero           NVARCHAR(100)  NULL);
BULK INSERT clientes
FROM 'C:/Users/USER/Desktop/SQL/clientes.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);


CREATE TABLE productos (
    id_producto        TINYINT        NOT NULL PRIMARY KEY,
    nombre_producto    NVARCHAR(100)  NULL,
    categoria          NVARCHAR(100)  NULL,
    precio_lista       FLOAT          NULL,
    costo              FLOAT          NULL,
    fecha_lanzamiento  DATE           NULL);
BULK INSERT productos
FROM 'C:/Users/USER/Desktop/SQL/productos.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);


CREATE TABLE empleados (
    id_vendedor        TINYINT        NOT NULL PRIMARY KEY,
    nombre             NVARCHAR(100)  NULL,
    cargo              NVARCHAR(100)  NULL,
    id_jefe            NVARCHAR(2)    NULL,
    id_departamento    TINYINT        NULL,
    fecha_contratacion DATE           NULL,
    salario            FLOAT          NULL);
BULK INSERT empleados
FROM 'C:/Users/USER/Desktop/SQL/empleados.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);


CREATE TABLE departamentos (
    id_departamento     TINYINT        NOT NULL PRIMARY KEY,
    nombre_departamento NVARCHAR(100)  NULL,
    ubicacion           NVARCHAR(100)  NULL);
BULK INSERT departamentos
FROM 'C:/Users/USER/Desktop/SQL/departamentos.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2);
*/

/* ====== VISTA DE TABLAS====== */

use BD_SQL_;
select * from clientes;
select * from departamentos;
select * from empleados;
select * from productos;
select * from ventas;

/* ======🟡 NIVEL BÁSICO====== */

/* 1.Mostrar todos los registros de la tabla clientes. */
select * 
from clientes;

/* 2.Listar los nombres de todos los productos disponibles. */
select id_producto, nombre_producto 
from productos;

/* 3.Obtener los nombres y salarios de todos los empleados. */
select id_vendedor, nombre, salario
from empleados;

/* 4.Mostrar las ventas realizadas en el año 2024. */
select * 
from ventas
where datepart(year, fecha_venta) = 2024;

/* 5.Listar los clientes registrados en el último mes. */
select *
from clientes
where fecha_registro >= dateadd(month,-1,datetrunc(month, sysdatetime()))
  and fecha_registro < datetrunc(month, sysdatetime());

/* 6.Calcular el total de ingresos (cantidad * precio_unitario) de la tabla ventas. */
select
sum(precio_unitario * cantidad)
from ventas;

/* 7.Contar cuántas ventas se registraron por canal de venta. */
select
canal,
count(id_venta)
from ventas
group by canal;

/* 8.Mostrar los productos vendidos en la región 'Lima'. */
select
v.id_producto,
p.nombre_producto
from ventas v left join productos p
  on v.id_producto = p.id_producto
where v.region = 'Lima';

/* 9.Obtener el número total de clientes por país. */
select
pais,
count(id_cliente)
from clientes
group by pais;

/* 10.Mostrar los 10 clientes más recientes (ordenados por fecha_registro). */
select top (10)
id_cliente,
nombre,
fecha_registro
from clientes
order by fecha_registro desc;

/* 11.Listar las ventas donde la cantidad vendida sea mayor a 4 unidades. */
select *
from ventas
where cantidad > 4
order by cantidad desc;

/* 12.Calcular el precio de venta promedio por categoría de producto. */
select
p.categoria,
avg(v.precio_unitario) as precio_unit_promedio
from productos p left join ventas v
  on p.id_producto = v.id_producto
group by p.categoria;

/* 13.Mostrar los empleados cuyo salario es superior a 3000. */
select *
from empleados
where salario > 3000;

/* 14.Listar las ventas realizadas en el canal 'WEB' durante 2024. */
select *
from ventas
where canal = 'WEB'
  and datepart(year, fecha_venta) = 2024;

/* 15.Mostrar las categorías de producto distintos. */
select
categoria
from productos
group by categoria;

/* 16.Calcular el total de ventas por producto (SUM(cantidad * precio_unitario)). */
select
p.id_producto,
p.nombre_producto,
sum(v.precio_unitario * v.cantidad) as total_ventas
from productos p left join ventas v
  on p.id_producto = v.id_producto
group by p.id_producto, p.nombre_producto
order by total_ventas desc;

/* 17.Contar cuántos empleados tiene cada departamento. */
select
d.id_departamento,
count(e.id_vendedor) as Num_de_empleados
from departamentos d left join empleados e
  on d.id_departamento = e.id_departamento
group by d.id_departamento
order by Num_de_empleados desc;

/* 18.Mostrar las ventas agrupadas por región y canal. */
select
region, canal,
sum(precio_unitario * cantidad) as ventas_totales
from ventas
group by region, canal
order by region, ventas_totales desc;

/* 19.Calcular el monto promedio de venta por cliente. */
select
c.id_cliente,
c.nombre,
avg(v.precio_unitario * v.cantidad) as promedio_venta
from clientes c left join ventas v
  on c.id_cliente = v.id_cliente
group by c.id_cliente, c.nombre
order by promedio_venta desc;

/* 20.Obtener las fechas de la primera y última venta por cliente. */
select
c.id_cliente,
max(v.fecha_venta) as fecha_última_compra,
min(v.fecha_venta) as fecha_primera_compra
from clientes c left join ventas v
  on c.id_cliente = v.id_cliente
group by c.id_cliente
order by fecha_última_compra;

/* 21.Mostrar los clientes cuyo país es igual al país del cliente con id_cliente = 10.  */
select c2.*
from clientes c2
where c2.pais = (select c.pais from clientes c where c.id_cliente = 10)

/* 22.Listar los 5 productos más caros según precio_lista.  */
select top (5)
id_producto,
nombre_producto,
precio_lista
from productos
order by precio_lista desc;

/* 23.Mostrar los clientes que no tienen edad registrada (edad IS NULL).  */
select * 
from clientes
where edad is null;

/* 24.Calcular el total de ventas del producto más vendido.  */
with t1 as (
select top 1
v.id_producto,
sum(v.cantidad) as cantidad_ventas
from ventas v
group by v.id_producto
order by cantidad_ventas)

select
t1.id_producto,
sum(v1.precio_unitario * v1.cantidad) as ventas
from t1 left join ventas v1 on t1.id_producto = v1.id_producto
group by t1.id_producto;

/* 25.Mostrar las 5 ventas de mayor valor total  */
select top (5)
id_venta,
sum(precio_unitario * cantidad) as Total_venta
from ventas
group by id_venta
order by Total_venta desc


/* ======🟡 NIVEL INTERMEDIO====== */

/* 1.Obtener todos los empleados cuyo salario sea mayor al promedio general. */

select
id_vendedor,
nombre,
salario
from empleados
where salario > (
	select
	avg(salario) as avg_general
	from empleados)
order by salario;

/* 2.Listar los clientes que realizaron más de 5 compras en el último mes. */
with t1 as(
select
v.id_cliente,
c.nombre,
count(v.id_venta) as num_compras
from clientes c inner join ventas v
  on c.id_cliente = v.id_cliente
where v.fecha_venta > dateadd(month,-1,datetrunc(month, sysdatetime()))
      and v.fecha_venta < datetrunc(month, sysdatetime())
group by v.id_cliente, c.nombre)

select
id_cliente,
nombre,
num_compras
from t1
where num_compras > 5;

/* 3.Mostrar los productos que nunca fueron vendidos. */
select
p.id_producto,
p.nombre_producto
from productos p left join ventas v
  on p.id_producto = v.id_producto
where v.id_producto is null

/* 4.Calcular el salario promedio por departamento. */
select
d.id_departamento,
d.nombre_departamento,
avg(e.salario) as avg_salario
from departamentos d inner join empleados e
  on d.id_departamento = e.id_departamento
group by d.id_departamento, d.nombre_departamento

/* 5.Listar los empleados contratados en el mismo año que su jefe. */
select
    e.id_vendedor as id_empleado,
    e.nombre as nombre_empleado,
    e.fecha_contratacion as fecha_empleado,
    j.id_vendedor as id_jefe,
    j.nombre as nombre_jefe,
    j.fecha_contratacion as fecha_jefe
from empleados e inner join empleados j
  on e.id_jefe = j.id_vendedor
where datepart(year, e.fecha_contratacion) =
      datepart(year, j.fecha_contratacion);

/* 6.Encontrar las ventas cuyo monto sea mayor que el promedio del mismo mes. */
with t1 as(
select
datepart(year, fecha_venta) anio, 
datepart(month, fecha_venta) mes,
avg(precio_unitario * cantidad) as avg_mes
from ventas
group by datepart(year, fecha_venta), datepart(month, fecha_venta))

select
t1.anio,
t1.mes,
t1.avg_mes,
v.id_venta,
v.precio_unitario * cantidad
from ventas v inner join t1
  on datepart(year, fecha_venta) = anio
  and datepart(month, fecha_venta) = mes
where precio_unitario * cantidad > avg_mes;

/* 7.Mostrar los clientes que no tienen pedidos registrados. */
select
c.id_cliente,
c.nombre
from clientes c left join ventas v
  on c.id_cliente = v.id_cliente
where v.id_cliente is null;

/* 8.Listar los productos cuyo precio lista está por encima del promedio del categoría. */
with t1 as(
select
categoria,
avg(precio_lista) as avg_pl_catg
from productos
group by categoria)

select
p.categoria,
t1.avg_pl_catg,
p.id_producto,
p.nombre_producto,
p.precio_lista
from productos p inner join t1
  on p.categoria = t1.categoria
where p.precio_lista > t1.avg_pl_catg
order by p.id_producto desc;

/* 9.Mostrar los empleados con el segundo salario más alto por departamento. */
with t1 as(
select
id_departamento,
id_vendedor,
nombre,
salario,
dense_rank() over(partition by id_departamento order by salario) as ranking_salarios
from empleados)

select
id_departamento,
id_vendedor,
nombre,
salario
from t1
where ranking_salarios = 2

/* 10.Calcular el total de ventas por año y mes. */
select
datepart(year, fecha_venta) as anio,
datepart(month, fecha_venta) as mes,
sum(precio_unitario * cantidad) as total_perido_mes
from ventas
group by datepart(year, fecha_venta), datepart(month, fecha_venta)
order by anio, mes

/* 11.Encontrar los empleados que ganan igual que otro empleado (salarios duplicados). */
select
e1.id_vendedor,
e1.nombre
from empleados e1 inner join empleados e2
  on e1.id_vendedor <> e2.id_vendedor
where e1.salario = e2.salario;

/* 12.Mostrar los productos vendidos al menos en 3 países distintos. */
with t1 as(
select
p.id_producto, p.nombre_producto,
count(distinct c.pais) as num_paises
from ventas v inner join clientes c
     on v. id_cliente = c.id_cliente
	 inner join productos p
	 on v. id_producto = p.id_producto
group by p.id_producto, p.nombre_producto)

select
id_producto, nombre_producto, num_paises
from t1
where num_paises >= 3;

/* 13.Listar los pedidos que incluyen más de 5 productos diferentes. */
with t1 as (
select
id_venta,
count(distinct id_producto) as num_productos
from ventas
group by id_venta)

select
id_venta,
num_productos
from t1
where num_productos > 5

/* 14.Mostrar los departamentos que no tienen empleados. */ 
select
d.id_departamento,
d.nombre_departamento
from departamentos d left join empleados e
  on d.id_departamento = e.id_departamento
where e.id_departamento is null;

/* 15.Obtener el cliente con la compra más alta del año. */ 
with t1 as (
select
datepart(year, fecha_venta) as anio,
id_cliente,
sum(precio_unitario * cantidad) as total_venta,
dense_rank() over (partition by datepart(year, fecha_venta) order by sum(precio_unitario * cantidad) desc) as ranking
from ventas
group by datepart(year, fecha_venta), id_cliente)

select
*
from t1
where ranking = 1;

/* 16.Calcular la diferencia entre el salario más alto y el más bajo de cada departamento. */
select
d.id_departamento,
d.nombre_departamento,
max(salario) - min(salario) as dif_salarios
from departamentos d left join empleados e
  on d.id_departamento = e.id_departamento
group by d.id_departamento, d.nombre_departamento;

/* 17.Mostrar los empleados cuyo nombre comienza con 'A' y terminan con 'Z' .*/ 
select
*
from empleados
where nombre like 'a%z';

/* 18.Listar los productos que no se vendieron en los últimos 6 meses .*/ 
with t1 as(
select distinct
id_producto
from ventas
where fecha_venta >= dateadd(month, -6, datetrunc(month, sysdatetime()))
  and fecha_venta < datetrunc(month, sysdatetime()))

select
p.id_producto,
p.nombre_producto
from productos p left join t1
  on p.id_producto = t1.id_producto
where t1.id_producto is null;

/* 19.Obtener los tres clientes con más pedidos totales. */
with t1 as (
select
c.id_cliente,
c.nombre,
sum(v.precio_unitario * v.cantidad) as total,
dense_rank() over ( order by sum(v.precio_unitario * v.cantidad) desc) as ranking
from clientes c inner join ventas v
  on c.id_cliente = v.id_cliente
group by c.id_cliente, c.nombre)

select *
from t1
where ranking <= 3

/* 20.Mostrar el promedio de ventas por producto. */
select
p.id_producto,
p.nombre_producto,
avg(v.precio_unitario * v.cantidad) as avg_compras
from productos p inner join ventas v
  on p.id_producto = v.id_producto
group by p.id_producto, p.nombre_producto;

/* 21.Calcular el porcentaje que representa cada categoría sobre las ventas totales. */
select
p.categoria,
sum(v.precio_unitario * v.cantidad) / sum(sum(v.precio_unitario * v.cantidad)) over () * 100.0 as Parti
from productos p inner join ventas v
  on p.id_producto = v.id_producto
group by p.categoria
order by Parti desc;

/* 22.Mostrar los empleados que ganan más que su jefe. */
select
*
from empleados j inner join empleados e
  on j.id_jefe = e.id_vendedor
where j.salario > e.salario;

/* 23.Listar los pedidos entregados fuera de plazo. */
select *
from ventas
where estado_entrega = 'FUERA_DE_PLAZO';

/* 24.Obtener la cantidad de clientes por país. */
select
pais,
count(distinct id_cliente)
from clientes
group by pais;

/* 25.Calcular el total de ingresos por canal de venta. */
select
canal,
sum(precio_unitario * cantidad) as ingresos_por_canal
from ventas
group by canal;

/* 26.Mostrar los 2 productos más vendidos por región. */

with t1 as (
select
region,
id_producto,
sum(cantidad) as cantidad_vendida,
dense_rank() over (partition by region order by sum(cantidad) desc) as ranking
from ventas
group by region, id_producto)

select *
from t1
where ranking <= 2;


/* 27.Listar los empleados que llevan más de 10 años en la empresa. */
select
*
from empleados
where fecha_contratacion < dateadd(year, -10 , sysdatetime());

/* 28.Mostrar los clientes que compraron productos de todas las categorías. */
with t1 as(
select
v.id_cliente,
count(distinct p.categoria) as cant_categorias
from productos p inner join ventas v
  on p.id_producto = v.id_producto
group by v.id_cliente)

Select *
from t1
where cant_categorias = (select count(distinct categoria) as cant_tota_catego from productos);


/* 29.Calcular el promedio móvil de ventas de los últimos 3 meses. */
with t1 as(
select
datepart(year, fecha_venta) as anio,
datepart(month, fecha_venta) as mes,
sum(precio_unitario * cantidad) as total
from ventas
group by datepart(year, fecha_venta), datepart(month, fecha_venta))

select
anio,
mes,
total,
avg(total) over (order by anio, mes rows between 2 preceding and current row) as prom
from t1;

/* 30.Mostrar la diferencia en ventas entre el mes actual y el mes anterior. */
with t1 as(
select
datepart(year, fecha_venta) as anio,
datepart(month, fecha_venta) as mes,
sum(precio_unitario * cantidad) as total
from ventas
group by datepart(year, fecha_venta), datepart(month, fecha_venta))

select
anio, mes, 
total - lag(total) over (order by anio, mes) as diferencia
from t1;


/* ======🟡 NIVEL AVANZADO====== */

/* 1.Calcular la variación porcentual de ventas mes a mes por producto. */
with t1 as (
select
v.id_producto, p.nombre_producto,
datepart(year, fecha_venta) as anio,
datepart(month, fecha_venta) as mes,
sum(v.precio_unitario * v.cantidad) as total_venta,
lag(sum(v.precio_unitario * v.cantidad),1) over (partition by v.id_producto order by datepart(year, fecha_venta)) as total_venta_anterior
from ventas v inner join productos p
  on v.id_producto = p.id_producto
group by v.id_producto, p.nombre_producto, datepart(year, fecha_venta), datepart(month, fecha_venta))

select
id_producto, nombre_producto, anio, mes,
(total_venta - total_venta_anterior) / total_venta_anterior * 100
from t1;


/* 2.Identificar clientes con tres meses consecutivos de crecimiento en compras. */
with t1 as (
select
v.id_cliente, c.nombre, 
datepart(year, v.fecha_venta) as anio,
datepart(month, v.fecha_venta) as mes,
sum(v.precio_unitario * v.cantidad) as total_mes,
lag(sum(v.precio_unitario * v.cantidad),1) over (partition by v.id_cliente order by datepart(year, v.fecha_venta), datepart(month, v.fecha_venta)) as mes_anterior,
lag(sum(v.precio_unitario * v.cantidad),2) over (partition by v.id_cliente order by datepart(year, v.fecha_venta), datepart(month, v.fecha_venta)) as mes_trasanterior
from ventas v inner join clientes c
  on v.id_cliente = c.id_cliente
group by v.id_cliente, c.nombre, datepart(year, v.fecha_venta), datepart(month, v.fecha_venta)),

t2 as (
select
id_cliente, nombre, anio, mes, total_mes, mes_anterior, mes_trasanterior,
case when total_mes > mes_anterior and mes_anterior > mes_trasanterior then 1 else 0 end as MesesCrecimiento
from t1)

select
id_cliente, nombre, anio, mes, total_mes, mes_anterior, mes_trasanterior
from t2
where MesesCrecimiento = 0

/* 3.Calcular la mediana de salarios por departamento. */
select distinct
d.id_departamento,
d.nombre_departamento,
percentile_cont(0.5) within group (order by e.salario) over (partition by d.id_departamento) as media
from departamentos d left join empleados e
  on d.id_departamento = e.id_departamento;

/* 4.Mostrar los productos con ventas crecientes en los últimos tres periodos. */
with t1 as(
select
p.id_producto, 
p.nombre_producto,
datetrunc(month, v.fecha_venta) as mes,
sum(v.precio_unitario * v.cantidad) as t_mes_base,
lag(sum(v.precio_unitario * v.cantidad), 1) over (partition by p.id_producto order by datetrunc(month, v.fecha_venta)) as t_mes_sig,
lag(sum(v.precio_unitario * v.cantidad), 2) over (partition by p.id_producto order by datetrunc(month, v.fecha_venta)) as t_mes_2sig
from ventas v inner join productos p
  on v.id_producto = p.id_producto
group by p.id_producto, p.nombre_producto, datetrunc(month, v.fecha_venta)),

t2 as(
select *,
case when t_mes_base > t_mes_sig and t_mes_sig > t_mes_2sig then 1 else 0 end as Cumple
from t1)

select *
from t2
where Cumple = 1;

/* 5.Obtener el top 2 de vendedores por región usando funciones analíticas. */
with t1 as(
select
v.region,
e.id_vendedor,
e.nombre,
sum(v.precio_unitario * cantidad) as total,
dense_rank() over (partition by v.region order by sum(v.precio_unitario * cantidad)) as ranking
from ventas v inner join empleados e
  on v.id_vendedor = e.id_vendedor
group by v.region, e.id_vendedor, e.nombre)

select *
from t1
where ranking < 2 ;

/* 6.Detectar empleados que nunca tuvieron una reducción salarial. */
/* Repuesta: Identifica la falta de variables (columnas) para poder resolver esta pregunta */

/* 7.Calcular el acumulado de ventas (running total) por cliente. */
with t1 as(
select 
datetrunc(month, v.fecha_venta) as periodo,
v.id_cliente,
c.nombre,
sum(v.precio_unitario * v.cantidad) as total
from ventas v inner join clientes c
  on v.id_cliente = c.id_cliente
group by datetrunc(month, v.fecha_venta), v.id_cliente, c.nombre)

select *,
sum(total) over (partition by id_cliente order by periodo)
from t1;

/* 8.Determinar el tiempo promedio entre compras por cliente. */
with t1 as(
select
id_cliente,
id_venta,
fecha_venta,
lag(fecha_venta) over (partition by id_cliente order by fecha_venta) as fecha_venta_anterior
from ventas v)

select
id_cliente,
id_venta,
fecha_venta,
fecha_venta_anterior,
avg(datediff(day, fecha_venta_anterior, fecha_venta)) over (partition by id_cliente order by fecha_venta) as prom_tiempo
from t1

/* 9.Identificar los 10 productos con mayor rentabilidad (ingresos - costo). */
select
p.id_producto,
p.nombre_producto,
sum(v.precio_unitario * cantidad) - sum(p.precio_lista * v.cantidad) as rentabilidad
from productos p inner join ventas v
  on p.id_producto = v.id_producto
group by p.id_producto, p.nombre_producto

/* 10.Calcular la distribución porcentual de ventas por canal y mes. */
select
canal, 
datetrunc(month, fecha_venta) as periodo,
percent_rank() over (partition by canal order by sum(precio_unitario * cantidad)) * 100 as dist_porcentual
from ventas
group by canal, datetrunc(month, fecha_venta);

/* 11.Mostrar la tendencia de ventas trimestral (subida/bajada). */

with t1 as (
select
datepart(year, fecha_venta) as anio,
datepart(quarter, fecha_venta) as trimestre,
sum(precio_unitario * cantidad) as total,
lag(sum(precio_unitario * cantidad)) over (order by datepart(year, fecha_venta), datepart(quarter, fecha_venta)) as trimestre_anterior
from ventas
group by datepart(year, fecha_venta), datepart(quarter, fecha_venta))

select
*,
case when total < trimestre_anterior then 'bajada'
     when total > trimestre_anterior then 'subida'
	 when total = trimestre_anterior then 'sin_variacion'
	 else 'no_aplica'
	 end as indidicador
from t1;

/* 12.Encontrar empleados cuyo salario está por encima del percentil 90. */
with t1 as(
select
id_vendedor,
nombre,
percent_rank() over (order by salario) * 100 as percentil
from empleados)

select *
from t1
where percentil >= 90;

/* 13.Determinar los clientes inactivos por más de 90 días. */
with t1 as (
select
id_cliente,
max(fecha_venta) as ultima_compra
from ventas
group by id_cliente)

select
*
from t1
where ultima_compra < dateadd(day, -90, sysdatetime());

/* 14.Calcular la tasa de retención mensual de clientes. */
/* ubicamos los id_clientes que estan tanto en el mes anterior como en el mes presente */
with retenidos as(
select
datetrunc(month, t1.fecha_venta) as periodo_actual,
dateadd(month, -1, (datetrunc(month,t1.fecha_venta))) as periodo_anterior_t1,
t1.id_cliente as id_cliente_t1
from ventas t1 inner join ventas t2
  on t1.id_cliente = t2.id_cliente
 and dateadd(month, -1, (datetrunc(month,t1.fecha_venta))) = datetrunc(month,t2.fecha_venta))

select
datetrunc(month, v.fecha_venta) as periodo_p,
count(distinct a.id_cliente_t1) as cant_retenidos,
count(distinct v.id_cliente) as cant_cli_mes,
count(distinct a.id_cliente_t1) *1.0 / count(distinct v.id_cliente) *100 as porcentaje_retenidos
from ventas v inner join retenidos a
  on datetrunc(month, v.fecha_venta) = a.periodo_actual
group by datetrunc(month, v.fecha_venta);

/* 15.Mostrar el crecimiento acumulado de ventas año a año. */
with t1 as (
select
datetrunc(year, fecha_venta) as anio,
sum(precio_unitario * cantidad) as ventas_anio
from ventas
group by datetrunc(year, fecha_venta))


select
anio,
ventas_anio,
sum(ventas_anio) over(order by anio) as incremento_anual
from t1;

/* 16.Identificar productos con ventas duplicadas en diferentes regiones. */
select
v1.region,
v1.id_producto,
sum(v1.cantidad) as cantidad_1,
v2.region,
v2.id_producto,
sum(v2.cantidad) as cantidad_2
from ventas v1 inner join ventas v2
  on v1.region < v2.region
 and v1.id_producto = v2.id_producto
group by v1.region, v2.region, v1.id_producto, v2.id_producto;

/* 17.Calcular el promedio de ventas ponderado por cantidad. */
select
sum(precio_unitario * cantidad) / sum(cantidad) as ponderado
from ventas;

/* 18.Mostrar el top 5% de vendedores según facturación total. */
with t1 as (
select
v.id_vendedor, 
e.nombre,
percent_rank() 
  over (order by sum(precio_unitario * cantidad)) as ranking
from ventas v inner join empleados e
  on v.id_vendedor = e.id_vendedor
group by v.id_vendedor, e.nombre)

select *
from t1
where ranking >= 0.95;

/* 19.Detectar clientes cuya facturación está fuera del rango normal del global de compras. */
with t1 as (
select 
id_cliente,
sum(precio_unitario * cantidad) as total_cliente,
avg(sum(precio_unitario * cantidad)) over () as promedio_global,
stdev(sum(precio_unitario * cantidad)) over () as desvia_global
from ventas
group by id_cliente)

select
*
from t1 
where total_cliente > promedio_global + 2 * desvia_global
  and total_cliente < promedio_global - 2 * desvia_global;

/* 20.Calcular la cantidad de días promedio entre pedido por región. */
with t1 as(
select
region,
fecha_venta,
lead(fecha_venta,1) over (partition by region order by fecha_venta) as fecha_siguiente,
datediff(day, fecha_venta,lead(fecha_venta,1) over (partition by region  order by fecha_venta)) as dif_dias
from ventas)

select
region,
avg(dif_dias) as promedio_días_region
from t1 
group by region;

/* 21.Obtener las 3 categorías con mayor aumento de ventas interanual. */
with t1 as (
select
p.categoria,
datetrunc(year, v.fecha_venta) as periodo_anio,
sum(v.precio_unitario * v.cantidad) as ventas_anuales,
lag(sum(v.precio_unitario * v.cantidad), 1) over (partition by categoria order by datetrunc(year, v.fecha_venta)) as ventas_anuales_anterior,
sum(v.precio_unitario * v.cantidad) - lag(sum(v.precio_unitario * v.cantidad), 1) over (partition by categoria order by datetrunc(year, v.fecha_venta)) as variacion
from ventas v inner join productos p
  on v.id_producto = p.id_producto
group by p.categoria, datetrunc(year, v.fecha_venta)),

t2 as (
select categoria,
max(variacion) as v_max
from t1
group by categoria)

select top(3)
t1.categoria,
t1.periodo_anio,
t1.ventas_anuales,
t1.ventas_anuales_anterior,
t1.variacion
from t1 inner join t2
  on t1.categoria = t2.categoria
 and t1.variacion = t2.v_max
order by t1.variacion desc;

/* 22.Analizar qué porcentaje de clientes que generan el 80% de los ingresos (regla 80/20). */
with t1 as(
select
id_cliente,
sum(precio_unitario * cantidad) as venta,
percent_rank() over (order by sum(precio_unitario * cantidad)) * 100.00 as incremento_ventas
from ventas
group by id_cliente)

,t2 as (
select *,
count(id_cliente) over (order by incremento_ventas) * 1.0 /
count(id_cliente) over () * 100 as porcentaje_clientes
from t1)

select venta, incremento_ventas, porcentaje_clientes
from t2
where porcentaje_clientes <= 80;

/* 23.Encontrar el producto con mayor caída de ventas mes a mes. */
with t1 as(
select
datetrunc(month, fecha_venta) as periodo,
id_producto,
sum(precio_unitario * cantidad) as venta_mensual,
lag(sum(precio_unitario * cantidad),1) 
    over (partition by id_producto order by datetrunc(month, fecha_venta)) as venta_mes_anterior
from ventas
group by datetrunc(month, fecha_venta), id_producto)

,t2 as (
select
periodo,
min(venta_mes_anterior - venta_mensual) over (partition by periodo)  as menor_incremento
from t1)

select a.periodo, a.id_producto, b.menor_incremento 
from t1 a inner join t2 b
  on a.periodo = b.periodo
  and a.venta_mes_anterior - a.venta_mensual = b.menor_incremento
  and a.venta_mes_anterior is not null
 group by a.periodo, a.id_producto, b.menor_incremento;

/* 24.Calcular la media móvil de 6 meses por categoría de producto. */
select
p.categoria,
datetrunc(month, v.fecha_venta) as periodo,
sum(v.precio_unitario * v.cantidad) as item1,
avg(v.precio_unitario * v.cantidad) as promedio_de_importe_de_cada_mes,
avg(sum(v.precio_unitario * v.cantidad)) 
    over (partition by p.categoria 
	order by datetrunc(month, v.fecha_venta) 
	rows between 5 preceding and current row) as promedio_mensual
from ventas v inner join productos p
  on v.id_producto = p.id_producto
group by p.categoria, datetrunc(month, v.fecha_venta);

/* 25.Crear un ranking de clientes con base en su ticket promedio. */
select
id_cliente,
avg(precio_unitario * cantidad) as venta_promedio_cliente,
dense_rank() over (order by avg(precio_unitario * cantidad) desc) as ranking
from ventas
group by id_cliente;

/* 26.Calcular el promedio y desviación estándar de ventas por vendedor. */
select
id_vendedor,
avg(precio_unitario * cantidad) as promedio_venta_vendedor,
stdev(precio_unitario * cantidad) as desv_por_vendedor
from ventas
group by id_vendedor;

/* 27.Detectar duplicados en registros de transacciones. */
with t1 as(
select id_venta, id_cliente, id_producto, fecha_venta, cantidad, precio_unitario, canal, region, estado_entrega, count(*) as Cant_identicos
from ventas
group by id_venta, id_cliente, id_producto, fecha_venta, cantidad, precio_unitario, canal, region, estado_entrega)

select *
from t1 
where Cant_identicos > 1;

/* 28.Analizar clientes nuevos vs recurrentes en un periodo determinado. */
with t1 as(
select
v.id_cliente,
c.fecha_registro,
v.fecha_venta,
case when c.fecha_registro <= v.fecha_venta then 'nuevo' else 'antiguo' end as NuevoAntiguo
from ventas v inner join clientes c
  on v.id_cliente = c.id_cliente)

select
datetrunc(month,fecha_registro) as periodo_registro,
datetrunc(month,fecha_venta) as periodo_venta,
NuevoAntiguo,
count(NuevoAntiguo)
from t1
group by datetrunc(month,fecha_registro), datetrunc(month,fecha_venta), NuevoAntiguo;

/* 29.Calcular el crecimiento relativo del top 10 de clientes. */
with t1 as(
select top(10)
id_cliente,
sum(precio_unitario * cantidad) as venta_cliente
from ventas
group by id_cliente)

select
a.id_cliente,
datetrunc(month, v.fecha_venta) as periodo,
sum(v.precio_unitario * v.cantidad) as venta_mensual,
lag(sum(precio_unitario * cantidad),1) over (partition by a.id_cliente order by datetrunc(month, v.fecha_venta))
from t1 a inner join ventas v
  on a.id_cliente = v.id_cliente
group by a.id_cliente, datetrunc(month, v.fecha_venta); 

/* 30.Crear un resumen mensual con ventas acumuladas, ranking y porcentaje sobre total. */
select
datepart(month, fecha_venta) as periodo,
sum(precio_unitario * cantidad) as ventas_mes,
sum(sum(precio_unitario * cantidad)) over (order by datepart(month, fecha_venta)) as incremento_mensual,
dense_rank() over (order by sum(precio_unitario * cantidad) desc) as ranking_de_ventas_mensuales,
sum(sum(precio_unitario * cantidad)) over () as total_venta,
sum(precio_unitario * cantidad) * 1.0 / sum(sum(precio_unitario * cantidad)) over () *100 as porcentaje
from ventas
group by datepart(month, fecha_venta);

