import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/components/app_bar.dart';
import 'package:kodiak/pages/products_page/porducts_list_page.dart';
import 'package:kodiak/pages/products_page/products_general_page/pie_chart_products.dart';

import '../../utils/constants.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
      body: Column(
        children: [
          Container(
            height: kToolbarHeight - 8.0,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color(darkBlue)),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(
                  icon: Icon(CupertinoIcons.chart_pie),
                  iconMargin: EdgeInsets.only(top: 2),
                  text: "Geral",
                ),
                Tab(
                  icon: Icon(CupertinoIcons.list_bullet),
                  iconMargin: EdgeInsets.only(top: 2),
                  text: "Listagem",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PieChartProducts(),
                ProductsListPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
