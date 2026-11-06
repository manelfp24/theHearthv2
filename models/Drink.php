<?php
include_once __DIR__ . '/Product.php';

class Drink extends Product
{
    // Implementación del método abstracto con enfoque en bebidas/licores
    public function getDetails() {
        return "Bebida / Licor de la cava: " . $this->name . " | Precio base: $" . $this->price;
    }
}
?>