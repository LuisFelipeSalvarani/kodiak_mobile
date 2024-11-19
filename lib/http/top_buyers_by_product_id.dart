import 'package:dio/dio.dart';
import 'package:kodiak/models/top_buyers_by_product_id.dart';

import '../utils/dio_client.dart';

Future<TopBuyersByProductId> getTopBuyersByProductId(
    {required String idProduct}) async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response =
        await dio.get('/products/$idProduct/purchases/top/customers');

    if (response.statusCode == 200) {
      return TopBuyersByProductId.fromJson(response.data);
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  } on DioException catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
