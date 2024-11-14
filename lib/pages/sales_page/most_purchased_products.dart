import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodiak/http/get_top_selling_products.dart';
import 'package:kodiak/models/top_selling_products.dart';
import 'package:kodiak/utils/constants.dart';

class MostPurchasedProducts extends StatefulWidget {
  const MostPurchasedProducts({super.key});

  @override
  State<MostPurchasedProducts> createState() => _MostPurchasedProductsState();
}

class _MostPurchasedProductsState extends State<MostPurchasedProducts> {
  late Future<TopSellingProducts> _topSellingProducts;

  @override
  void initState() {
    super.initState();
    _topSellingProducts = getTopSellingProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: Text(
              'Produtos mais vendidos',
              style: TextStyle(
                color: Color(darkBlue),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: FutureBuilder(
              future: _topSellingProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data!.topSellingProducts.isEmpty) {
                  return const Center(
                    child: Text('Nenhum produto encontrado.'),
                  );
                } else {
                  final products = snapshot.data!.topSellingProducts;
                  return RawScrollbar(
                    thumbVisibility: true,
                    thickness: 8,
                    radius: const Radius.circular(15),
                    thumbColor: const Color(lightBlue),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(darkBlue), Color(lightBlue)]),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${index + 1}º',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Nome:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(white),
                                          ),
                                        ),
                                        Text(
                                          product.descriptionProduct,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(white),
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Qtd:',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(white),
                                              ),
                                            ),
                                            Text(
                                              NumberFormat.decimalPattern(
                                                      'pt_BR')
                                                  .format(
                                                double.parse(
                                                        product.totalSelling)
                                                    .toInt(),
                                              ),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Total:',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(white),
                                              ),
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'pt_BR',
                                                      symbol: 'R\$')
                                                  .format(double.parse(
                                                      product.totalSalesValue)),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(white),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
