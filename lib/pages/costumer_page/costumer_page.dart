import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/components/app_bar.dart';
import 'package:kodiak/http/get_all_customers.dart';
import 'package:kodiak/models/all_customers.dart';
import 'package:kodiak/pages/costumer_page/datails_container.dart';
import 'package:kodiak/pages/costumer_page/options_select.dart';
import 'package:kodiak/utils/constants.dart';

class CostumerPage extends StatefulWidget {
  const CostumerPage({super.key});

  @override
  State<CostumerPage> createState() => _CostumerPageState();
}

class _CostumerPageState extends State<CostumerPage> {
  String _optionSelected = 'Selecionar uma opção';
  bool _showDetails = false;
  final ScrollController _scrollController = ScrollController();
  late Future<List<Customer>> _allCustomersFuture;
  List<Customer> _allCustomers = [];
  List<Customer> _filteredOptions = [];
  String _searchQuery = "";
  int _idCustomer = 0;

  @override
  void initState() {
    super.initState();
    _allCustomersFuture = handleAllCustomers();
  }

  Future<List<Customer>> handleAllCustomers() async {
    final AllCustomers allCustomers = await getAllCustomers();
    _allCustomers = allCustomers.allCustomers;
    _filteredOptions = List.from(_allCustomers);
    return _allCustomers;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        body: Stack(
          children: [
            _buildOptionsSelect(),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: _showDetails ? 90 : MediaQuery.of(context).size.height,
              left: 0,
              right: 0,
              bottom: 0,
              child: DetailsContainer(
                scrollController: _scrollController,
                idCustomer: _idCustomer,
              ),
            ),
          ],
        ));
  }

  Widget _buildOptionsSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: OptionsSelect(
              optionSelected: _optionSelected,
              onTap: () {
                _showOptions(context);
              }),
        ),
      ],
    );
  }

  void _showOptions(BuildContext context) async {
    await _allCustomersFuture;

    showModalBottomSheet<Customer>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(darkBlue),
                  Color(lightBlue),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setModalState(() {
                        _searchQuery = value;
                        _filteredOptions = _allCustomers
                            .where((customer) => customer.companyName
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Pesquisar...',
                      prefixIcon:
                          Icon(CupertinoIcons.search, color: Color(darkBlue)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      filled: true,
                      fillColor: Color(white),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredOptions.length,
                      itemBuilder: (context, index) {
                        final customer = _filteredOptions[index];
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
                            title: Text(
                              customer.companyName,
                              style: const TextStyle(
                                color: Color(darkBlue),
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Icon(
                              _optionSelected == customer.companyName
                                  ? CupertinoIcons.check_mark_circled
                                  : CupertinoIcons.circle,
                              color: const Color(darkBlue),
                              size: 18,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            onTap: () => Navigator.pop(context, customer),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    ).then((selectedOption) {
      setState(() {
        _searchQuery = "";
        _filteredOptions = List.from(_allCustomers);
      });

      if (selectedOption != null) {
        setState(() {
          _optionSelected = selectedOption.companyName;
          _idCustomer = selectedOption.idCustomer;
          _showDetails = true;
        });
      }
    });
  }
}
