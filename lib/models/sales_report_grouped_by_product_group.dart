class ProductGroup {
  final int idGroup;
  final String descriptionGroup;
  final int totalSalesGroup;

  ProductGroup({
    required this.idGroup,
    required this.descriptionGroup,
    required this.totalSalesGroup,
  });

  factory ProductGroup.fromJson(Map<String, dynamic> json) {
    return ProductGroup(
      idGroup: json['idGroup'] ?? 0,
      descriptionGroup: json['descriptionGroup'] ?? '',
      totalSalesGroup: json['totalSalesGroup'] ?? 0.0,
    );
  }
}

class SalesReportGroupedProductGroup {
  final int totalSales;
  final List<ProductGroup> salesGroupedByProductGroup;

  SalesReportGroupedProductGroup({
    required this.totalSales,
    required this.salesGroupedByProductGroup,
  });

  factory SalesReportGroupedProductGroup.fromJson(Map<String, dynamic> json) {
    return SalesReportGroupedProductGroup(
      totalSales: json['totalSales'] ?? 0.0,
      salesGroupedByProductGroup: (json['salesGroupedByProductGroup'] as List)
          .map((item) => ProductGroup.fromJson(item))
          .toList(),
    );
  }
}
