-- Muestra nombre del cliente, id del pedido, total y estado

select 
    per.nombre as cliente,
    p.id_pedido as pedido_id,
    p.total,
    p.estado
from pedidos p
join clientes c on p.id_cliente = c.id
join persona per on per.cliente_fk = c.id
order by per.nombre, p.fecha_pedido DESC;


-- Muestra pedidos con estado 'entregado' entre dos fechas

select p.id as pedido_id, p.fecha,
c.id as cliente_id,
per.nombre as cliente, p.total
from pedidos p
join clientes c on p.cliente_fk = c.id
join persona per on per.cliente_fk = c.id
where p.fecha between '2026-08-01' and '2026-08-31';


-- Muestra cantidad de pedidos y total acumulado por metodo de pago

select 
    metodo_pago,
    COUNT(*) as cantidad_pedidos,
    SUM(total) as total_acumulado
from pedidos
where estado != 'cancelado' 
group by metodo_pago
order by total_acumulado DESC;


-- Muestra clientes con mas de 5 pedidos en total

select
    per.nombre as cliente,
    COUNT(p.id_pedido) as total_pedidos,
    SUM(p.total) as gasto_total
from pedidos p
join clientes c on p.id_cliente = c.id
join persona per on per.cliente_fk = c.id
where p.estado != 'cancelado'  
group by per.id, per.nombre
having COUNT(p.id_pedido) > 5
order by total_pedidos DESC;
