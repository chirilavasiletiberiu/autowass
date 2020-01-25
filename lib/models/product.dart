class Product {
  String name = "";
  int quantity = 0;
  int price = 100;

  static Product newProduct(String name,
      int quantity) {
    Product product = new Product();
    product.name = name;
    product.quantity = quantity;
    return product;
  }
}