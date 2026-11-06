<!-- CÓDIGO DE EJEMPLO EN EL PROYECTO BASE -->
<?php
// Iniciamos sesión para todo el flujo de la aplicación web (mantenemos la sesión del usuario activa,
//nos ayuda a gestionar el carrito de compras guardandolo en la sesion, nos permite comprobar el acceso
//según rol...)
session_start();

// Incluimos los parámetros globales y la configuración de la base de datos si es necesario
include_once("config/parameters.php");
include_once("config/dataBase.php");

//función para gestionar errores
function showError($code, $message)
{
    http_response_code($code); // Establece el código de estado HTTP (ej: 404, 500)
    // Variables auxiliares que podrían ser usadas por la vista de error ->
    $errorCode = $code;
    $errorMessage = $message;
    $view = "views/error.php";
    include_once "views/main.php";
    exit;
}

// Si no se pasa un controlador por URL, redirigimos al controlador por defecto
if (!isset($_GET['controller'])) {
    header("Location: " . BASE_URL . "?controller=" . DEFAULT_CONTROLLER);
    exit;
}

// Capturamos el controlador que pide el usuario por la URL
$controllerParam = $_GET['controller'];
// Transformamos el texto (ej: "product" -> "ProductController") asegurando 
//la primera letra en mayúscula con ucfirst()
$nombre_controller = ucfirst($controllerParam) . "Controller";
$controllerFile = "controllers/" . $nombre_controller . ".php";

// Verificamos si el archivo físico del controlador realmente existe en la carpeta
if (!file_exists($controllerFile)) {
    //si no existem mostramos error
    showError(404, "No existe el controller " . $nombre_controller);
}

// Si finalmente existe, incluimos el archivo del controlador
include_once $controllerFile;

// Comprobamos si la clase dentro del archivo existe realmente
if (!class_exists($nombre_controller)) {
    //si no existe, mostramos errer
    showError(500, "El fichero existe pero no contiene la clase " . $nombre_controller);
}

// Instanciamos dinámicamente el controlador (Creamos el objeto, ej: new ProductController())
$controller = new $nombre_controller();

// Determinamos qué método (action) se debe ejecutar dentro del controlador.
// Si no se especifica ninguna por URL, cogemos la acción por defecto ('index') definida en parameters.php.
$action = DEFAULT_ACTION;
if (isset($_GET['action']) && $_GET['action'] !== '') {
    $action = $_GET['action'];
}

// Verificamos si el método existe y es ejecutable dentro de ese controlador
if (!is_callable([$controller, $action])) {
    showError(404, "No existe la action \"" . $action . "\" en " . $nombre_controller);
}

// Ejecutamos el método correspondiente del controlador
$controller->$action();
