//calcula el total de un pedido teniendo en cuenta la pizza, costo de envio y iva

delimiter //

create function calcula_total_p(in id_pedido int) 
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

create procedure actualizar_estado_entregado(id_pedido int)
begin
    update domicilios 
    set hora_entrega = current_timestamp 
    where pedido_fk = id_pedido and hora_entrega is null;

    update pedidos 
    set estado = 'entregado' 
    where id = id_pedido;

end //

delimiter ;