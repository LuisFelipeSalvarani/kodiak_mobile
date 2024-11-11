import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/components/app_bar.dart';
import 'package:kodiak/http/get_all_products.dart';
import 'package:kodiak/models/all_products.dart';

import '../../utils/constants.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> _allProducts = [];
  List<Product> _filteredOptions = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    handleAllCustomers();
  }

  Future<void> handleAllCustomers() async {
    final AllProducts allProducts = await getAllProducts();
    setState(() {
      _allProducts = allProducts.allProducts;
      _filteredOptions = List.from(_allProducts);
    });
  }

  @override
  void dispose() {
    super.dispose();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 10.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _filteredOptions = _allProducts
                      .where((product) => product.descriptionProduct
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                hintText: 'Pesquisar...',
                prefixIcon: Icon(CupertinoIcons.search, color: Color(darkBlue)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(darkBlue), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(darkBlue)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                filled: true,
                fillColor: Color(white),
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Selecione um produto:',
              style: TextStyle(color: Color(darkBlue), fontSize: 18),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredOptions.length,
                itemBuilder: (context, index) {
                  final product = _filteredOptions[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 2.0),
                    decoration: const BoxDecoration(
                      color: Color(white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: Offset(0, 1))
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(
                        CupertinoIcons.cube_box_fill,
                        color: Color(darkBlue),
                      ),
                      title: Text(
                        product.descriptionProduct,
                        style: const TextStyle(
                          color: Color(darkBlue),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        CupertinoIcons.chevron_right,
                        color: Color(darkBlue),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 24.0),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
