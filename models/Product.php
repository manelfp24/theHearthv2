 <?php

abstract class Product
{
    protected $id;
    protected $category_id;
    protected $name;
    protected $description;
    protected $price;
    protected $product_type; // guardamos el nombre de la categoría (Meats, Wines, etc.)
    protected $image;
    protected $active;

    // Método abstracto (Polimorfismo)
    abstract public function getDetails();

    // GETTERS Y SETTERS COMUNES
    public function getProductId() { return $this->id; }
    public function setProductId($id) { $this->id = $id; }

    public function getCategoryId() { return $this->category_id; }
    public function setCategoryId($category_id) { $this->category_id = $category_id; }

    public function getName() { return $this->name; }
    public function setName($name) { $this->name = $name; }

    public function getDescription() { return $this->description; }
    public function setDescription($description) { $this->description = $description; }

    public function getBasePrice() { return $this->price; }
    public function setBasePrice($price) { $this->price = $price; }

    public function getProductType() { return $this->product_type; }
    public function setProductType($product_type) { $this->product_type = $product_type; }

    public function getImage() { return $this->image; }
    public function setImage($image) { $this->image = $image; }

    public function getActive() { return $this->active; }
    public function setActive($active) { $this->active = $active; }
}
?>