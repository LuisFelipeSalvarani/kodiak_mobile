import 'package:dio/dio.dart';
import 'package:kodiak/models/product_sales_history.dart';

import '../utils/dio_client.dart';

Future<ProductSalesHistory> getProductSalesHistory(
    {required String idProduct}) async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.get('/products/history/product/$idProduct');

    if (response.statusCode == 200) {
      return ProductSalesHistory.fromJson(response.data);
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  } on DioException catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
