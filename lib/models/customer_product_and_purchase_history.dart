class TopProducts {
  final String productId;
  final String productDescription;
  final String productCount;
  final String total;

  TopProducts({
    required this.productId,
    required this.productDescription,
    required this.productCount,
    required this.total,
  });

  factory TopProducts.fromJson(Map<String, dynamic> json) {
    return TopProducts(
      productId: json['productId'] ?? '',
      productDescription: json['productDescription'] ?? '',
      productCount: json['productCount']?.toString() ?? '0',
      total: json['total']?.toString() ?? '0',
    );
  }
}

class LastPurchases {
  final String issueDate;
  final String productId;
  final String productDescription;
  final String quantity;
  final String total;

  LastPurchases({
    required this.issueDate,
    required this.productId,
    required this.productDescription,
    required this.quantity,
    required this.total,
  });

  factory LastPurchases.fromJson(Map<String, dynamic> json) {
    return LastPurchases(
      issueDate: json['issueDate'] ?? '',
      productId: json['productId'] ?? '',
      productDescription: json['productDescription'] ?? '',
      quantity: json['quantity']?.toString() ?? '0',
      total: json['total']?.toString() ?? '0',
    );
  }
}

class CustomerHistory {
  final int idCustomer;
  final String companyName;
  final int dayThatBuysTheMost;
  final int weekThatBuysTheMost;
  final List<TopProducts> topProducts;
  final List<LastPurchases> lastPurchases;
  final String totalLastPurchases;

  CustomerHistory({
    required this.idCustomer,
    required this.companyName,
    required this.dayThatBuysTheMost,
    required this.weekThatBuysTheMost,
    required this.topProducts,
    required this.lastPurchases,
    required this.totalLastPurchases,
  });

  factory CustomerHistory.fromJson(Map<String, dynamic> json) {
    final customerHistory = json['customerHistory'];
    return CustomerHistory(
      idCustomer: customerHistory['idCustomer'],
      companyName: customerHistory['companyName'],
      dayThatBuysTheMost: customerHistory['dayThatBuysTheMost'],
      weekThatBuysTheMost: customerHistory['weekThatBuysTheMost'],
      topProducts: (customerHistory['topProducts'] as List)
          .map((item) => TopProducts.fromJson(item))
          .toList(),
      lastPurchases: (customerHistory['lastPurchases'] as List)
          .map((item) => LastPurchases.fromJson(item))
          .toList(),
      totalLastPurchases: customerHistory['totalLastPurchases'],
    );
  }
}
