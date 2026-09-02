-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL,
  `estado` ENUM('pendiente', 'preparando', 'entregado', 'cancelado') NULL,
  `metodo_pago` ENUM('efectivo', 'tarjeta', 'nequi') NULL,
  `total` DECIMAL NULL,
  `cliente_fk` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `cliente_fk_idx` (`cliente_fk` ASC) VISIBLE,
  CONSTRAINT `cliente_fk2`
    FOREIGN KEY (`cliente_fk`)
    REFERENCES `pizzeria`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedido_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido_pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pizza_fk` INT NULL,
  `pedido_fk` INT NULL,
  `cantidad` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `pizza_fk_idx` (`pizza_fk` ASC) VISIBLE,
  INDEX `pedido_fk1_idx` (`pedido_fk` ASC) VISIBLE,
  CONSTRAINT `pizza_fk1`
    FOREIGN KEY (`pizza_fk`)
    REFERENCES `pizzeria`.`pizzas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pedido_fk1`
    FOREIGN KEY (`pedido_fk`)
    REFERENCES `pizzeria`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO pedidos (id_cliente, fecha_pedido, metodo_pago, estado, total) VALUES 
(1, '2026-09-01', 'efectivo', 'entregado', 35000),
(2, '2026-09-02', 'tarjeta', 'entregado', 28000),
(3, '2026-09-03', 'nequi', 'pendiente', 45000),
(1, '2026-09-04', 'efectivo', 'entregado', 35000),
(2, '2026-09-05', 'tarjeta', 'preparacion', 28000),
(1, '2026-09-06', 'efectivo', 'entregado', 35000),
(3, '2026-09-07', 'nequi', 'cancelado', 45000);

INSERT INTO pedido_pizza (id_pedido, id_pizza, cantidad) VALUES 
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 1, 1),
(5, 2, 1),
(6, 1, 1),
(7, 3, 1);

