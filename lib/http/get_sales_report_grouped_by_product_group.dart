import 'package:dio/dio.dart';
import 'package:kodiak/models/sales_report_grouped_by_product_group.dart';

import '../utils/dio_client.dart';

Future<SalesReportGroupedProductGroup>
    getSalesReportGroupedByProductGroup() async {
  final Dio dio = await DioClient.getInstance();

  try {
    final response = await dio.get('/sales/report/grouped/product/group');

    if (response.statusCode == 200) {
      return SalesReportGroupedProductGroup.fromJson(response.data);
    } else {
      throw Exception('Erro ao carregar os dados');
    }
  } on DioException catch (e) {
    throw Exception('Erro na requisição: $e');
  }
}
