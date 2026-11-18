<?php
include_once("config/DataBase.php");
include_once("models/Product.php");
include_once("models/Food.php");
include_once("models/Drink.php");

class ProductDAO
{
    //función para mostrar conseguir todos los productos de la tabla productos en la bbdd
    public static function getAll()
    {
        $con = DataBase::connect();
        // Hacemos una consulta SQL para buscar los productos que están disponibles (active = 1)
        // y le añadimos JOIN para saber su categoría y saber si es bebida o comida
        $stmt = $con->prepare("
            SELECT p.*, c.name as product_type 
            FROM products p 
            INNER JOIN categories c ON p.category_id = c.id 
            WHERE p.active = 1
        ");
        $stmt->execute(); //lanzamos la consulta a la bbdd
        $result = $stmt->get_result(); //nos devuelve el resultado

        //abrimos un array vacío donde guardaremos los resultados
        $products = [];
        //devuelve arrays asociativos con el bucle y fetch_assoc() y los mete en $products
        while ($row = $result->fetch_assoc()) {
            // Evaluamos el la categoría para instanciar la clase hija correspondiente
            $categoryType = strtolower($row['product_type']);
            $className = in_array($categoryType, ['beverages', 'wines', 'spirits']) ? 'Drink' : 'Food';
            
            //creamos un objeto del tipo Drink/Food según $className
            $product = new $className();
            //le metemos estas propiedades al objeto que acabamos de crear con los setters
            $product->setProductId($row['id']);
            $product->setCategoryId($row['category_id']);
            $product->setName($row['name']);
            $product->setDescription($row['description']);
            $product->setBasePrice((float)$row['price']);
            $product->setProductType($row['product_type']);
            $product->setImage($row['image']);
            $product->setActive($row['active']);

            //guardamos las propiedades de $product en el array $products
            $products[] = $product;
        }

        //cerramos la sentencia sql y cerramos la conexión a la bbdd
        $stmt->close();
        $con->close();

        //devolvemos el array completo tras el bucle
        return $products;
    }

    //función para conseguir un producto específico según su ID
    public static function getById($id){
        $con = DataBase::connect();
        //buscamos lo mismo que antes pero en el where buscamos el ID del producto que queremos
        $stmt = $con->prepare("
            SELECT p.*, c.name as product_type 
            FROM products p 
            INNER JOIN categories c ON p.category_id = c.id 
            WHERE p.id = ?
        ");

        $stmt->bind_param("i", $id); //bindeamos $id
        $stmt->execute(); //lanzamos la consulta a la bbdd
        $result = $stmt->get_result(); //nos devuelve el resultado

        //lo dejamos en null porque solo necesitamos uno
        $product = null;
        //como solo necesitamos 1 producto, usamos if
        if ($row = $result->fetch_assoc()) {
            $categoryType = strtolower($row['product_type']);
            $className = in_array($categoryType, ['beverages', 'wines', 'spirits']) ? 'Drink' : 'Food';

            $product = new $className();
            $product->setProductId($row['id']);
            $product->setCategoryId($row['category_id']);
            $product->setName($row['name']);
            $product->setDescription($row['description']);
            $product->setBasePrice((float)$row['price']);
            $product->setProductType($row['product_type']);
            $product->setImage($row['image']);
            $product->setActive($row['active']);
        }

        //cerramos la sentencia sql y cerramos la conexión a la bbdd
        $stmt->close();
        $con->close();

        //si hay $product lo devuelve, sino null
        return $product ?: null;
    }

    //función para guardar un nuevo producto
    public static function store($product)
    {
        $con = DataBase::connect();
        $stmt = $con->prepare("INSERT INTO products (category_id, name, description, price, image, active) VALUES (?, ?, ?, ?, ?, 1)");

        $category_id = $product->getCategoryId();
        $name = $product->getName();
        $description = $product->getDescription();
        $price = $product->getBasePrice();
        $image = $product->getImage();

        $stmt->bind_param("issds", $category_id, $name, $description, $price, $image);
        $stmt->execute();

        $stmt->close();
        $con->close();
    }

    //funcion para borrar un producto según si ID
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