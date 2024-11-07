import 'package:dio/dio.dart';
import 'package:kodiak/models/top_selling_products.dart';

import '../utils/dio_client.dart';

Future<TopSellingProducts> getTopSellingProducts() async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.get('/sales/top/selling/products');

    if (response.statusCode == 200) {
      return TopSellingProducts.fromJson(response.data);
    } else {
      throw Exception('Erro ao carregar os produtos');
    }
  } on DioException catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
