<?php
/**
 * Layout Principal (Plantilla maestra del proyecto The Hearth)
 * Recoge la variable $view enviada por el controlador y la envuelve con el header y el footer.
 */

// 1. Cargamos el header unificado (que ya incluye el <head>, los enlaces CSS, Google Fonts y el Navbar)
include_once "views/layout/header.php";
?>

<!-- 2. CONTENIDO DINÁMICO: Aquí se inyecta la vista que decida el controlador (ej: la carta, el login, etc.) -->
<main class="main-content">
    <?php 
    if (isset($view) && file_exists($view)) {
        include_once $view;
    } else {
        echo "<div class='container my-5 text-center'><h2>Error: No se encuentra la vista solicitada.</h2></div>";
    }
    ?>
</main>

<?php
// 3. Cargamos el footer unificado con el botón de "Scroll to top" y los scripts globales
include_once "views/layout/footer.php";
?>