<?php
include_once("config/DataBase.php");
include_once("models/Product.php");
include_once("models/Food.php");
include_once("models/Drink.php");

class ProductDAO
{
    public static function getAll()
    {
        $con = DataBase::connect();
        // Hacemos el JOIN para traer también el nombre de la categoría y saber si es bebida o comida
        $stmt = $con->prepare("
            SELECT p.*, c.name as product_type 
            FROM products p 
            INNER JOIN categories c ON p.category_id = c.id 
            WHERE p.active = 1
        ");
        $stmt->execute();
        $result = $stmt->get_result();

        $productos = [];
        while ($row = $result->fetch_assoc()) {
            // Evaluamos si es bebida/vino/licor para instanciar la clase hija correspondiente
            $tipoCat = strtolower($row['product_type']);
            $className = in_array($tipoCat, ['beverages', 'wines', 'spirits']) ? 'Drink' : 'Food';
            
            $producto = new $className();
            $producto->setProductId($row['id']);
            $producto->setCategoryId($row['category_id']);
            $producto->setName($row['name']);
            $producto->setDescription($row['description']);
            $producto->setBasePrice((float)$row['price']);
            $producto->setProductType($row['product_type']);
            $producto->setImage($row['image']);
            $producto->setActive($row['active']);

            $productos[] = $producto;
        }

        $stmt->close();
        $con->close();

        return $productos;
    }

    public static function getById($id)
    {
        $con = DataBase::connect();
        $stmt = $con->prepare("
            SELECT p.*, c.name as product_type 
            FROM products p 
            INNER JOIN categories c ON p.category_id = c.id 
            WHERE p.id = ?
        ");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();

        $producto = null;
        if ($row = $result->fetch_assoc()) {
            $tipoCat = strtolower($row['product_type']);
            $className = in_array($tipoCat, ['beverages', 'wines', 'spirits']) ? 'Drink' : 'Food';

            $producto = new $className();
            $producto->setProductId($row['id']);
            $producto->setCategoryId($row['category_id']);
            $producto->setName($row['name']);
            $producto->setDescription($row['description']);
            $producto->setBasePrice((float)$row['price']);
            $producto->setProductType($row['product_type']);
            $producto->setImage($row['image']);
            $producto->setActive($row['active']);
        }

        $stmt->close();
        $con->close();

        return $producto ?: null;
    }

    public static function store($producto)
    {
        $con = DataBase::connect();
        $stmt = $con->prepare("INSERT INTO products (category_id, name, description, price, image, active) VALUES (?, ?, ?, ?, ?, 1)");

        $category_id = $producto->getCategoryId();
        $nombre = $producto->getName();
        $descripcion = $producto->getDescription();
        $precio = $producto->getBasePrice();
        $imagen = $producto->getImage();

        $stmt->bind_param("issds", $category_id, $nombre, $descripcion, $precio, $imagen);
        $stmt->execute();

        $stmt->close();
        $con->close();
    }

    public static function destroy($id)
    {
        $con = DataBase::connect();
        $stmt = $con->prepare("DELETE FROM products WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();

        $stmt->close();
        $con->close();
    }
}