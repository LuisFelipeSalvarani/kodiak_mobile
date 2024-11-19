import 'package:dio/dio.dart';
import 'package:kodiak/models/product_by_id.dart';

import '../utils/dio_client.dart';

Future<ProductById> getProductById({required String idProduct}) async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.get('/products/$idProduct');

    if (response.statusCode == 200) {
      return ProductById.fromJson(response.data);
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  } on DioException catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
