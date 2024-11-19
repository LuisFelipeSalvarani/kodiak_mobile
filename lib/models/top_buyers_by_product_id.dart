class Customer {
  final int idCustomer;
  final String companyName;
  final String totalPurchasedProduct;
  final int totalPurchases;
  final String totalValue;

  Customer({
    required this.idCustomer,
    required this.companyName,
    required this.totalPurchasedProduct,
    required this.totalPurchases,
    required this.totalValue,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      idCustomer: json['idCustomer'],
      companyName: json['companyName'],
      totalPurchasedProduct: json['totalPurchasedProduct'],
      totalPurchases: json['totalPurchases'],
      totalValue: json['totalValue'],
    );
  }
}

class TopBuyersByProductId {
  final List<Customer> topCustomers;

  TopBuyersByProductId({required this.topCustomers});

  factory TopBuyersByProductId.fromJson(Map<String, dynamic> json) {
    return TopBuyersByProductId(
      topCustomers: (json['topCustomers'] as List)
          .map((item) => Customer.fromJson(item))
          .toList(),
    );
  }
}
