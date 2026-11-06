<!-- Controlador para la gestión de carta y productos -->
 <?php

include_once("models/ProductDAO.php");
include_once("models/Food.php");
include_once("models/Drink.php");

class ProductController
{
    private const CATEGORIAS_VALIDAS = ['Meats', 'Seafood', 'Sides', 'Beverages', 'Wines', 'Spirits', 'Desserts'];

    public function index()
    {
        // Usamos el método getAll de nuestro DAO
        $allProducts = ProductDAO::getAll();
        
        // Vista del listado de la carta / menú
        $view = "views/productos/listado.php";
        include_once 'views/main.php';
    }

    public function create()
    {
        $view = "views/productos/create.php";
        include_once 'views/main.php';
    }

    public function store()
    {
        $nombre = isset($_POST['name']) ? trim($_POST['name']) : '';
        $descripcion = isset($_POST['description']) ? trim($_POST['description']) : '';
        $category_id = isset($_POST['category_id']) ? (int)$_POST['category_id'] : 1;
        $precio = isset($_POST['price']) ? $_POST['price'] : '';
        $imagen = isset($_POST['image']) ? trim($_POST['image']) : 'img/default.webp';

        if ($nombre === '' || !is_numeric($precio) || $precio < 0) {
            header('Location: index.php?controller=Product&action=create');
            exit;
        }

        // Como usamos clases hijas, podemos instanciar Food o Drink según corresponda
        $producto = new Food(); // O asignar dinámicamente
        $producto->setCategoryId($category_id);
        $producto->setName($nombre);
        $producto->setDescription($descripcion);
        $producto->setBasePrice((float) $precio);
        $producto->setImage($imagen);

        ProductDAO::store($producto);

        header('Location: index.php?controller=Product');
        exit;
    }

    public function destroy()
    {
        if (!isset($_GET['id']) || !ctype_digit((string) $_GET['id'])) {
            header('Location: index.php?controller=Product');
            exit;
        }

        ProductDAO::destroy((int) $_GET['id']);
        header('Location: index.php?controller=Product');
        exit;
    }

    public function show()
    {
        if (!isset($_GET['id']) || !ctype_digit((string) $_GET['id'])) {
            header('Location: index.php?controller=Product');
            exit;
        }

        $producto = ProductDAO::getById((int) $_GET['id']);
        if ($producto === null) {
            header('Location: index.php?controller=Product');
            exit;
        }

        $view = "views/productos/show.php";
        include_once 'views/main.php';
    }
}
?>