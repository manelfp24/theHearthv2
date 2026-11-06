<!-- Vista de la carta de productos -->
 <?php
// 1. Arrays de configuración visual y descripciones
$display_titles = [
    'Meats' => 'MEATS',
    'Seafood' => 'SEAFOOD',
    'Sides' => 'SIDES',
    'Beverages' => 'BEVERAGES',
    'Wines' => 'WINES',
    'Spirits' => 'SPIRITS',
    'Desserts' => 'DESSERTS'
];

$category_images = [
    'Meats' => 'public/img/meats-section-logo.webp',
    'Seafood' => 'public/img/seafood-section-logo.webp',
    'Sides' => 'public/img/sides-section-logo.webp',
    'Beverages' => 'public/img/beverages-section-logo.webp',
    'Wines' => 'public/img/wines-section-logo.webp',
    'Spirits' => 'public/img/spirits-section-logo.webp',
    'Desserts' => 'public/img/desserts-section-logo.webp'
];

$section_descriptions = [
    'Meats' => 'Our commitment to the mastery of meat and flame, expertly sourced and prepared.',
    'Seafood' => 'Fresh from the ocean, featuring sustainable catches and pristine shellfish.',
    'Sides' => 'The perfect accompaniments, crafted to elevate your main course.',
    'Beverages' => 'Refreshing non-alcoholic options, from artisanal sodas to fresh juices.',
    'Wines' => 'A curated cellar selection featuring bold reds and crisp whites.',
    'Spirits' => 'Small-batch bourbons, aged gins, and premium whiskies.',
    'Desserts' => 'Decadent finales to complete your dining experience.'
];

// 2. Organización de los datos recibidos del controlador
$menu_items = [];
if (isset($allProducts)) {
    foreach ($allProducts as $product) {
        // Soporta tanto si $product es un objeto con métodos como si es un array asociativo
        $type = is_object($product) ? $product->getProductType() : ($product['category_name'] ?? 'Meats');
        $menu_items[$type][] = $product;
    }
}
?>

<div class="container mt-4 mb-4">
    <span class="breadcrumbs-text text-uppercase">
        <a href="<?= BASE_URL ?>index.php?controller=Home" class="text-decoration-none text-muted">HOME</a> <span class="mx-2">›</span> OUR FULL MENU
    </span>
</div>

<!-- Barra de navegación visual por categorías -->
<section class="menu-cat-nav-bar py-5 mb-5" style="background-color: #EFEBE6;">
    <div class="container">
        <div class="d-flex justify-content-between align-items-start gap-4 overflow-auto pb-3"
            style="scrollbar-width: none;">
            <?php foreach ($display_titles as $db_type => $title):
                if (isset($category_images[$db_type])):
                    $img_path = BASE_URL . $category_images[$db_type];
                    $custom_style = ($db_type === 'Seafood') ? 'padding: 15px;' : '';
                    ?>
                    <a href="#section-<?= $db_type ?>" class="cat-nav-item text-decoration-none text-center">
                        <div class="cat-thumb mb-3">
                            <img src="<?= $img_path ?>" alt="<?= $title ?>" style="<?= $custom_style ?>">
                        </div>
                        <span class="cat-title"><?= $title ?></span>
                    </a>
                <?php endif;
            endforeach; ?>
        </div>
    </div>
</section>

<?php
// Filtramos para mostrar solo las secciones que realmente contienen productos
$active_sections = [];
foreach ($display_titles as $type => $title) {
    if (!empty($menu_items[$type])) {
        $active_sections[] = $type;
    }
}

// Bucle principal para generar cada bloque de categoría del menú
foreach ($active_sections as $index => $type):
    $title = $display_titles[$type];
    $items = $menu_items[$type];
    ?>

    <div class="container mb-5" id="section-<?= $type ?>">

        <div class="row align-items-end mb-5">
            <div class="col-md-6">
                <h1 class="section-main-title">
                    <?= ($type === 'Meats') ? 'Our Meats' : $title ?>
                </h1>
            </div>
            <div class="col-md-6 text-md-end text-start">
                <p class="section-description text-muted">
                    <?= $section_descriptions[$type] ?? '' ?>
                </p>
            </div>
        </div>

        <div class="row">
            <?php foreach ($items as $item): 
                // Compatibilidad de métodos u objetos frente a arrays de base de datos
                $isObj = is_object($item);
                $prodId = $isObj ? $item->getProductId() : $item['id'];
                $prodName = $isObj ? $item->getName() : $item['name'];
                $prodDesc = $isObj ? $item->getDescription() : $item['description'];
                $prodPrice = $isObj ? $item->getBasePrice() : $item['price'];
                $prodImg = $isObj ? $item->getImage() : $item['image']; // ej: 'img/tomahawk.webp'
            ?>
                <div class="col-lg-4 col-md-6 mb-5">
                    <div class="menu-product-card h-100 position-relative">

                        <div class="menu-img-wrapper mb-3 product-image-wrapper">
                            <!-- Ruta corregida añadiendo 'public/' para que cargue desde public/img/ -->
                            <img src="<?= BASE_URL . 'public/' . $prodImg ?>" alt="<?= htmlspecialchars($prodName) ?>">

                            <button type="button" class="info-icon-btn" data-bs-toggle="tooltip" data-bs-placement="left"
                                data-bs-html="true"
                                title="<strong>Description:</strong><br><?= htmlspecialchars($prodDesc) ?>">
                                i
                            </button>
                        </div>

                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h3 class="product-name mb-0 lh-1"><?= htmlspecialchars($prodName) ?></h3>
                            <span class="fw-bold fs-5 text-nowrap ms-2 lh-1 product-price"
                                data-usd="<?= $prodPrice ?>">
                                $<?= number_format($prodPrice, 2) ?>
                            </span>
                        </div>

                        <div class="d-flex align-items-center justify-content-between mt-3">

                            <div class="quantity-pill">
                                <button class="qty-btn" onclick="updateQty(<?= $prodId ?>, -1)">-</button>
                                <span class="qty-display" id="qty-<?= $prodId ?>">0</span>
                                <button class="qty-btn" onclick="updateQty(<?= $prodId ?>, 1)">+</button>
                            </div>

                            <button class="btn btn-sm btn-hearth-add"
                                onclick="if(typeof checkAuthAndRedirect === 'function' ? checkAuthAndRedirect() : true) { addToCart(<?= $prodId ?>); }">
                                ADD
                            </button>
                        </div>

                    </div>
                </div>
            <?php endforeach; ?>
        </div>

    </div>

    <?php if ($index < count($active_sections) - 1): ?>
        <div class="hearth-section-divider"></div>
    <?php endif; ?>

<?php endforeach; ?>

<div style="height: 50px;"></div>