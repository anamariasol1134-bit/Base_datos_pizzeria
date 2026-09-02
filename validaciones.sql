delimiter //

create trigger validar_stock_pedido
before insert on pedidos
for each row
begin
    declare ingredientes_faltantes int;
    
    select count(*) into ingredientes_faltantes
    from pizza_ingrediente pi
    join ingredientes i on pi.ingrediente_fk = i.id
    join precios_pizzas pp on pi.pizza_fk = pp.pizza_fk
    where pp.id = new.precio_pizza_fk
    and i.stock_actual < (pi.cantida_cantidad * new.cantidad);
    
    if ingredientes_faltantes > 0 then
        signal sqlstate '45000'
        set message_text = 'No hay suficiente stock de ingredientes';
    end if;
end //

delimiter ;

delimiter //

create trigger validar_cliente_activo
before insert on pedidos
for each row
begin
    declare v_cliente_existe int;
    
    select count(*) into v_cliente_existe
    from clientes c
    join persona p on p.cliente_fk = c.id
    where c.id = new.cliente_fk;
    
    if v_cliente_existe = 0 then
        signal sqlstate '45000'
        set message_text = 'El cliente no existe o no está registrado';
    end if;
end //

delimiter ;

delimiter //

create trigger validar_cajero_existe
before insert on pedidos
for each row
begin
    declare v_cajero_existe int;
    
    select count(*) into v_cajero_existe
    from cajero
    where id = new.cajero_fk;
    
    if v_cajero_existe = 0 then
        signal sqlstate '45000'
        set message_text = 'El cajero no existe';
    end if;
end //

delimiter ;

delimiter //

create trigger validar_precio_pizza
before insert on pedidos
for each row
begin
    declare v_precio_existe int;
    
    select count(*) into v_precio_existe
    from precios_pizzas
    where id = new.precio_pizza_fk;
    
    if v_precio_existe = 0 then
        signal sqlstate '45000'
        set message_text = 'El precio de pizza seleccionado no existe';
    end if;
end //

delimiter ;

delimiter //

create trigger validar_cantidad_pedido
before insert on pedidos
for each row
begin
    if new.cantidad <= 0 then
        signal sqlstate '45000'
        set message_text = 'La cantidad del pedido debe ser mayor a 0';
    end if;
end //

delimiter ;

delimiter //

create trigger validar_total_pedido
before insert on pedidos
for each row
begin
    declare v_precio_unitario double;
    declare v_costo_envio double;
    declare v_total_calculado double;
    
    -- Obtener precio de la pizza
    select precio into v_precio_unitario
    from precios_pizzas
    where id = new.precio_pizza_fk;
    
    -- Obtener costo de envío (si existe domicilio)
    select ifnull(costo_envio, 0) into v_costo_envio
    from domicilios
    where pedido_fk = new.id;
    
    -- Calcular total esperado (precio * cantidad + envío) * 1.19 (IVA)
    set v_total_calculado = ((v_precio_unitario * new.cantidad) + v_costo_envio) * 1.19;
    
    -- Si el total ingresado es muy diferente al calculado (margen 100 pesos)
    if abs(new.total - v_total_calculado) > 100 then
        signal sqlstate '45000'
        set message_text = 'El total del pedido no coincide con el cálculo esperado';
    end if;
end //

delimiter ;
delimiter //

create trigger validar_repartidor_ocupado
before insert on domicilios
for each row
begin
    declare v_domicilios_activos int;
    
    select count(*) into v_domicilios_activos
    from domicilios
    where repartidor_fk = new.repartidor_fk
    and hora_entrega is null;
    
    if v_domicilios_activos >= 3 then
        signal sqlstate '45000'
        set message_text = 'El repartidor ya tiene demasiados domicilios activos';
    end if;
end //

delimiter ;

delimiter //

create trigger validar_stock_ingrediente
before update on ingredientes
for each row
begin
    if new.stock_actual < 0 then
        signal sqlstate '45000'
        set message_text = 'El stock no puede ser negativo';
    end if;
end //

delimiter ;
