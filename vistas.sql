// resumen pedido por cliente y cantidad total

create view resumen_pedidos_cliente as
select p.nombre as cliente, count(ped.id) as cantidad_pedidos, sum(ped.total) as total_gastado
from clientes c
join persona p on c.id = p.cliente_fk
join pedidos ped on c.id = ped.cliente_fk
group by c.id, p.nombre;

// resumen de desempeño repartidores

create view desempeno_repartidores as
select r.zona_asignada, count(d.id) as numero_entregas, avg(timestampdiff(minute, d.hora_salida, d.hora_entrega)) as tiempo_promedio_minutos
from repartidor r
join domicilios d on r.id = d.repartidor_fk
where d.hora_entrega is not null
group by r.zona_asignada;

// alerta de inventario 

create view stock_critico_ingredientes as
select id, nombre, stock_actual, stock_minimo, costo_unitario
from ingredientes
where stock_actual < stock_minimo;

create view reporte_ventas_diarias as
select 
    date(ped.fecha) as fecha,
    count(ped.id) as total_pedidos,
    sum(ped.total) as ventas_totales,
    sum(ped.cantidad) as pizzas_vendidas,
    avg(ped.total) as promedio_pedido
from pedidos ped
where ped.estado != 'cancelado'
group by date(ped.fecha)
order by fecha desc;