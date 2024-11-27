import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodiak/http/get_customer_product_and_purchase_history.dart';
import 'package:kodiak/models/customer_product_and_purchase_history.dart';

import '../../utils/constants.dart';

class DetailsContainer extends StatefulWidget {
  final int idCustomer;
  final ScrollController scrollController;

  const DetailsContainer(
      {super.key, required this.idCustomer, required this.scrollController});

  @override
  State<DetailsContainer> createState() => _DetailsContainerState();
}

class _DetailsContainerState extends State<DetailsContainer> {
  late Future<CustomerHistory> _customerHistory;
  late int _currentCustomerId = widget.idCustomer;

  @override
  void initState() {
    super.initState();
    _fetchCustomerHistory(widget.idCustomer);
    print(widget.idCustomer);
  }

  void _fetchCustomerHistory(int idCustomer) {
    _customerHistory =
        getCustomerProductAndPurchaseHistory(idCustomer: idCustomer.toString());
  }

  @override
  void didUpdateWidget(DetailsContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.idCustomer != _currentCustomerId) {
      setState(() {
        _currentCustomerId = widget.idCustomer;
        _fetchCustomerHistory(_currentCustomerId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<CustomerHistory>(
                future: _customerHistory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.exclamationmark_circle,
                          size: 64,
                          color: Color(darkBlue),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Não foi possível carregar os dados',
                          style: TextStyle(
                            color: Color(darkBlue),
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  }

                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        _buildDetailsHeader(
                            snapshot.data!.companyName,
                            snapshot.data!.dayThatBuysTheMost,
                            snapshot.data!.weekThatBuysTheMost),
                        _buildMostPurchasedProducts(snapshot.data!.topProducts),
                        const SizedBox(height: 24.0),
                        _buildLatestPurchases(snapshot.data!.lastPurchases,
                            snapshot.data!.totalLastPurchases),
                      ],
                    );
                  }

                  return const Center(child: Text('Sem dados disponíveis.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsHeader(String companyName, int day, int week) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sobre:',
            style: TextStyle(
              color: Color(darkBlue),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 4.0),
        Text(
          companyName,
          style: const TextStyle(
            fontSize: 18,
            color: Color(darkBlue),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const Text('Dia preferido para compra:',
                    style: TextStyle(
                      color: Color(darkBlue),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(width: 4.0),
                Text(
                  day.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(darkBlue),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Semana preferida para compra:',
                    style: TextStyle(
                      color: Color(darkBlue),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(width: 4.0),
                Text(
                  '${week.toString()}ª',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(darkBlue),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
                indent: 8,
                endIndent: 8,
              ),
            )
          ],
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }

  Widget _buildMostPurchasedProducts(List<TopProducts> topProducts) {
    return _buildScrollableContainer(
      title: _buildScrollableContainerTitle(
        icon: CupertinoIcons.cube_fill,
        title: 'Produtos mais comprados',
      ),
      list: topProducts.isEmpty
          ? const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.exclamationmark_circle,
                      size: 64,
                      color: Color(darkBlue),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Não foi possível carregar os dados',
                      style: TextStyle(
                        color: Color(darkBlue),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: topProducts.map((product) {
                return Column(
                  children: [
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Produto:',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(darkBlue),
                            ),
                          ),
                          Text(
                            product.productDescription,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Qtd:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(darkBlue),
                                ),
                              ),
                              Text(
                                NumberFormat.decimalPattern('pt_BR').format(
                                    double.parse(product.productCount).toInt()),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(darkBlue),
                                ),
                              ),
                              Text(
                                'R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(double.parse(product.total))}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      indent: 16,
                      endIndent: 16,
                    ),
                  ],
                );
              }).toList(),
            ),
    );
  }

  Widget _buildLatestPurchases(
      List<LastPurchases> lastPurchases, String totalPurchasesValue) {
    return _buildScrollableContainer(
      title: _buildScrollableContainerTitle(
        icon: CupertinoIcons.bag_fill,
        title: 'Últimas compras',
      ),
      list: lastPurchases.isEmpty
          ? const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.exclamationmark_circle,
                      size: 64,
                      color: Color(darkBlue),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Não foi possível carregar os dados',
                      style: TextStyle(
                        color: Color(darkBlue),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(children: [
              ...lastPurchases.map((purchase) {
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Produto:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(darkBlue),
                        ),
                      ),
                      Text(
                        purchase.productDescription,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data:',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(darkBlue),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(DateTime.parse(purchase.issueDate)),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Valor:',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(darkBlue),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            NumberFormat.currency(
                                    locale: 'pt_BR', symbol: 'R\$')
                                .format(double.parse(purchase.total)),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              const Row(children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                  ),
                )
              ]),
              ListTile(
                title: const Text(
                  'Total comprado:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(darkBlue),
                  ),
                ),
                trailing: Text(
                    NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                        .format(double.parse(totalPurchasesValue)),
                    style: const TextStyle(fontSize: 14)),
              ),
            ]),
    );
  }

  Widget _buildScrollableContainer(
      {required Widget title, required Widget list}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 5))
          ],
        ),
        child: RawScrollbar(
          thumbVisibility: true,
          thickness: 8,
          radius: const Radius.circular(15),
          thumbColor: const Color(lightBlue),
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  list,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableContainerTitle(
      {required IconData icon, required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: const Color(darkBlue),
          size: 18,
        ),
        const SizedBox(width: 8.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(darkBlue),
          ),
        ),
      ],
    );
  }
}
