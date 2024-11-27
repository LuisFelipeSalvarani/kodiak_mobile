import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodiak/components/app_bar.dart';
import 'package:kodiak/http/get_product_by_id.dart';
import 'package:kodiak/pages/products_page/product_page/line_chart_product.dart';
import 'package:kodiak/pages/products_page/product_page/top_buyers.dart';
import 'package:kodiak/utils/constants.dart';

import '../../../models/product_by_id.dart';

class ProductPage extends StatefulWidget {
  final String idProduct;

  const ProductPage({super.key, required this.idProduct});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late String idProduct;
  late Future<ProductById> _productData;

  @override
  void initState() {
    idProduct = widget.idProduct;
    _productData = getProductById(idProduct: idProduct);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Produto',
        onBackPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: FutureBuilder(
                future: _productData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final product = snapshot.data!.product;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Código:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(darkBlue),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              product.idProduct,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(darkBlue)),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Produto:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(darkBlue),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              product.descriptionProduct,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(darkBlue)),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Grupo:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(darkBlue),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              product.descriptionGroup,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(darkBlue)),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Valor unitário:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(darkBlue),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              NumberFormat.currency(
                                      locale: 'pt_BR', symbol: 'R\$')
                                  .format(double.parse(product.unitValue)),
                              style: const TextStyle(
                                  fontSize: 16, color: Color(darkBlue)),
                            )
                          ],
                        ),
                      ],
                    );
                  }

                  return Container();
                }),
          ),
          const Divider(
            indent: 32,
            endIndent: 32,
          ),
          LineChartProduct(idProduct: idProduct),
          const Divider(
            indent: 32,
            endIndent: 32,
          ),
          const Text(
            'Top Compradores',
            style: TextStyle(
                color: Color(darkBlue),
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
          TopBuyers(idProduct: idProduct),
        ],
      ),
    );
  }
}
