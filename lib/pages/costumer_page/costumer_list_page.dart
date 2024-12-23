import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/http/get_all_customers.dart';
import 'package:kodiak/models/all_customers.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/constants.dart';
import 'customer_details_page.dart';

class CustomersListPage extends StatefulWidget {
  const CustomersListPage({super.key});

  @override
  State<CustomersListPage> createState() => _CustomersListPageState();
}

class _CustomersListPageState extends State<CustomersListPage> {
  List<Customer> _filteredOptions = [];
  String _searchQuery = "";
  bool showResetFilter = false;
  List<Customer> _allCustomers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    handleAllProducts();
  }

  Future<void> handleAllProducts({int? idGroup}) async {
    final AllCustomers allCustomers = await getAllCustomers();
    setState(() {
      _allCustomers = allCustomers.allCustomers;
      _filteredOptions = List.from(_allCustomers);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // _buildOptionsSelect(),
          const SizedBox(height: 10.0),
          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
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
            'Selecione um cliente:',
            style: TextStyle(
              color: Color(darkBlue),
              fontSize: 18,
              fontWeight: FontWeight.w500,
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
                      CupertinoIcons.cube_box_fill,
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
                    trailing: const Icon(
                      CupertinoIcons.chevron_right,
                      color: Color(darkBlue),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 24.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.size,
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 300),
                          child: CustomerDetailsPage(
                              customerId: customer.idCustomer),
                          curve: Curves.easeInOut,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildOptionsSelect() {
  //   return Center(
  //     child: Options(
  //         optionSelected: _optionSelected,
  //         onTap: () {
  //           _showOptions(context);
  //         }),
  //   );
  // }

  // void _showOptions(BuildContext context) async {
  //   await _allProductGroupsFuture;
  //
  //   showModalBottomSheet<ProductGroup>(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setModalState) {
  //         return Container(
  //           decoration: const BoxDecoration(
  //             gradient: LinearGradient(
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight,
  //               colors: [
  //                 Color(darkBlue),
  //                 Color(lightBlue),
  //               ],
  //             ),
  //             borderRadius: BorderRadius.vertical(
  //               top: Radius.circular(20),
  //             ),
  //           ),
  //           height: MediaQuery.of(context).size.height,
  //           padding: const EdgeInsets.symmetric(vertical: 8.0),
  //           child: Padding(
  //             padding:
  //                 const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
  //             child: Column(
  //               children: [
  //                 TextField(
  //                   onChanged: (value) {
  //                     setModalState(() {
  //                       _searchQuery = value;
  //                       _filteredGroupOptions = _allProductGroups
  //                           .where((productGroup) => productGroup
  //                               .descriptionGroup
  //                               .toLowerCase()
  //                               .contains(_searchGroupQuery.toLowerCase()))
  //                           .toList();
  //                     });
  //                   },
  //                   decoration: const InputDecoration(
  //                     hintText: 'Pesquisar...',
  //                     prefixIcon:
  //                         Icon(CupertinoIcons.search, color: Color(darkBlue)),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                     ),
  //                     filled: true,
  //                     fillColor: Color(white),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 10.0),
  //                 Expanded(
  //                   child: ListView.builder(
  //                     itemCount: _filteredGroupOptions.length,
  //                     itemBuilder: (context, index) {
  //                       final productGroup = _filteredGroupOptions[index];
  //                       return Container(
  //                         margin: const EdgeInsets.symmetric(
  //                             vertical: 8.0, horizontal: 2.0),
  //                         decoration: const BoxDecoration(
  //                           color: Color(white),
  //                           borderRadius: BorderRadius.all(
  //                             Radius.circular(8.0),
  //                           ),
  //                           boxShadow: [
  //                             BoxShadow(
  //                                 color: Colors.black26,
  //                                 spreadRadius: 0,
  //                                 blurRadius: 1,
  //                                 offset: Offset(0, 1))
  //                           ],
  //                         ),
  //                         child: ListTile(
  //                           leading: const Icon(
  //                             CupertinoIcons.building_2_fill,
  //                             color: Color(darkBlue),
  //                           ),
  //                           title: Text(
  //                             productGroup.descriptionGroup,
  //                             style: const TextStyle(
  //                               color: Color(darkBlue),
  //                               fontSize: 18.0,
  //                               fontWeight: FontWeight.w600,
  //                             ),
  //                           ),
  //                           trailing: Icon(
  //                             _optionSelected == productGroup.descriptionGroup
  //                                 ? CupertinoIcons.check_mark_circled
  //                                 : CupertinoIcons.circle,
  //                             color: const Color(darkBlue),
  //                             size: 18,
  //                           ),
  //                           contentPadding:
  //                               const EdgeInsets.symmetric(horizontal: 24.0),
  //                           onTap: () => Navigator.pop(context, productGroup),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  //     },
  //   ).then((selectedOption) {
  //     setState(() {
  //       _searchGroupQuery = "";
  //       _filteredGroupOptions = List.from(_allProductGroups);
  //     });
  //
  //     if (selectedOption != null) {
  //       setState(() {
  //         _optionSelected = selectedOption.descriptionGroup;
  //         showResetFilter = true;
  //         _idGroup = selectedOption.idGroup;
  //         _searchController.clear();
  //         handleAllProducts(idGroup: _idGroup);
  //       });
  //     }
  //   });
  // }
}
