import 'package:dio/dio.dart';
import 'package:kodiak/models/all_customers.dart';

import '../utils/dio_client.dart';

Future<AllCustomers> getAllCustomers() async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.get('/customers');

    if (response.statusCode == 200) {
      return AllCustomers.fromJson(response.data);
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  } on DioException catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
