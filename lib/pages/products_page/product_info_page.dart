import 'package:flutter/material.dart';
import 'package:kodiak/components/app_bar.dart';

class ProductInfoPage extends StatefulWidget {
  const ProductInfoPage({super.key});

  @override
  _ProductInfoPageState createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Produto',
          onBackPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }),
      body: Container(child: Text('Info')),
    );
  }
}
