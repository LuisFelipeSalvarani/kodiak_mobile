import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodiak/http/top_buyers_by_product_id.dart';

import '../../../models/top_buyers_by_product_id.dart';
import '../../../utils/constants.dart';

class TopBuyers extends StatefulWidget {
  final String idProduct;

  const TopBuyers({super.key, required this.idProduct});

  @override
  State<TopBuyers> createState() => _TopBuyersState();
}

class _TopBuyersState extends State<TopBuyers> {
  late String _idProduct;
  late Future<TopBuyersByProductId> _topBuyersById;

  @override
  void initState() {
    super.initState();
    _idProduct = widget.idProduct;
    _topBuyersById = getTopBuyersByProductId(idProduct: _idProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: _topBuyersById,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final buyers = snapshot.data!.topCustomers;
              return ListView.builder(
                  itemCount: buyers.length,
                  itemBuilder: (context, index) {
                    final buyer = buyers[index];
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
                          CupertinoIcons.building_2_fill,
                          color: Color(darkBlue),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              buyer.companyName,
                              style: const TextStyle(
                                color: Color(darkBlue),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Comprados/Compras:'),
                                    Text(
                                        '${NumberFormat.decimalPattern('pt_BR').format(double.parse(buyer.totalPurchasedProduct))}/${buyer.totalPurchases.toString()}')
                                  ],
                                ),
                                const SizedBox(width: 24.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Total:'),
                                    Text(NumberFormat.currency(
                                            locale: 'pt_BR', symbol: 'R\$')
                                        .format(double.parse(buyer.totalValue)))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16.0),
                      ),
                    );
                  });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
