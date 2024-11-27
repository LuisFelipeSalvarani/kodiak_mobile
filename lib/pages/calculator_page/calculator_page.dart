import 'package:flutter/material.dart';
import 'package:kodiak/components/app_bar.dart';
import 'package:kodiak/pages/calculator_page/porducts_list_page.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Calculadora',
        onBackPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      body: const Column(
        children: [
          Expanded(
            child: ProductsListPage(),
          ),
        ],
      ),
    );
  }
}
