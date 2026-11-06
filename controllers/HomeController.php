<!-- Controlador para la página principal / Home -->
 <?php
class HomeController
{
    public function index()
    {
        // 1. Definimos qué vista específica queremos mostrar en el centro
        $view = "views/home/index.php";

        // 2. Cargamos la plantilla maestra (views/main.php), que pintará 
        // automáticamente tu header, esta vista y tu footer.
        include_once "views/main.php";
    }
}