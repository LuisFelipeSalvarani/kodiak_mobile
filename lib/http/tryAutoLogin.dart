import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:kodiak/pages/home_page.dart';
import 'package:kodiak/providers/user_provider.dart';
import 'package:kodiak/utils/dio_client.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../pages/login_page.dart';

Future<void> tryAutoLogin(GlobalKey<NavigatorState> navigatorKey) async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.get('/users',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));

    if (response.statusCode == 200) {
      final userData = response.data['user'];
      final user = User.fromJson(userData);

      final context = navigatorKey.currentContext;

      if (context != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
      }

      print(userData);

      navigatorKey.currentState?.pushReplacement(
        PageTransition(
          type: PageTransitionType.size,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: const HomePage(),
          curve: Curves.easeInOut,
        ),
      );
    } else {
      navigatorKey.currentState?.pushReplacement(
        PageTransition(
          type: PageTransitionType.size,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 300),
          child: const LoginPage(),
          curve: Curves.easeInOut,
        ),
      );
    }
  } catch (e) {
    navigatorKey.currentState?.pushReplacement(
      PageTransition(
        type: PageTransitionType.size,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        child: const LoginPage(),
        curve: Curves.easeInOut,
      ),
    );
  }
}
