<?php
include_once __DIR__ . '/Product.php';

class Drink extends Product
{
    // Implementación del método abstracto con enfoque en bebidas/licores
    public function getDetails() {
        return "Drink or Beverage: " . $this->name . " | Base price: $" . $this->price;
    }
}
?>