# 🍕 Pizza Don Piccolo

> **Sistema de gestión de base de datos relacional para la administración de pedidos, productos, inventario, domicilios y pagos de una pizzería.**

![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-4479A1?style=for-the-badge\&logo=mysql\&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Database-336791?style=for-the-badge)
![Base de Datos](https://img.shields.io/badge/Base_de_Datos-Relacional-6C63FF?style=for-the-badge)
![Proyecto Académico](https://img.shields.io/badge/Proyecto-Acad%C3%A9mico-orange?style=for-the-badge)

---

## 📋 Tabla de contenidos

* [🎯 Objetivo del proyecto](#-objetivo-del-proyecto)
* [📖 Descripción](#-descripción)
* [📌 Alcance](#-alcance)
* [📐 Reglas de negocio](#-reglas-de-negocio)
* [🔗 Modelo entidad-relación](#-modelo-entidad-relación)
* [🗄️ Estructura de la base de datos](#️-estructura-de-la-base-de-datos)
* [⚙️ Automatización](#️-automatización)
* [🔄 Triggers](#-triggers)
* [🧮 Funciones almacenadas](#-funciones-almacenadas)
* [📊 Vistas](#-vistas)
* [🔎 Consultas SQL](#-consultas-sql)
* [🧪 Pruebas del sistema](#-pruebas-del-sistema)
* [🚀 Instalación y despliegue](#-instalación-y-despliegue)
* [📁 Estructura del proyecto](#-estructura-del-proyecto)
* [💡 Decisiones de diseño](#-decisiones-de-diseño)
* [🛠️ Tecnologías utilizadas](#️-tecnologías-utilizadas)
* [📈 Beneficios del sistema](#-beneficios-del-sistema)
* [👩‍💻 Autora](#-autora)

---

# 🎯 Objetivo del proyecto

## Objetivo general

Diseñar e implementar una **base de datos relacional en MySQL** que permita gestionar de manera organizada la información y los procesos principales de una pizzería con servicio a domicilio.

El sistema busca centralizar la información relacionada con clientes, empleados, productos, ingredientes, pedidos, domicilios y pagos, garantizando la integridad de los datos y facilitando la consulta y análisis de la información.

## Objetivos específicos

* 👤 Administrar la información de personas y clientes.
* 👨‍🍳 Gestionar empleados y repartidores.
* 🍕 Administrar el catálogo de pizzas.
* 🏷️ Organizar las pizzas mediante categorías.
* 📏 Gestionar los diferentes tamaños de pizza.
* 🧀 Relacionar las pizzas con los ingredientes necesarios para su preparación.
* 📦 Controlar el inventario de ingredientes.
* 🧾 Registrar pedidos y sus respectivos detalles.
* 🛵 Gestionar los domicilios y repartidores.
* 💳 Registrar los pagos asociados a los pedidos.
* ⚙️ Automatizar procesos mediante triggers.
* 🧮 Implementar funciones almacenadas para realizar cálculos.
* 📊 Crear vistas para facilitar el análisis de información.
* 🔎 Implementar consultas SQL para obtener información útil para la operación del negocio.

---

# 📖 Descripción

**Pizza Don Piccolo** es un proyecto académico desarrollado en **MySQL** para representar y gestionar los principales procesos de una pizzería que trabaja con pedidos a domicilio.

La base de datos permite administrar:

* 👤 Personas y clientes.
* 👨‍🍳 Empleados y repartidores.
* 🍕 Pizzas y categorías.
* 📏 Tamaños de pizza.
* 🧀 Ingredientes y recetas.
* 📦 Inventario.
* 🧾 Pedidos y detalles de pedidos.
* 🛵 Domicilios.
* 💳 Pagos y métodos de pago.
* 📊 Información para análisis y toma de decisiones.

Además, el proyecto utiliza **triggers, funciones almacenadas, vistas y consultas SQL** para automatizar procesos y facilitar el manejo de la información.

---

# 📌 Alcance

El proyecto está enfocado en la gestión de los principales procesos relacionados con la venta de pizzas y el servicio a domicilio.

### ✅ Procesos incluidos

* Registro y administración de personas.
* Gestión de clientes.
* Gestión de empleados.
* Gestión de repartidores.
* Administración de categorías de pizza.
* Administración de tamaños.
* Registro de pizzas.
* Gestión de ingredientes.
* Relación entre pizzas e ingredientes mediante recetas.
* Control de inventario.
* Registro de pedidos.
* Registro del detalle de cada pedido.
* Gestión de domicilios.
* Registro de pagos.
* Cálculo automático del precio de los productos.
* Actualización automática del inventario.
* Cálculo de ganancias.
* Consultas de información comercial.
* Vistas para análisis operativo.

### 🚫 Fuera del alcance

El proyecto está centrado en la **base de datos y la lógica implementada mediante SQL**. No incluye una aplicación web, aplicación móvil o interfaz gráfica para los usuarios finales.

---

# 📐 Reglas de negocio

La base de datos se encuentra diseñada teniendo en cuenta las siguientes reglas de negocio:

| Regla                | Descripción                                                                                                   |
| -------------------- | ------------------------------------------------------------------------------------------------------------- |
| 👤 **Personas**      | La tabla `persona` almacena la información general de las personas.                                           |
| 👥 **Clientes**      | Los clientes se relacionan con la entidad `persona`.                                                          |
| 👨‍🍳 **Empleados**  | Los empleados se relacionan con la entidad `persona`.                                                         |
| 🛵 **Repartidores**  | Los repartidores están asociados a empleados.                                                                 |
| 🍕 **Categorías**    | Cada pizza pertenece a una categoría.                                                                         |
| 📏 **Tamaños**       | Una pizza puede manejar diferentes tamaños con valores asociados.                                             |
| 💰 **Precios**       | El precio de una pizza se obtiene a partir del precio base y el valor correspondiente al tamaño seleccionado. |
| 🧀 **Recetas**       | Una pizza puede utilizar múltiples ingredientes y un ingrediente puede pertenecer a diferentes pizzas.        |
| 📦 **Inventario**    | El stock de ingredientes se actualiza automáticamente al registrar productos en un pedido.                    |
| 🧾 **Pedidos**       | Cada pedido pertenece a un cliente y contiene uno o varios detalles de productos.                             |
| 🛵 **Domicilios**    | Los domicilios relacionan un pedido con el repartidor encargado de realizar la entrega.                       |
| 💳 **Pagos**         | Los pagos se relacionan con los pedidos correspondientes.                                                     |
| 🚫 **Cancelaciones** | Los pedidos con estados `10` y `11` no se consideran dentro de los cálculos financieros documentados.         |

Estas reglas forman parte de la estructura lógica utilizada para representar el funcionamiento del negocio.

---

# 🔗 Modelo entidad-relación

El modelo entidad-relación representa las entidades principales del sistema y las relaciones existentes entre ellas.

## Principales entidades

```text
PERSONA
   │
   ├──────────────► CLIENTES
   │
   └──────────────► EMPLEADO
                         │
                         └──────────────► REPARTIDOR

CLIENTES
   │
   └──────────────► PEDIDOS
                       │
                       ├──────────────► DETALLE_PEDIDO ─────► PIZZA
                       │                                      │
                       │                                      ├──► CATEGORIA_PIZZA
                       │                                      │
                       │                                      └──► RECETA ───► INGREDIENTES
                       │
                       ├──────────────► DOMICILIOS ──────────► REPARTIDOR
                       │
                       ├──────────────► PAGO ────────────────► METODOS_PAGO
                       │
                       └──────────────► ESTADO_PEDIDO

REPARTIDOR
   │
   └──────────────► ESTADO_REPARTIDOR
```

El proyecto cuenta con un modelo entidad-relación para representar gráficamente esta estructura.

### 📷 Diagrama

Coloca la imagen del modelo en esta sección:

```markdown
![Modelo Entidad-Relación](images/mer_pizza_don_piccolo.png)
```

---

# 🗄️ Estructura de la base de datos

La base de datos se divide en diferentes grupos de entidades para organizar la información de acuerdo con las necesidades del negocio.

## 👥 Personas y personal

| Tabla               | Clave primaria         | Relación                    |
| ------------------- | ---------------------- | --------------------------- |
| `persona`           | `id_persona`           | Entidad base                |
| `clientes`          | `idclientes`           | `idclientes` → `persona`    |
| `empleado`          | `idempleado`           | `idempleado` → `persona`    |
| `repartidor`        | `idrepartidor`         | `idrepartidor` → `empleado` |
| `estado_repartidor` | `id_estado_repartidor` | Estado del repartidor       |

---

## 🍕 Productos e inventario

| Tabla             | Clave primaria               | Función                               |
| ----------------- | ---------------------------- | ------------------------------------- |
| `categoria_pizza` | `idcategoria_pizza`          | Clasificación de las pizzas           |
| `tamaño_pizza`    | `idtamaño_pizza`             | Tamaños disponibles                   |
| `pizza`           | `idpizza`                    | Catálogo de pizzas                    |
| `ingredientes`    | `idingredientes`             | Registro e inventario de ingredientes |
| `receta`          | `(id_pizza, id_ingrediente)` | Relación entre pizzas e ingredientes  |

---

## 🧾 Pedidos, domicilios y pagos

| Tabla            | Clave primaria     | Función                              |
| ---------------- | ------------------ | ------------------------------------ |
| `estado_pedido`  | `idestado_pedido`  | Estados disponibles para los pedidos |
| `pedidos`        | `idpedidos`        | Registro de pedidos                  |
| `detalle_pedido` | `iddetalle_pedido` | Productos incluidos en cada pedido   |
| `domicilios`     | `iddomicilios`     | Información de las entregas          |
| `pago`           | `idpago`           | Registro de pagos                    |
| `metodos_pago`   | `id_metodo_pago`   | Métodos de pago disponibles          |

La organización de las tablas sigue la estructura documentada en el proyecto.

---

# ⚙️ Automatización

Uno de los objetivos del proyecto es reducir procesos manuales mediante mecanismos propios de MySQL.

Para esto se utilizan principalmente:

* 🔄 **Triggers**
* 🧮 **Funciones almacenadas**
* 📊 **Vistas**
* 🔎 **Consultas SQL**

Los triggers permiten ejecutar automáticamente determinadas acciones cuando se realizan operaciones de inserción o actualización sobre las tablas.

---

# 🔄 Triggers

## 💰 1. Cálculo automático del precio unitario

**Trigger:** `calcular_precio_unitario_detalle`

**Evento:** `BEFORE INSERT`

**Tabla:** `detalle_pedido`

Antes de insertar un producto en el detalle de un pedido, el sistema consulta:

* El precio base de la pizza.
* El valor asociado al tamaño.

Posteriormente calcula automáticamente el precio unitario.

```text
Precio unitario =
Precio base de la pizza + Valor del tamaño
```

Esto evita que el precio tenga que ser introducido manualmente y ayuda a mantener consistencia en los datos.

---

## 📦 2. Descuento automático del inventario

**Trigger:** `descontar_stock_ingredientes`

**Evento:** `AFTER INSERT`

**Tabla:** `detalle_pedido`

Cuando una pizza es agregada a un pedido, el sistema consulta los ingredientes definidos en su receta y descuenta automáticamente las cantidades utilizadas del inventario.

La cantidad descontada se obtiene mediante:

```text
Cantidad utilizada =
Cantidad de pizzas × Cantidad requerida por la receta
```

El trigger también actualiza la disponibilidad del ingrediente cuando el stock llega a niveles críticos.

---

## 🔄 Resumen de triggers

| Trigger                            | Evento          | Función                                              |
| ---------------------------------- | --------------- | ---------------------------------------------------- |
| `calcular_precio_unitario_detalle` | `BEFORE INSERT` | Calcula automáticamente el precio según el tamaño    |
| `descontar_stock_ingredientes`     | `AFTER INSERT`  | Descuenta los ingredientes utilizados del inventario |

---

# 🧮 Funciones almacenadas

Las funciones almacenadas permiten ejecutar cálculos directamente desde MySQL.

## 💵 `ganancia_diaria(p_fecha DATE)`

Calcula la ganancia neta de una fecha determinada.

La operación se realiza mediante:

```text
Ganancia neta =
Ventas totales - Costo de ingredientes utilizados
```

Los pedidos cancelados no se incluyen en el cálculo.

### Ejemplo de uso

```sql
SELECT ganancia_diaria('2026-08-05') AS ganancia;
```

La función utiliza la información de los pedidos, detalles, recetas e ingredientes para obtener el resultado.

---

# 📊 Vistas

Las vistas permiten almacenar consultas que pueden utilizarse posteriormente para facilitar el análisis de la información.

---

## 🛵 `desempeño_repartidores`

Permite consultar información relacionada con el desempeño de los repartidores.

Incluye:

* Nombre.
* Apellido.
* Entregas realizadas.
* Tiempo promedio de entrega.
* Zona.

---

## ⚠️ `stock_ingredientes_bajos`

Permite identificar los ingredientes cuyo stock actual se encuentra por debajo o igual al mínimo establecido.

Incluye:

* Ingrediente.
* Stock actual.
* Stock mínimo.
* Cantidad faltante.
* Unidad de medida.

---

## 👤 `resumen_pedidos_cliente`

Permite consultar información resumida sobre el comportamiento de los clientes.

Incluye:

* Nombre.
* Apellido.
* Cantidad de pedidos.
* Total gastado.

Estas vistas están documentadas en el proyecto como mecanismos para facilitar consultas frecuentes y análisis de información.

---

# 🔎 Consultas SQL

El proyecto incluye consultas SQL para analizar diferentes aspectos de la información almacenada.

## 📅 1. Pedidos en un rango de fechas

```sql
SELECT
    p.nombre,
    p.apellido,
    pe.fecha_pedido,
    pe.total
FROM persona p
INNER JOIN clientes c
    ON p.id_persona = c.idclientes
INNER JOIN pedidos pe
    ON c.idclientes = pe.id_cliente
WHERE pe.fecha_pedido
BETWEEN '2026-08-01' AND '2026-08-05';
```

---

## 🍕 2. Pizzas más vendidas

```sql
SELECT
    pz.nombre_pizza,
    COUNT(dp.id_pizza) AS total_pedidos
FROM pizza pz
INNER JOIN detalle_pedido dp
    ON pz.idpizza = dp.id_pizza
GROUP BY pz.nombre_pizza
ORDER BY total_pedidos DESC;
```

Esta consulta permite identificar las pizzas con mayor número de registros en los detalles de los pedidos.

---

## 🛵 3. Pedidos por repartidor

```sql
SELECT
    p.nombre,
    p.apellido,
    d.id_pedido,
    d.hora_salida
FROM persona p
INNER JOIN repartidor r
    ON p.id_persona = r.idrepartidor
INNER JOIN domicilios d
    ON r.idrepartidor = d.id_repartidor;
```

---

## ⏱️ 4. Promedio de entrega por zona

```sql
SELECT
    r.zona,
    AVG(
        TIMESTAMPDIFF(
            MINUTE,
            pe.fecha_pedido,
            d.hora_entrega
        )
    ) AS promedio_minutos
FROM repartidor r
INNER JOIN domicilios d
    ON r.idrepartidor = d.id_repartidor
INNER JOIN pedidos pe
    ON d.id_pedido = pe.idpedidos
GROUP BY r.zona;
```

---

## 💳 5. Clientes con consumo superior a $40.000

```sql
SELECT
    p.nombre,
    p.apellido,
    SUM(pe.total) AS total_gastado
FROM persona p
INNER JOIN clientes c
    ON p.id_persona = c.idclientes
INNER JOIN pedidos pe
    ON c.idclientes = pe.id_cliente
GROUP BY
    p.nombre,
    p.apellido
HAVING SUM(pe.total) > 40000;
```

---

## 🔍 6. Buscar pizzas por nombre

```sql
SELECT
    idpizza,
    nombre_pizza,
    precio_base,
    descripcion
FROM pizza
WHERE nombre_pizza LIKE '%queso%';
```

Permite realizar búsquedas utilizando coincidencias parciales en el nombre de la pizza.

---

## ⭐ 7. Clientes frecuentes

Permite identificar clientes que realizaron más de cinco pedidos durante agosto de 2026.

```sql
SELECT
    p.nombre,
    p.apellido,
    p.telefono
FROM persona p
WHERE p.id_persona IN (
    SELECT pe.id_cliente
    FROM pedidos pe
    WHERE MONTH(pe.fecha_pedido) = 8
      AND YEAR(pe.fecha_pedido) = 2026
    GROUP BY pe.id_cliente
    HAVING COUNT(pe.idpedidos) > 5
);
```

Las consultas anteriores corresponden a las consultas principales documentadas en el proyecto.

---

# 🧪 Pruebas del sistema

Para verificar el funcionamiento de los procesos automatizados se realizan pruebas sobre el inventario y los pedidos.

## 📦 Prueba de actualización del inventario

### 1. Consultar el stock inicial

```sql
SELECT
    idingredientes,
    nombre,
    stock_actual
FROM ingredientes
WHERE idingredientes IN (1, 2, 14);
```

---

### 2. Crear un pedido de prueba

```sql
INSERT INTO pedidos (
    id_cliente,
    id_estado_pedido,
    subtotal,
    total
)
VALUES (
    1,
    1,
    40000.00,
    45000.00
);
```

---

### 3. Agregar una pizza al pedido

```sql
INSERT INTO detalle_pedido (
    id_pedido,
    id_pizza,
    id_tamaño,
    cantidad,
    precio_unitario
)
VALUES (
    LAST_INSERT_ID(),
    1,
    1,
    2.00,
    0.00
);
```

Al realizar esta operación se ejecutan los triggers asociados al detalle del pedido.

---

### 4. Comprobar el nuevo stock

```sql
SELECT
    idingredientes,
    nombre,
    stock_actual
FROM ingredientes
WHERE idingredientes IN (1, 2, 14);
```

### Resultado esperado

El `stock_actual` de los ingredientes relacionados con la pizza debe reflejar el descuento correspondiente a las unidades registradas.

Este flujo de prueba está documentado en el proyecto como mecanismo para comprobar el funcionamiento del descuento automático del inventario.

---

# 🚀 Instalación y despliegue

## 📋 Requisitos

Antes de ejecutar el proyecto se recomienda contar con:

* **MySQL Server 8.0 o superior**
* **MySQL Workbench**, DBeaver o un cliente MySQL.
* Permisos suficientes para crear y modificar bases de datos.
* Git, si se desea clonar el repositorio.

---

## 📥 Clonar el repositorio

```bash
git clone https://github.com/mariajoseangulo45-bit/pizza_don_piccolo.git
cd pizza_don_piccolo
```

> Si el repositorio cambia de usuario o dirección, reemplaza la URL por la correspondiente.

---

## 💻 Cargar la base de datos

Si el archivo SQL principal se encuentra en la carpeta actual:

```bash
mysql -u root -p pizza_don_piccolo < pizza_don_piccolo.sql
```

También es posible abrir el archivo desde **MySQL Workbench** y ejecutar el script directamente.

---

## 🔎 Verificar la instalación

Una vez cargada la base de datos:

```sql
USE pizza_don_piccolo;

SHOW TABLES;
```

Para revisar la estructura de una tabla:

```sql
DESCRIBE pizza;
```

---

# 📁 Estructura del proyecto

```text
pizza_don_piccolo/
│
├── 📄 pizza_don_piccolo.sql
├── 📁 images/
│   └── 🖼️ mer_pizza_don_piccolo.png
│
└── 📄 README.md
```

### Descripción de archivos

| Archivo                     | Descripción                          |
| --------------------------- | ------------------------------------ |
| `pizza_don_piccolo.sql`     | Script principal de la base de datos |
| `images/`                   | Recursos gráficos del proyecto       |
| `mer_pizza_don_piccolo.png` | Modelo entidad-relación              |
| `README.md`                 | Documentación del proyecto           |

---

# 💡 Decisiones de diseño

## 👤 Centralización mediante `persona`

La tabla `persona` permite almacenar la información general de las personas y relacionarla posteriormente con clientes y empleados.

Esto evita duplicar información común.

---

## 🧀 Relación mediante `receta`

La tabla `receta` permite establecer la relación entre pizzas e ingredientes.

De esta manera:

* Una pizza puede tener múltiples ingredientes.
* Un ingrediente puede utilizarse en diferentes pizzas.

---

## 📦 Automatización del inventario

El descuento del inventario se realiza mediante un trigger asociado al registro de productos en el detalle de un pedido.

Esto permite mantener actualizado el stock de manera automática.

---

## 💰 Automatización del precio

El precio unitario se calcula automáticamente a partir del precio base de la pizza y el valor asociado al tamaño seleccionado.

Esto disminuye la posibilidad de inconsistencias causadas por el ingreso manual del precio.

---

## 📊 Uso de vistas

Las vistas permiten reutilizar consultas frecuentes y facilitan la obtención de información para el análisis del negocio.

---

# 📈 Beneficios del sistema

La implementación de esta base de datos permite:

* ✅ Centralizar la información del negocio.
* ✅ Organizar los datos mediante relaciones.
* ✅ Reducir la duplicidad de información.
* ✅ Controlar el inventario de ingredientes.
* ✅ Automatizar el cálculo de precios.
* ✅ Consultar información de clientes y pedidos.
* ✅ Analizar el desempeño de los repartidores.
* ✅ Identificar ingredientes con stock bajo.
* ✅ Obtener información sobre las pizzas más solicitadas.
* ✅ Facilitar la generación de reportes mediante vistas y consultas.
* ✅ Aplicar conceptos de diseño y administración de bases de datos relacionales.

---

# 🛠️ Tecnologías utilizadas

| Tecnología                     | Uso                                        |
| ------------------------------ | ------------------------------------------ |
| 🗄️ **MySQL 8.0+**             | Sistema gestor de base de datos            |
| 💻 **SQL**                     | Creación, modificación y consulta de datos |
| ⚙️ **Triggers**                | Automatización de procesos                 |
| 🧮 **Funciones almacenadas**   | Realización de cálculos                    |
| 📊 **Vistas SQL**              | Consultas y análisis de información        |
| 🖥️ **MySQL Workbench**        | Diseño, administración y pruebas           |
| 📐 **Modelo entidad-relación** | Diseño conceptual y estructural            |

---

# 👩‍💻 Autora

### Ana Suárez

🍕 **Pizza Don Piccolo**
📚 Proyecto académico de bases de datos
🗄️ MySQL · SQL · Triggers · Funciones · Vistas

---

## 📚 Información académica

Este proyecto fue desarrollado con fines académicos para aplicar conocimientos relacionados con:

* Modelado de bases de datos.
* Modelo entidad-relación.
* Bases de datos relacionales.
* Claves primarias y foráneas.
* Relaciones entre entidades.
* Consultas SQL.
* Funciones almacenadas.
* Triggers.
* Vistas.
* Integridad y automatización de datos.

---

> 🍕 **Pizza Don Piccolo**
>
> *Diseñado y desarrollado como proyecto académico de bases de datos.*
