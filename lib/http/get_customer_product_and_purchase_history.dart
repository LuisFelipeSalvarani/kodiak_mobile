import 'package:dio/dio.dart';
import 'package:kodiak/models/customer_product_and_purchase_history.dart';

import '../utils/dio_client.dart';

Future<CustomerHistory> getCustomerProductAndPurchaseHistory(
    {required String idCustomer}) async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.get('/customers/$idCustomer/products/history');

    if (response.statusCode == 200) {
      return CustomerHistory.fromJson(response.data);
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  } on DioException catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
