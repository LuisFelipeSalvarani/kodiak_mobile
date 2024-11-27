import 'package:flutter/material.dart';
import 'package:kodiak/pages/costumer_page/datails_container.dart';

import '../../components/app_bar.dart';

class CustomerDetailsPage extends StatefulWidget {
  final int customerId;

  const CustomerDetailsPage({super.key, required this.customerId});

  @override
  State<StatefulWidget> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detalhes',
        onBackPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: DetailsContainer(
              idCustomer: widget.customerId,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
