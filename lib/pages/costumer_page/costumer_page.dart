import 'package:flutter/material.dart';
import 'package:kodiak/components/app_bar.dart';
import 'package:kodiak/pages/costumer_page/costumer_list_page.dart';

class CostumerPage extends StatefulWidget {
  const CostumerPage({super.key});

  @override
  State<CostumerPage> createState() => _CostumerPageState();
}

class _CostumerPageState extends State<CostumerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Clientes',
        onBackPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      body: const Column(
        children: [
          Expanded(
            child: CustomersListPage(),
          ),
        ],
      ),
    );
  }
}
