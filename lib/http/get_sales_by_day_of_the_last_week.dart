import 'package:dio/dio.dart';

import '../models/sales_by_day_of_the_last_week.dart';
import '../utils/dio_client.dart';

Future<SalesByDayOfTheLastWeek> getSalesByDayOfTheLastWeek() async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.get('/sales/by/days/last/week');

    if (response.statusCode == 200) {
      return SalesByDayOfTheLastWeek.fromJson(response.data);
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  } on DioException catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
