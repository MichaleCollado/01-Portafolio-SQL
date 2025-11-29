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
