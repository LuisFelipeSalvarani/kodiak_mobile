import 'package:flutter/material.dart';
import 'package:kodiak/components/app_bar.dart';
import 'package:kodiak/pages/products_page/product_page/line_chart_product.dart';

class ProductPage extends StatefulWidget {
  final String idProduct;

  const ProductPage({super.key, required this.idProduct});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late String idProduct;

  @override
  void initState() {
    idProduct = widget.idProduct;
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
          LineChartProduct(idProduct: idProduct),
        ],
      ),
    );
  }
}
