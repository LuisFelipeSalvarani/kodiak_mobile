import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/http/logout.dart';
import 'package:kodiak/pages/costumer_page/costumer_page.dart';
import 'package:kodiak/pages/login_page.dart';
import 'package:kodiak/pages/products_page/products_page.dart';
import 'package:kodiak/pages/sales_page/sales_page.dart';
import 'package:kodiak/providers/user_provider.dart';
import 'package:kodiak/utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: const Color(white),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(darkBlue), Color(lightBlue)]),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 5))
              ]),
        ),
        // centerTitle: true,
        // title: const Text('Kodiak', style: TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 0.53),),
        //shape: const RoundedRectangleBorder(
        ///borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0))),
        // leading: InkWell(
        //   onTap: () {},
        //   child: const Icon(
        //     Icons.subject,
        //     color: Colors.white,
        //   ),
        // ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
                onTap: () async {
                  try {
                    await logout();

                    Provider.of<UserProvider>(context, listen: false)
                        .clearUser();

                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 300),
                            child: const LoginPage(),
                            curve: Curves.easeInOut));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao fazer logout: $e')),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    CupertinoIcons.arrow_right_to_line,
                    size: 30,
                    color: Color(white),
                  ),
                )),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(140.0),
          child: Container(
            padding: const EdgeInsets.only(left: 30.0, bottom: 30.0),
            child: Row(
              children: [
                const Stack(
                  children: [
                    CircleAvatar(
                      radius: 56.0,
                      backgroundColor: Color(white),
                      child: Icon(
                        Icons.person_outline_rounded,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? 'Usuário',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(white),
                        ),
                      ),
                      Text(
                        user?.tradeName ?? 'Empresa',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(white),
                        ),
                      ),
                      Text(
                        user?.position ?? 'Vendedor',
                        style:
                            const TextStyle(fontSize: 16, color: Color(white)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSquareButton(CupertinoIcons.bag_fill, 'Vendas', () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.size,
                              alignment: Alignment.center,
                              duration: const Duration(milliseconds: 300),
                              child: const SalesPage(),
                              curve: Curves.easeInOut));
                    }),
                    buildSquareButton(CupertinoIcons.person_2_alt, 'Clientes',
                        () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.size,
                              alignment: Alignment.center,
                              duration: const Duration(milliseconds: 300),
                              child: const CostumerPage(),
                              curve: Curves.easeInOut));
                    })
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSquareButton(CupertinoIcons.bag_fill, 'Vendas', () {}),
                    buildSquareButton(CupertinoIcons.cube_box_fill, 'Produtos',
                        () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.size,
                              alignment: Alignment.center,
                              duration: const Duration(milliseconds: 300),
                              child: const ProductsPage(),
                              curve: Curves.easeInOut));
                    })
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSquareButton(CupertinoIcons.bag_fill, 'Vendas', () {}),
                    buildSquareButton(CupertinoIcons.bag_fill, 'Vendas', () {})
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildSquareButton(IconData icon, String label, VoidCallback onPressed) {
  return Expanded(
    child: AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(darkBlue),
                    Color(lightBlue),
                  ]),
              color: const Color(darkBlue),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 5))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 80,
                color: const Color(white),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                label,
                style: const TextStyle(color: Color(white), fontSize: 24),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
