import 'package:flutter/material.dart';
import 'package:kodiak/components/app_bar.dart';
import 'package:kodiak/pages/products_page/porducts_list_page.dart';
import 'package:kodiak/pages/products_page/product_info_page.dart';

import '../../utils/constants.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(white),
        appBar: CustomAppBar(
            title: 'Produtos',
            onBackPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            }),
        body: const DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(tabs: [
                Tab(text: "Geral"),
                Tab(text: "Listagem"),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    ProductInfoPage(),
                    ProductsListPage(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
