import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/components/snack_bar.dart';
import 'package:kodiak/models/user_model.dart';
import 'package:kodiak/pages/home_page.dart';
import 'package:kodiak/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../http/login.dart';
import '../providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _loginAnimationController;
  bool animated = false;
  bool showLogo = false;
  bool showForm = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _loginAnimationController = AnimationController(vsync: this);

    _loginAnimationController.addListener(() {
      if (_loginAnimationController.value > 0.7) {
        _loginAnimationController.stop();

        animated = true;

        setState(() {
          Future.delayed(const Duration(milliseconds: 700), () {
            showLogo = true;

            setState(() {});
          });
        });

        setState(() {
          Future.delayed(const Duration(milliseconds: 1100), () {
            showForm = true;

            setState(() {});
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _loginAnimationController.dispose();

    _emailController.dispose();

    _passwordController.dispose();
  }

  Future<void> handleLogin() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        buildCustomSnackBar(
          title: 'Ops!',
          message: 'Preencha todos os campos',
          backgroundColor: Colors.red,
          icon: CupertinoIcons.exclamationmark_triangle_fill,
          iconColor: Colors.red.shade200,
        ),
      );
      return;
    }

    try {
      User user = await login(email, password);

      Provider.of<UserProvider>(context, listen: false).setUser(user);

      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.size,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 300),
              child: const HomePage(),
              curve: Curves.easeInOut));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: showLogo ? screenHeight / 2 : screenHeight,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(darkBlue), Color(lightBlue)]),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(animated ? 40.0 : 0.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 5))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedOpacity(
                    opacity: !animated ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Visibility(
                      visible: !animated,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                              color: Color(white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Lottie.asset('assets/loading.json',
                                  controller: _loginAnimationController,
                                  onLoaded: (composition) {
                                _loginAnimationController
                                  ..duration = composition.duration
                                  ..forward();
                              }, height: 120.0, width: 120.0),
                            )),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: animated ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    child: Visibility(
                      visible: animated,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 230,
                          height: 230,
                          decoration: const BoxDecoration(
                            color: Color(white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset('assets/kodiak_logo.png',
                                height: 190.0, width: 190.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: showForm ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Visibility(
                visible: showForm,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 62),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: screenHeight / 2,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 45,
                        padding: const EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: const BoxDecoration(
                            color: Color(white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 5)
                            ]),
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              hintText: 'E-mail'),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 45,
                        margin: const EdgeInsets.only(top: 32),
                        padding: const EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: const BoxDecoration(
                            color: Color(white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 5)
                            ]),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.vpn_key,
                                color: Colors.grey,
                              ),
                              hintText: 'Senha'),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 16, right: 32),
                          child: Text(
                            'Esqueceu a senha ?',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await handleLogin();
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 1.2,
                          margin: const EdgeInsets.only(top: 20.0),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(darkBlue), Color(lightBlue)]),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: const Offset(0, 2))
                              ]),
                          child: Center(
                            child: Text(
                              'Login'.toUpperCase(),
                              style: const TextStyle(
                                  color: Color(white),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
