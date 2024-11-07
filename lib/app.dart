import 'package:flutter/material.dart';
import 'package:kodiak/http/tryAutoLogin.dart';
import 'package:kodiak/pages/login_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tryAutoLogin(navigatorKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodiak',
      navigatorKey: navigatorKey,
      home: const LoginPage(),
    );
  }
}
