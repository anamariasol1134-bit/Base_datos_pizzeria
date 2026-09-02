// consulta que se filtra los pedidos que se hicieron entre dos fechas 

select p.id as pedido_id, p.fecha,
c.id as cliente_id,
per.nombre as cliente, p.total
from pedidos p
join clientes c on p.cliente_fk = c.id
join persona per on per.cliente_fk = c.id
where p.fecha between '2026-08-01' and '2026-08-31';

//las pizzas mas vendidas

select pi_p.nombre as pizza, count(p.id) as total_vendidas
from pedidos p
join precios_pizzas pp on p.precio_pizza_fk = pp.id
join pizzas pi_p on pp.pizza_fk = pi_p.id
group by pi_p.id, pi_p.nombre
order by total_vendidas desc;

//numero de entregas que ha realizado cada repartidor

select r.id as repartidor_id, per.nombre as repartidor, count(d.id) as total_domicilios
from domicilios d
join repartidor r on d.repartidor_fk = r.id
join empleado e on r.empleado_fk = e.id
join persona per on per.empleado_fk = e.id
group by r.id, per.nombre;

//Calcula el costo promedio de los envios por zona

select r.zona_asignada, avg(d.costo_envio) as promedio_costo_envio
from domicilios d
join repartidor r on d.repartidor_fk = r.id
group by r.zona_asignada;

// clientes que han gastado mas que el valor que se indica

select c.id as cliente_id, per.nombre as cliente, sum(p.total) as gasto_total
from pedidos p
join clientes c on p.cliente_fk = c.id
join persona per on per.cliente_fk = c.id
group by c.id, per.nombre
having sum(p.total) > 50000;

//busca coincidencia de palabra en la tabla pizza
select id, nombre, tipo, descripcion 
from pizzas 
where nombre like '%pollo%';

//subconsulta de los clientes mas frecuentes

select per.nombre as cliente_frecuente, total_pedidos.cantidad_pedidos
from (
    select cliente_fk, count(*) as cantidad_pedidos
    from pedidos
    where cliente_fk is not null
    group by cliente_fk
    having count(*) > 2
) as total_pedidos
join clientes c on total_pedidos.cliente_fk = c.id
join persona per on per.cliente_fk = c.id;

-- Alertar sobre ingredientes con stock bajo
select 
    nombre,
    stock_actual,
    stock_minimo,
    round((stock_actual / stock_minimo) * 100, 2) as porcentaje_stock,
    case 
        when stock_actual < stock_minimo then 'CRÍTICO'
        when stock_actual < stock_minimo * 2 then 'BAJO'
        else 'OK'
    end as estado_stock
from ingredientes
where stock_actual < stock_minimo * 2
order by porcentaje_stock asc;