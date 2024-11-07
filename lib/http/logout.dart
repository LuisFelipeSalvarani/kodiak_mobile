import 'dart:async';

import 'package:dio/dio.dart';

import '../utils/dio_client.dart';

Future<void> logout() async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.get('/auth/logout',
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erro inesperado. Tente novamente mais tarde.');
    }
  } on DioException catch (e) {
    throw Exception('Ocorreu um erro ao fazer logout: ${e.message}');
  }
}
