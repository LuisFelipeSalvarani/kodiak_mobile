import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/pages/products_page/products_general_page/pie_chart_products.dart';

class ProductGeneralPage extends StatefulWidget {
  const ProductGeneralPage({super.key});

  @override
  _ProductGeneralPageState createState() => _ProductGeneralPageState();
}

class _ProductGeneralPageState extends State<ProductGeneralPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [PieChartProducts()],
    );
  }
}
