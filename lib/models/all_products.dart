class Product {
  final String idProduct;
  final String descriptionProduct;
  final String unitValue;

  Product({
    required this.idProduct,
    required this.descriptionProduct,
    required this.unitValue,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idProduct: json['idProduct'],
      descriptionProduct: json['descriptionProduct'],
      unitValue: json['unitValue'],
    );
  }
}

class AllProducts {
  final List<Product> allProducts;

  AllProducts({required this.allProducts});

  factory AllProducts.fromJson(Map<String, dynamic> json) {
    return AllProducts(
      allProducts: (json['allProducts'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }
}
