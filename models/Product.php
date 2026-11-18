 <?php

 /**
 * Clase abstracta base para los productos del restaurante. 
 * Agrupa los atributos y métodos comunes y define la estructura 
 * que obligatoriamente implementarán las clases hijas (Food y Drink).
 */

abstract class Product{

    //usamos protected para que la clase tenga los datos seguros pero aún así
    //las clases hijas food y drinks puedan acceder a estos.
    protected $id;
    protected $category_id;
    protected $name;
    protected $description;
    protected $price;
    // Propiedad auxiliar (no existe como columna en la tabla de la BBDD, 
    // la rellenamos con un JOIN para saber la categoría, instanciar Food o Drink 
    // y pintar la vista sin hacer consultas extra). -->
    protected $product_type;
    protected $image;
    protected $active;

    // Declaramos un método abstracto en la clase madre y las hijas se verán obligadas a usarlo,
    //aunque sea de forma diferente (Polimorfismo)
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