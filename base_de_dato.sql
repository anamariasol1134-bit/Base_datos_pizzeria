-- MySQL Workbench Forward Engineering



SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



-- -----------------------------------------------------

-- Schema pizzeria

-- -----------------------------------------------------



-- -----------------------------------------------------

-- Schema pizzeria

-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;

USE `pizzeria` ;



-- -----------------------------------------------------

-- Table `pizzeria`.`clientes`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `direccion` VARCHAR(100) NULL,

  PRIMARY KEY (`id`))

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`empleado`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `salario_base` DOUBLE NULL,

  `fecha_ingreso` DATE NULL,

  PRIMARY KEY (`id`))

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`repartidor`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`repartidor` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `zona_asignada` VARCHAR(50) NULL,

  `licencia` VARCHAR(20) NULL,

  `vehiculo` ENUM('moto', 'bici') NULL,

  `estado` ENUM('disponible', 'ocupado') NULL,

  `empleado_fk` INT NULL,

  PRIMARY KEY (`id`),

  INDEX `empleado_fk_idx` (`empleado_fk` ASC) VISIBLE,

  CONSTRAINT `empleado_fk1`

    FOREIGN KEY (`empleado_fk`)

    REFERENCES `pizzeria`.`empleado` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`cajero`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`cajero` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `empleado_fk` INT NULL,

  PRIMARY KEY (`id`),

  INDEX `empleado_fk_idx` (`empleado_fk` ASC) VISIBLE,

  CONSTRAINT `empleado_fk2`

    FOREIGN KEY (`empleado_fk`)

    REFERENCES `pizzeria`.`empleado` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`persona`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`persona` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `nombre` VARCHAR(100) NULL,

  `telefono` VARCHAR(20) NULL,

  `email` VARCHAR(100) NULL,

  `fecha_registro` DATE NULL,

  `empleado_fk` INT NULL,

  `cliente_fk` INT NULL,

  PRIMARY KEY (`id`),

  INDEX `empleado_fk_idx` (`empleado_fk` ASC) VISIBLE,

  INDEX `cliente_fk_idx` (`cliente_fk` ASC) VISIBLE,

  CONSTRAINT `empleado_fk3`

    FOREIGN KEY (`empleado_fk`)

    REFERENCES `pizzeria`.`empleado` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `cliente_fk1`

    FOREIGN KEY (`cliente_fk`)

    REFERENCES `pizzeria`.`clientes` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`pizzas`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzas` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `nombre` VARCHAR(45) NULL,

  `tipo` ENUM('vegetariana', 'pollo', 'especial', 'napolitana', 'hawaiana') NULL,

  `descripcion` VARCHAR(100) NULL,

  PRIMARY KEY (`id`))

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`tamaño`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`tamaño` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `nombre` VARCHAR(45) NULL,

  PRIMARY KEY (`id`))

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`precios_pizzas`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`precios_pizzas` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `pizza_fk` INT NULL,

  `tamaño_fk` INT NULL,

  `precio` DOUBLE NULL,

  PRIMARY KEY (`id`),

  INDEX `pizza_fk_idx` (`pizza_fk` ASC) VISIBLE,

  INDEX `tamaño_fk_idx` (`tamaño_fk` ASC) VISIBLE,

  CONSTRAINT `pizza_fk1`

    FOREIGN KEY (`pizza_fk`)

    REFERENCES `pizzeria`.`pizzas` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `tamaño_fk1`

    FOREIGN KEY (`tamaño_fk`)

    REFERENCES `pizzeria`.`tamaño` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`ingredientes`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`ingredientes` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `nombre` VARCHAR(45) NULL,

  `stock_actual` DECIMAL NULL,

  `stock_minimo` DECIMAL NULL,

  `costo_unitario` DECIMAL NULL,

  PRIMARY KEY (`id`))

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`pizza_ingrediente`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_ingrediente` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `cantida_cantidad` DECIMAL NULL,

  `ingrediente_fk` INT NULL,

  `pizza_fk` INT NULL,

  PRIMARY KEY (`id`),

  INDEX `ingrediente_fk_idx` (`ingrediente_fk` ASC) VISIBLE,

  INDEX `pizza_fk_idx` (`pizza_fk` ASC) VISIBLE,

  CONSTRAINT `ingrediente_fk1`

    FOREIGN KEY (`ingrediente_fk`)

    REFERENCES `pizzeria`.`ingredientes` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `pizza_fk2`

    FOREIGN KEY (`pizza_fk`)

    REFERENCES `pizzeria`.`pizzas` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`pedidos`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `fecha` DATE NULL,

  `estado` ENUM('pendiente', 'preparando', 'entregado', 'cancelado') NULL,

  `metodo_pago` ENUM('efectivo', 'tarjeta', 'nequi') NULL,

  `total` DECIMAL NULL,

  `cantidad` INT NULL,

  `cliente_fk` INT NULL,

  `cajero_fk` INT NULL,

  `precio_pizza_fk` INT NULL,

  PRIMARY KEY (`id`),

  INDEX `cliente_fk_idx` (`cliente_fk` ASC) VISIBLE,

  INDEX `cajero_fk_idx` (`cajero_fk` ASC) VISIBLE,

  INDEX `precio_pizza_fk_idx` (`precio_pizza_fk` ASC) VISIBLE,

  CONSTRAINT `cliente_fk2`

    FOREIGN KEY (`cliente_fk`)

    REFERENCES `pizzeria`.`clientes` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `cajero_fk1`

    FOREIGN KEY (`cajero_fk`)

    REFERENCES `pizzeria`.`cajero` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `precio_pizza_fk1`

    FOREIGN KEY (`precio_pizza_fk`)

    REFERENCES `pizzeria`.`precios_pizzas` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`domicilios`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`domicilios` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `direccion_entrega` VARCHAR(200) NULL,

  `hora_salida` DATETIME NULL,

  `hora_entrega` DATETIME NULL,

  `costo_envio` DOUBLE NULL,

  `barrio` VARCHAR(45) NULL,

  `repartidor_fk` INT NOT NULL,

  `pedido_fk` INT NULL,

  PRIMARY KEY (`id`),

  INDEX `repartidor_fk_idx` (`repartidor_fk` ASC) VISIBLE,

  INDEX `pedido_fk_idx` (`pedido_fk` ASC) VISIBLE,

  CONSTRAINT `repartidor_fk1`

    FOREIGN KEY (`repartidor_fk`)

    REFERENCES `pizzeria`.`repartidor` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `pedido_fk1`

    FOREIGN KEY (`pedido_fk`)

    REFERENCES `pizzeria`.`pedidos` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`pagos`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`pagos` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `monto` DOUBLE NULL,

  `fecha_pago` DATETIME NULL,

  `estado` ENUM('pendiente', 'completado', 'fallido') NULL,

  `pedido_fk` INT NULL,

  PRIMARY KEY (`id`),

  INDEX `pedido_fk_idx` (`pedido_fk` ASC) VISIBLE,

  CONSTRAINT `pedido_fk2`

    FOREIGN KEY (`pedido_fk`)

    REFERENCES `pizzeria`.`pedidos` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `pizzeria`.`historial_precios`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `pizzeria`.`historial_precios` (

  `id` INT NOT NULL AUTO_INCREMENT,

  `precio_anterior` DOUBLE NULL,

  `precio_nuevo` DOUBLE NULL,

  `fecha_cambio` DATETIME NULL,

  `pizza_fk` INT NULL,

  PRIMARY KEY (`id`),

  INDEX `pizza_fk_idx` (`pizza_fk` ASC) VISIBLE,

  CONSTRAINT `pizza_fk3`

    FOREIGN KEY (`pizza_fk`)

    REFERENCES `pizzeria`.`pizzas` (`id`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





SET SQL_MODE=@OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into clientes (direccion) values 
('calle 35 #12-45, bucaramanga'),
('carrera 27 #45-10, floridablanca'),
('calle 105 #22-15, girón'),
('diagonal 15 #55-30, bucaramanga'),
('calle 45 #23-11, bucaramanga');

insert into empleado (salario_base, fecha_ingreso) values 
(1300000, '2024-01-15'),
(1300000, '2024-02-01'),
(1400000, '2024-03-10'),
(1350000, '2024-05-15');

insert into cajero (empleado_fk) values (1), (4);

insert into repartidor (zona_asignada, licencia, vehiculo, estado, empleado_fk) values 
('norte', 'lic-9876', 'moto', 'disponible', 2),
('sur', 'lic-5432', 'bici', 'disponible', 3);

insert into persona (nombre, telefono, email, fecha_registro, empleado_fk, cliente_fk) values 
('carlos mendoza', '3151234567', 'carlos@gmail.com', '2026-08-01', null, 1),
('laura gómez', '3187654321', 'laura@gmail.com', '2026-08-05', null, 2),
('andrea silva', '3009876543', 'andrea@gmail.com', '2026-08-10', null, 3),
('felipe rojas', '3123334455', 'felipe@gmail.com', '2026-08-12', null, 4),
('camilo torres', '3118889900', 'camilo@gmail.com', '2026-08-15', null, 5),
('andrés pérez', '3001112233', 'andres@pizzeria.com', '2024-01-15', 1, null),
('mateo silva', '3124445566', 'mateo@pizzeria.com', '2024-02-01', 2, null),
('javier ortiz', '3195556677', 'javier@pizzeria.com', '2024-03-10', 3, null),
('pedro ramírez', '3174443322', 'pedro@pizzeria.com', '2024-05-15', 4, null);

insert into pizzas (nombre, tipo, descripcion) values 
('especial pepperoni', 'especial', 'pepperoni con extra queso mozzarella'),
('margarita', 'vegetariana', 'salsa de tomate, albahaca y queso mozzarella'),
('pollo champiñones', 'pollo', 'pollo desmechado con champiñones frescos'),
('hawaiana', 'hawaiana', 'jamón, piña y queso mozzarella'),
('cuatro quesos', 'especial', 'mezcla de mozarrella, parmesano, azul y provolone');

insert into tamaño (nombre) values 
('personal'),
('mediana'),
('familiar');

insert into precios_pizzas (pizza_fk, tamaño_fk, precio) values 
(1, 2, 35000),
(1, 3, 48000),
(2, 1, 22000),
(2, 2, 28000),
(3, 2, 36000),
(4, 3, 45000),
(5, 3, 52000);

insert into ingredientes (nombre, stock_actual, stock_minimo, costo_unitario) values 
('queso mozzarella', 50.0, 10.0, 5000),
('salsa de tomate', 30.0, 5.0, 2000),
('pepperoni', 20.0, 4.0, 8000),
('pollo desmechado', 15.0, 5.0, 7000),
('champiñones', 3.0, 5.0, 3000),
('piña en almíbar', 12.0, 3.0, 2500);

insert into pizza_ingrediente (cantida_cantidad, ingrediente_fk, pizza_fk) values 
(2.0, 1, 1),
(1.0, 2, 1),
(1.5, 3, 1),
(1.5, 1, 2),
(1.0, 2, 2),
(1.5, 4, 3),
(1.0, 5, 3);

insert into pedidos (fecha, estado, metodo_pago, total, cantidad, cliente_fk, cajero_fk, precio_pizza_fk) values 
('2026-08-20', 'entregado', 'efectivo', 35000, 1, 1, 1, 1),
('2026-08-21', 'entregado', 'nequi', 28000, 1, 2, 1, 4),
('2026-08-22', 'preparando', 'tarjeta', 36000, 1, 3, 1, 5),
('2026-08-25', 'pendiente', 'efectivo', 45000, 1, 4, 2, 6),
('2026-08-26', 'entregado', 'efectivo', 52000, 1, 5, 2, 7);

insert into domicilios (direccion_entrega, hora_salida, hora_entrega, costo_envio, barrio, repartidor_fk, pedido_fk) values 
('calle 35 #12-45, bucaramanga', '2026-08-20 18:30:00', '2026-08-20 19:00:00', 5000, 'centro', 1, 1),
('carrera 27 #45-10, floridablanca', '2026-08-21 19:15:00', '2026-08-21 19:45:00', 7000, 'cañaveral', 2, 2),
('calle 45 #23-11, bucaramanga', '2026-08-26 12:00:00', '2026-08-26 12:35:00', 4000, 'sotomayor', 1, 5);

insert into pagos (monto, fecha_pago, estado, pedido_fk) values 
(40000, '2026-08-20 19:00:00', 'completado', 1),
(35000, '2026-08-21 19:45:00', 'completado', 2),
(56000, '2026-08-26 12:35:00', 'completado', 5);