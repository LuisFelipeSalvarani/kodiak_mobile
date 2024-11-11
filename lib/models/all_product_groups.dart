class ProductGroup {
  final int idGroup;
  final String descriptionGroup;

  ProductGroup({
    required this.idGroup,
    required this.descriptionGroup,
  });

  factory ProductGroup.fromJson(Map<String, dynamic> json) {
    return ProductGroup(
      idGroup: json['idGroup'],
      descriptionGroup: json['descriptionGroup'],
    );
  }
}

class AllProductGroups {
  final List<ProductGroup> allProductGroups;

  AllProductGroups({required this.allProductGroups});

  factory AllProductGroups.fromJson(Map<String, dynamic> json) {
    return AllProductGroups(
      allProductGroups: (json['allProductGroups'] as List)
          .map((item) => ProductGroup.fromJson(item))
          .toList(),
    );
  }
}
