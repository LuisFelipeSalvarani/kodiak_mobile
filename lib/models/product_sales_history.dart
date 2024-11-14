class ProductSales {
  final int year;
  final int month;
  final int countSales;
  final String totalUnitSales;

  ProductSales({
    required this.year,
    required this.month,
    required this.countSales,
    required this.totalUnitSales,
  });

  factory ProductSales.fromJson(Map<String, dynamic> json) {
    return ProductSales(
      year: json['year'] ?? 0,
      month: json['month'] ?? 0,
      countSales: json['countSales'] ?? 0,
      totalUnitSales: json['totalUnitSales'] ?? '',
    );
  }
}

class ProductSalesHistory {
  final List<ProductSales> productSalesHistory;

  ProductSalesHistory({required this.productSalesHistory});

  factory ProductSalesHistory.fromJson(Map<String, dynamic> json) {
    return ProductSalesHistory(
      productSalesHistory: (json['productSalesHistory'] as List)
          .map((item) => ProductSales.fromJson(item))
          .toList(),
    );
  }
}
