# Base de Datos - The Hearth Restaurant (`thehearth_v2`)

Este directorio contiene el script SQL completo para la creación, estructuración y población de la base de datos relacional del sistema de pedidos web y TPV de **"The Hearth"**.

Encontrarás credenciales de usuarios de prueba al final de este documento.

## 📊 Organización y Propósito de la Base de Datos

La base de datos está diseñada bajo principios contables y de comercio electrónico profesional, separando el control de catálogo, la gestión de usuarios, las reglas de negocio promocionales y el histórico transaccional de los pedidos.

### 1. Catálogo y Configuración
* **`categories`**: Agrupa los productos del restaurante en categorías lógicas (Carnes, Mariscos, Guarniciones, Bebidas, Vinos, Licores y Postres).
* **`products`**: Contiene todos los platos y bebidas de la carta con sus precios base, descripciones e imágenes.
* **`ingredients`**: Catálogo de ingredientes disponibles, incluyendo su precio adicional (`extra_price`) en caso de solicitarse como extra.
* **`product_ingredient`**: Tabla intermedia que define qué ingredientes lleva cada plato por defecto (`included = 1`) y cuáles están disponibles como opcionales.

### 2. Sistema de Ofertas y Descuentos
* **`offers`**: Almacena las reglas de las promociones (*Tuesday Meat Special*, *Sweet Thursdays 2x1*, *Ultimate Steak & Wine Combo*, y el cupón general *THEHEARTH10*), definiendo sus días aplicables (`days_of_week`), tipos y si son acumulables (`stackable`).
* **`offer_product`**: Relaciona las ofertas específicas con los productos concretos del catálogo a los que aplican.

### 3. Gestión de Usuarios y Pedidos
* **`users`**: Registro de usuarios del sistema con soporte para roles diferenciados (`user` o `admin`).
* **`orders`**: Cabecera financiera de cada ticket de compra. Almacena los importes globales (`subtotal`, `discount`, `total`), el estado del pedido, el método de pago (`cash` or `card`) y el estado de la transacción.
* **`order_detail`**: Detalle línea por línea de los productos comprados en un pedido. Mantiene una persistencia histórica del precio unitario en el momento de la compra.
* **`order_detail_ingredient`**: Registro detallado de la personalización de los platos y bebidas de un pedido (por ejemplo, ingredientes incluidos, retirados o añadidos con coste extra, así como la gestión de hielo en bebidas).

---

## 🚀 Guía de Importación para phpMyAdmin

Para importar la base de datos y probar el funcionamiento de la aplicación, sigue estos sencillos pasos:

1. Ejecutar el entorno local de servidores (**XAMPP**) con los servicios de **Apache** y **MySQL** encendidos.
2. Abre el navegador web y accede a **phpMyAdmin**.
3. En el menú superior, haz clic en la pestaña **Importar**.
4. Haz clic en **Seleccionar archivo** y busca el archivo `thehearth_v2.sql` ubicado en esta carpeta del proyecto.
5. Deja el resto de opciones con sus valores predeterminados (juego de caracteres `utf8mb4`) y haz clic en el botón **Continuar** situado en la parte inferior.

> **Nota:** El script incluye la sentencia automática `CREATE DATABASE IF NOT EXISTS thehearth_v2`, por lo que creará la estructura de la base de datos y la poblará con 15 pedidos de prueba completos de manera totalmente automatizada.

---

## 🔑 Credenciales de Usuarios de Prueba

Para realizar pruebas en la aplicación tanto con privilegios de cliente como de administración, puedes utilizar cualquiera de las siguientes cuentas ya registradas en la base de datos:

* **👤 Usuario Normal (Cliente):**
  * **Correo:** `manelcustomer@gmail.com`
  * **Contraseña:** `1234`

* **🛡️ Usuario Administrador (Gestión):**
  * **Correo:** `maneladmin@gmail.com`
  * **Contraseña:** `1234`