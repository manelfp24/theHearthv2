<?php
include_once __DIR__ . '/Product.php';

class Food extends Product
{
    // Implementación del método abstracto
    public function getDetails() {
        return "Dish: " . $this->name . " | Base price: $" . $this->price;
    }
}
?>