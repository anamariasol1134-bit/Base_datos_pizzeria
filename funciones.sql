//calcula el total de un pedido teniendo en cuenta la pizza, costo de envio y iva

delimiter //

create function calcula_total_p( id_pedido int) 
returns double
reads sql data
begin
    declare v_precio_pizza double;
    declare v_cantidad int;
    declare v_costo_envio double;

    select p.precio, ped.cantidad 
    into v_precio_pizza, v_cantidad
    from pedidos ped
    join precios_pizzas p on ped.precio_pizza_fk = p.id
    where ped.id = id_pedido;

    select costo_envio 
    into v_costo_envio
    from domicilios
    where pedido_fk = id_pedido;

    return ((v_precio_pizza * v_cantidad) + v_costo_envio) * 1.19;

end //
--que el costo de envio sea por aparte o si no que primero que priero exista el domiclio para acceder al total final
delimiter ;

//resta los costos de los ingredientes a las ventas del dia para obtener la ganancia neta

delimiter //

create function calcula_ganancia_diaria(p_fecha date) 
returns double
reads sql data
begin
    declare v_total_ventas double;
    declare v_total_costos double;

    select ifnull(sum(p.monto), 0) 
    into v_total_ventas
    from pagos p
    where date(p.fecha_pago) = p_fecha and p.estado = 'completado';

    select ifnull(sum(i.costo_unitario * pi.cantida_cantidad), 0) 
    into v_total_costos
    from pedidos ped
    join precios_pizzas pp on ped.precio_pizza_fk = pp.id
    join pizza_ingrediente pi on pp.pizza_fk = pi.pizza_fk
    join ingredientes i on pi.ingrediente_fk = i.id
    where date(ped.fecha) = p_fecha;

    return v_total_ventas - v_total_costos;

end //

delimiter ;

//procedimiento que al registrar la hora de entrega cambie el estado del pedido a entregado

delimiter //

create procedure actualizar_estado_entregado(in id_pedido int)
begin
    update domicilios 
    set hora_entrega = current_timestamp 
    where pedido_fk = id_pedido and hora_entrega is null;

    update pedidos 
    set estado = 'entregado' 
    where id = id_pedido;

end //

delimiter ;
delimiter //

create function calcular_ganancia_pedido(p_id_pedido int) 
returns double
reads sql data
begin
    declare v_precio_venta double;
    declare v_costo_ingredientes double;
    declare v_costo_envio double;
    
    -- Precio de venta del pedido
    select (p.precio * ped.cantidad) + coalesce(d.costo_envio, 0)
    into v_precio_venta
    from pedidos ped
    join precios_pizzas p on ped.precio_pizza_fk = p.id
    left join domicilios d on d.pedido_fk = ped.id
    where ped.id = p_id_pedido;
    
    -- Costo de ingredientes
    select ifnull(sum(i.costo_unitario * pi.cantida_cantidad * ped.cantidad), 0)
    into v_costo_ingredientes
    from pedidos ped
    join precios_pizzas pp on ped.precio_pizza_fk = pp.id
    join pizza_ingrediente pi on pp.pizza_fk = pi.pizza_fk
    join ingredientes i on pi.ingrediente_fk = i.id
    where ped.id = p_id_pedido;
    
    return v_precio_venta - v_costo_ingredientes;
end //

delimiter ;

delimiter //

create procedure cancelar_pedido(in p_pedido_id int)
begin
    declare v_precio_pizza_fk int;
    declare v_cantidad int;
    
    -- Obtener datos del pedido
    select precio_pizza_fk, cantidad 
    into v_precio_pizza_fk, v_cantidad
    from pedidos 
    where id = p_pedido_id;
    
    -- Reponer stock
    update ingredientes i
    join pizza_ingrediente pi on i.id = pi.ingrediente_fk
    join precios_pizzas pp on pi.pizza_fk = pp.pizza_fk
    set i.stock_actual = i.stock_actual + (pi.cantida_cantidad * v_cantidad)
    where pp.id = v_precio_pizza_fk;
    
    -- Cambiar estado del pedido
    update pedidos 
    set estado = 'cancelado' 
    where id = p_pedido_id;
end //

delimiter ;
delimiter //

create procedure reabastecer_ingredientes()
begin
    -- Crear órdenes de compra para ingredientes con stock bajo
    insert into ordenes_compra (ingrediente_id, cantidad_solicitada, fecha_solicitud, estado)
    select 
        id,
        stock_minimo * 3 - stock_actual,
        current_date(),
        'pendiente'
    from ingredientes
    where stock_actual < stock_minimo;
end //

delimiter ;