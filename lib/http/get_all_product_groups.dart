import 'package:dio/dio.dart';
import 'package:kodiak/models/all_product_groups.dart';

import '../utils/dio_client.dart';

Future<AllProductGroups> getAllProductGroups() async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.get('/products/groups');

    if (response.statusCode == 200) {
      return AllProductGroups.fromJson(response.data);
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  } on DioException catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
