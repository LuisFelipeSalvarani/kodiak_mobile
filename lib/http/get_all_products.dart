import 'package:dio/dio.dart';
import 'package:kodiak/models/all_products.dart';

import '../utils/dio_client.dart';

Future<AllProducts> getAllProducts({int? idGroup}) async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response =
        await dio.get('/products${idGroup != null ? '?idGroup=$idGroup' : ''}');

    if (response.statusCode == 200) {
      return AllProducts.fromJson(response.data);
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  } on DioException catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
