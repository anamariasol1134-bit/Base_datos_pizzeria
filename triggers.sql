//disparador para descontar el stock de ingredientes cada vez se genera un pedido

delimiter //

create trigger actualizar_stock_pedido
after insert on pedidos
for each row
begin
    update ingredientes i
    join pizza_ingrediente pi on i.id = pi.ingrediente_fk
    join precios_pizzas pp on pi.pizza_fk = pp.pizza_fk
    set i.stock_actual = i.stock_actual - pi.cantida_cantidad
    where pp.id = new.precio_pizza_fk;

end //

delimiter ;

//lleva registro de id,precio_anterior, precio_nuevo,fecha_cambio y de que pizza se hizo el cambio

delimiter //

create trigger auditoria_historial_precios
before update on precios_pizzas
for each row
begin
    if old.precio != new.precio then
        insert into historial_precios (pizza_fk, precio_anterior, precio_nuevo, fecha_cambio)
        values (old.id, old.precio, new.precio, current_timestamp());
    end if;
end //

delimiter ;

//disparador para cuando un repartidor para su hora de entrega su estado cambie otra vez a disponible

delimiter //

create trigger repartidor_disponible
after update on domicilios
for each row
begin
    if old.hora_entrega is null and new.hora_entrega is not null then
        update repartidor
        set estado = 'disponible'
        where id = new.repartidor_fk;
    end if;
end //

delimiter ;