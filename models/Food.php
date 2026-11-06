<?php
include_once __DIR__ . '/Product.php';

class Food extends Product
{
    // Implementación del método abstracto
    public function getDetails() {
        return "Plato / Corte de comida: " . $this->name . " | Precio base: $" . $this->price;
    }
}
?>