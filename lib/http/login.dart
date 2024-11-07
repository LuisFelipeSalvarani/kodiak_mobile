import 'dart:async';

import 'package:dio/dio.dart';

import '../models/user_model.dart';
import '../utils/dio_client.dart';

Future<User> login(String email, String password) async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.post('/auth/login',
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode == 200) {
      final data = response.data;

      final user = data['user'];

      return User.fromJson(user);
    } else {
      throw Exception('Erro inesperado. Tente novamente mais tarde.');
    }
  } on DioException catch (e) {
    if (e.response?.statusCode == 401) {
      throw Exception('Dados inválidos. Verifique seu e-mail e senha.');
    } else {
      throw Exception('Ocorreu um erro inesperado. tente mais tarde.');
    }
  }
}
