import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kodiak/http/get_sales_report_grouped_by_product_group.dart';
import 'package:kodiak/models/sales_report_grouped_by_product_group.dart';
import 'package:kodiak/utils/constants.dart';

class PieChartProducts extends StatefulWidget {
  const PieChartProducts({super.key});

  @override
  State<PieChartProducts> createState() => _PieChartProductsState();
}

class _PieChartProductsState extends State<PieChartProducts> {
  late Future<SalesReportGroupedProductGroup> _salesReportGroupedProductGroup;

  @override
  void initState() {
    super.initState();
    _salesReportGroupedProductGroup = getSalesReportGroupedByProductGroup();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _salesReportGroupedProductGroup,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final report = snapshot.data!.salesGroupedByProductGroup;
            final totalSales = snapshot.data!.totalSales;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 4),
                const Text(
                  'Divisão das vendas por grupo',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Divider(
                  indent: 32,
                  endIndent: 32,
                ),
                Expanded(
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        children: [
                          PieChart(
                            PieChartData(
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 2,
                              centerSpaceRadius: 80,
                              sections: showingSections(report, totalSales),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Total:\n${NumberFormat.compact(locale: 'pt_BR').format(totalSales)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 32.0, bottom: 8.0),
                  child: Text(
                    'Grupos:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: RawScrollbar(
                      thumbVisibility: true,
                      thickness: 10,
                      thumbColor: const Color(darkBlue),
                      radius: const Radius.circular(8.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: report.asMap().entries.map((entry) {
                              final index = entry.key;
                              final group = entry.value;
                              final color = _colorForIndex(index);
                              return Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      CupertinoIcons.square_fill,
                                      color: color,
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          group.descriptionGroup,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          'Total: ${NumberFormat.decimalPattern('pt_BR').format(group.totalSalesGroup)}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  if (index < report.length - 1) const Divider()
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Container();
        });
  }

  List<PieChartSectionData> showingSections(
      List<ProductGroup> report, int totalSales) {
    const fontSize = 16.0;
    const radius = 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    return report.asMap().entries.map((entry) {
      final index = entry.key;
      final group = entry.value;
      final color = _colorForIndex(index);
      final percentage = (group.totalSalesGroup / totalSales) * 100;

      return PieChartSectionData(
        color: color,
        value: group.totalSalesGroup.toDouble(),
        title: percentage < 1 ? '' : '${percentage.toStringAsFixed(1)}%',
        titlePositionPercentageOffset: percentage < 1.0 ? 1.5 : 0.5,
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Color(white),
          shadows: shadows,
        ),
      );
    }).toList();
  }

  Color _colorForIndex(int index) {
    const colors = [
      Color(0xFF59CE8F), // Verde
      Color(0xFF7695FF), // Azul
      Color(0xFF8B5DFF), // Roxo
      Color(0xFFFF0303), // Vermelho
      Color(0xFFFF8000), // Laranja
      Color(0xFFF3C623), // Amarelo
      Color(0xFFD91656), // Rosa
      Color(0xFF36BA98), // Teal
    ];

    return colors[index % colors.length];
  }
}
