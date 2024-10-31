import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/components/app_bar.dart';

class CostumerPage extends StatefulWidget {
  const CostumerPage({super.key});

  @override
  _CostumerPageState createState() => _CostumerPageState();
}

class _CostumerPageState extends State<CostumerPage> {
  String _optionSelected = 'Selecionar uma opção';
  bool _showDetails = false;
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showOptions(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: const Color(0xffe4e4e7)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              _optionSelected,
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.chevron_down,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: _showDetails ? 90 : MediaQuery.of(context).size.height,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF143c8c),
                      Color(0xFF398cbf),
                    ],
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, -1))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 24.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sobre:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            _optionSelected,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
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
                          const SizedBox(
                            height: 12.0,
                          ),
                        ],
                      ),
                      Expanded(
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
                          child: const RawScrollbar(
                            thumbVisibility: true,
                            thickness: 8,
                            radius: Radius.circular(15),
                            thumbColor: Color(0xFF398cbf),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.cube_fill,
                                          color: Color(0xFF143c8c),
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          'Produtos mais comprados',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF143c8c),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      title: Text('Produto 1'),
                                      subtitle: Text('Descrição 1'),
                                    ),
                                    ListTile(
                                      title: Text('Produto 2'),
                                      subtitle: Text('Descrição 2'),
                                    ),
                                    ListTile(
                                      title: Text('Produto 3'),
                                      subtitle: Text('Descrição 3'),
                                    ),
                                    ListTile(
                                      title: Text('Produto 4'),
                                      subtitle: Text('Descrição 4'),
                                    ),
                                    ListTile(
                                      title: Text('Produto 5'),
                                      subtitle: Text('Descrição 5'),
                                    ),
                                    ListTile(
                                      title: Text('Produto 6'),
                                      subtitle: Text('Descrição 6'),
                                    ),
                                    ListTile(
                                      title: Text('Produto 7'),
                                      subtitle: Text('Descrição 7'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Expanded(
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
                            thumbColor: const Color(0xFF398cbf),
                            child: SingleChildScrollView(
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.bag_fill,
                                          color: Color(0xFF143c8c),
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          'Últimas compras',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF143c8c),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      title: Text('Compra 1'),
                                      trailing: Text(
                                        'Valor: R\$2.000',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Compra 2'),
                                      trailing: Text(
                                        'Valor: R\$5.500',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Compra 3'),
                                      trailing: Text(
                                        'Valor: R\$3.000',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Compra 4'),
                                      trailing: Text(
                                        'Valor: R\$1.268',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Compra 5'),
                                      trailing: Text(
                                        'Valor: R\$10.000',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                            indent: 8,
                                            endIndent: 8,
                                          ),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      title: Text('Total comprado:'),
                                      trailing: Text(
                                        'Valor: R\$21.768',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void _showOptions(BuildContext context) async {
    final options = [
      'Cliente 1',
      'Cliente 2',
      'Cliente 3',
      'Cliente 4',
      'Cliente 5',
      'Cliente 6',
      'Cliente 7',
      'Cliente 8',
    ];

    final option = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF143c8c),
                Color(0xFF398cbf),
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
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 2.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
                      color: Color(0xFF143c8c),
                    ),
                    title: Text(
                      options[index],
                      style: const TextStyle(
                        color: Color(0xFF143c8c),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Icon(
                      _optionSelected == options[index]
                          ? CupertinoIcons.check_mark_circled
                          : CupertinoIcons.circle,
                      color: const Color(0xFF143c8c),
                      size: 18,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 24.0),
                    onTap: () => Navigator.pop(context, options[index]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    if (option != null) {
      setState(() {
        _optionSelected = option;
        _showDetails = true;
      });
    }
  }
}
