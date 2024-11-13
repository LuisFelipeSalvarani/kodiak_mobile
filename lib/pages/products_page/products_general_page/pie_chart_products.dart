import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/http/get_sales_report_grouped_by_product_group.dart';
import 'package:kodiak/models/sales_report_grouped_by_product_group.dart';

import '../../../utils/constants.dart';

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
            return Row(
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(report, totalSales),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: report.asMap().entries.map((entry) {
                      final index = entry.key;
                      final group = entry.value;
                      final color = _colorForIndex(index);

                      return Row(
                        children: [
                          Icon(
                            CupertinoIcons.circle_fill,
                            color: color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            group.descriptionGroup,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                )
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
        title: '${percentage < 1 ? '' : percentage.toStringAsFixed(1)}%',
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
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.black,
      Colors.lime,
      Colors.pink,
    ];

    return colors[index % colors.length];
  }
}
