import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/http/get_all_product_groups.dart';
import 'package:kodiak/http/get_all_products.dart';
import 'package:kodiak/models/all_products.dart';

import '../../../components/options.dart';
import '../../../models/all_product_groups.dart';
import '../../../utils/constants.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  List<Product> _allProducts = [];
  List<Product> _filteredOptions = [];
  String _searchQuery = "";
  String _optionSelected = 'Selecionar um Grupo...';
  bool showResetFilter = false;
  late Future<List<ProductGroup>> _allProductGroupsFuture;
  List<ProductGroup> _allProductGroups = [];
  List<ProductGroup> _filteredGroupOptions = [];
  String _searchGroupQuery = "";
  late int _idGroup;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _unitValue = TextEditingController();
  final TextEditingController _unitCost = TextEditingController();
  final TextEditingController _qtd = TextEditingController();
  final TextEditingController _result = TextEditingController();
  late String _selectedCalculation;

  @override
  void initState() {
    super.initState();
    handleAllProducts();
    _allProductGroupsFuture = handleAllProductGroups();
  }

  Future<List<ProductGroup>> handleAllProductGroups() async {
    final AllProductGroups allProductGroups = await getAllProductGroups();
    _allProductGroups = allProductGroups.allProductGroups;
    _filteredGroupOptions = List.from(_allProductGroups);
    return _allProductGroups;
  }

  Future<void> handleAllProducts({int? idGroup}) async {
    final AllProducts allProducts = await getAllProducts(idGroup: idGroup);
    setState(() {
      _allProducts = allProducts.allProducts;
      _filteredOptions = List.from(_allProducts);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _unitValue.dispose();
    _unitCost.dispose();
    _qtd.dispose();
    _result.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildOptionsSelect(),
          const SizedBox(height: 10.0),
          TextField(
            controller: _searchController,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Selecione um produto:',
                style: TextStyle(
                  color: Color(darkBlue),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Visibility(
                visible: showResetFilter,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      handleAllProducts();
                      _optionSelected = 'Selecionar um Grupo...';
                      _searchQuery = "";
                      _searchController.clear();
                      showResetFilter = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(darkBlue),
                  ),
                  child: const Text(
                    'Resetar Filtro',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
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
                    onTap: () {
                      _showCalculatorOptions(
                          context, double.parse(product.unitValue));
                      setState(() {
                        _unitValue.text = '';
                        _unitCost.text = '';
                        _qtd.text = '';
                        _result.text = '';
                      });
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

  Widget _buildOptionsSelect() {
    return Center(
      child: Options(
          optionSelected: _optionSelected,
          onTap: () {
            _showOptions(context);
          }),
    );
  }

  void _showOptions(BuildContext context) async {
    await _allProductGroupsFuture;

    showModalBottomSheet<ProductGroup>(
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
                        _filteredGroupOptions = _allProductGroups
                            .where((productGroup) => productGroup
                                .descriptionGroup
                                .toLowerCase()
                                .contains(_searchGroupQuery.toLowerCase()))
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
                      itemCount: _filteredGroupOptions.length,
                      itemBuilder: (context, index) {
                        final productGroup = _filteredGroupOptions[index];
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
                              productGroup.descriptionGroup,
                              style: const TextStyle(
                                color: Color(darkBlue),
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: Icon(
                              _optionSelected == productGroup.descriptionGroup
                                  ? CupertinoIcons.check_mark_circled
                                  : CupertinoIcons.circle,
                              color: const Color(darkBlue),
                              size: 18,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            onTap: () => Navigator.pop(context, productGroup),
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
        _searchGroupQuery = "";
        _filteredGroupOptions = List.from(_allProductGroups);
      });

      if (selectedOption != null) {
        setState(() {
          _optionSelected = selectedOption.descriptionGroup;
          showResetFilter = true;
          _idGroup = selectedOption.idGroup;
          _searchController.clear();
          handleAllProducts(idGroup: _idGroup);
        });
      }
    });
  }

  void _showCalculatorOptions(BuildContext context, double unitValue) {
    showModalBottomSheet<double>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          height: MediaQuery.of(context).size.height / 5,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                title: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Color(white),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Text(
                    'Margem de Contribuição',
                    style: TextStyle(color: Color(darkBlue), fontSize: 18.0),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context, unitValue);
                  _showCalculator(context);
                  setState(() {
                    _selectedCalculation = 'Margem de Contribuição';
                  });
                },
              ),
              ListTile(
                title: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Color(white),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Text(
                    'Margem de Lucro',
                    style: TextStyle(color: Color(darkBlue), fontSize: 18.0),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context, unitValue);
                  _showCalculator(context);
                  setState(() {
                    _selectedCalculation = 'Margem de Lucro';
                  });
                },
              ),
            ],
          ),
        );
      },
    ).then((selectedOption) {
      if (selectedOption != null) {
        setState(() {
          _unitValue.text = selectedOption.toString();
        });
      }
    });
  }

  final FocusNode _qtdFocus = FocusNode();
  final FocusNode _unitCostFocus = FocusNode();
  final FocusNode _unitValueFocus = FocusNode();
  final FocusNode _resultFocus = FocusNode();

  void _updateActiveField(String value) {
    if (_qtdFocus.hasFocus) {
      _qtd.text += value;
    } else if (_unitCostFocus.hasFocus) {
      _unitCost.text += value;
    } else if (_unitValueFocus.hasFocus) {
      _unitValue.text += value;
    }
  }

  void _clearLastCharacter() {
    if (_qtdFocus.hasFocus && _qtd.text.isNotEmpty) {
      _qtd.text = _qtd.text.substring(0, _qtd.text.length - 1);
    } else if (_unitCostFocus.hasFocus && _unitCost.text.isNotEmpty) {
      _unitCost.text = _unitCost.text.substring(0, _unitCost.text.length - 1);
    } else if (_unitValueFocus.hasFocus && _unitValue.text.isNotEmpty) {
      _unitValue.text =
          _unitValue.text.substring(0, _unitValue.text.length - 1);
    } else if (_resultFocus.hasFocus && _result.text.isNotEmpty) {
      _result.text = _result.text.substring(0, _result.text.length - 1);
    }
  }

  void _calculation() async {
    if (_selectedCalculation == 'Margem de Contribuição') {
      if (_unitValue.text.isNotEmpty &&
          _unitCost.text.isNotEmpty &&
          _qtd.text.isNotEmpty) {
        final double unitValue = double.parse(_unitValue.text);
        final double unitCost = double.parse(_unitCost.text);
        final double quantity = double.parse(_qtd.text);

        final double result = (unitValue - unitCost) * quantity;

        _result.text = result.toStringAsFixed(2);
      }
    } else if (_selectedCalculation == 'Margem de Lucro') {
      if (_unitValue.text.isNotEmpty && _unitCost.text.isNotEmpty) {
        final double unitValue = double.parse(_unitValue.text);
        final double unitCost = double.parse(_unitCost.text);

        final double result = (unitValue - unitCost) / unitCost * 100;

        _result.text = result.toStringAsFixed(2);
      }
    }
  }

  void _showCalculator(BuildContext context) {
    showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(darkBlue), Color(lightBlue)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _selectedCalculation,
                    style: const TextStyle(
                      color: Color(white),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _qtd,
                          focusNode: _qtdFocus,
                          decoration: const InputDecoration(
                            hintText: 'Quantidade',
                            //prefixIcon:
                            //    Icon(CupertinoIcons.search, color: Color(darkBlue)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(darkBlue), width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(darkBlue)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            filled: true,
                            fillColor: Color(white),
                          ),
                          keyboardType: TextInputType.none,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _unitCost,
                          focusNode: _unitCostFocus,
                          decoration: const InputDecoration(
                            hintText: 'Custo unitário',
                            //prefixIcon:
                            //    Icon(CupertinoIcons.search, color: Color(darkBlue)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(darkBlue), width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(darkBlue)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            filled: true,
                            fillColor: Color(white),
                          ),
                          keyboardType: TextInputType.none,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _unitValue,
                          focusNode: _unitValueFocus,
                          decoration: const InputDecoration(
                            hintText: 'Preço unitário',
                            //prefixIcon:
                            //    Icon(CupertinoIcons.search, color: Color(darkBlue)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(darkBlue), width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(darkBlue)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            filled: true,
                            fillColor: Color(white),
                          ),
                          keyboardType: TextInputType.none,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _result,
                    focusNode: _resultFocus,
                    decoration: const InputDecoration(
                      hintText: 'Resultado...',
                      //prefixIcon:
                      //    Icon(CupertinoIcons.search, color: Color(darkBlue)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(darkBlue), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(darkBlue)),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      filled: true,
                      fillColor: Color(white),
                    ),
                    keyboardType: TextInputType.none,
                  ),
                  const SizedBox(height: 32),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 50,
                      crossAxisSpacing: 50,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      if (index < 9) {
                        return _buildNumberButton((index + 1).toString(),
                            () => _updateActiveField((index + 1).toString()));
                      } else if (index == 9) {
                        return _buildNumberButton(
                            ".", () => _updateActiveField("."));
                      } else if (index == 10) {
                        return _buildNumberButton(
                            "0", () => _updateActiveField("0"));
                      } else {
                        return _buildBackspaceButton(
                            () => _clearLastCharacter());
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: _calculation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      decoration: const BoxDecoration(
                          color: Color(white),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: const Text(
                        'Calcular',
                        style: TextStyle(
                          color: Color(darkBlue),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then((selectedOption) {
      if (selectedOption != null) {
        setState(() {
          //_selectedCalculation = selectedOption;
          //_showDetails = true;
        });
      }
    });
  }

  Widget _buildNumberButton(String number, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Text(
          number,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child:
            const Icon(Icons.backspace_rounded, size: 24, color: Color(white)),
      ),
    );
  }
}
