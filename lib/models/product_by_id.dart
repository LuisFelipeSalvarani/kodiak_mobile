class Product {
  final String idProduct;
  final String descriptionProduct;
  final String descriptionGroup;
  final String unitValue;

  Product({
    required this.idProduct,
    required this.descriptionProduct,
    required this.descriptionGroup,
    required this.unitValue,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idProduct: json['idProduct'],
      descriptionProduct: json['descriptionProduct'],
      descriptionGroup: json['descriptionGroup'],
      unitValue: json['unitValue'],
    );
  }
}

class ProductById {
  final Product product;

  ProductById({required this.product});

  factory ProductById.fromJson(Map<String, dynamic> json) {
    return ProductById(product: Product.fromJson(json['product']));
  }
}
