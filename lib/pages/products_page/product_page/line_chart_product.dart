import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kodiak/http/get_product_sales_history.dart';
import 'package:kodiak/models/product_sales_history.dart';
import 'package:kodiak/utils/constants.dart';

class LineChartProduct extends StatefulWidget {
  final String idProduct;

  const LineChartProduct({super.key, required this.idProduct});

  @override
  State<LineChartProduct> createState() => _LineChartProductState();
}

class _LineChartProductState extends State<LineChartProduct> {
  late Future<ProductSalesHistory> _productSalesHistory;

  List<FlSpot> generateSpotsFromData(List<ProductSales> history) {
    return history
        .map(
            (data) => FlSpot(data.month.toDouble(), data.countSales.toDouble()))
        .toList();
  }

  List<FlSpot> allSpots = [];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: const Color(darkBlue),
      fontFamily: 'Digital',
      fontSize: 18 * chartWidth / 500,
    );

    String monthAbbreviation;
    switch (value.toInt()) {
      case 1:
        monthAbbreviation = 'Jan';
        break;
      case 2:
        monthAbbreviation = 'Feb';
        break;
      case 3:
        monthAbbreviation = 'Mar';
        break;
      case 4:
        monthAbbreviation = 'Apr';
        break;
      case 5:
        monthAbbreviation = 'May';
        break;
      case 6:
        monthAbbreviation = 'Jun';
        break;
      case 7:
        monthAbbreviation = 'Jul';
        break;
      case 8:
        monthAbbreviation = 'Aug';
        break;
      case 9:
        monthAbbreviation = 'Sep';
        break;
      case 10:
        monthAbbreviation = 'Oct';
        break;
      case 11:
        monthAbbreviation = 'Nov';
        break;
      case 12:
        monthAbbreviation = 'Dec';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(monthAbbreviation, style: style),
    );
  }

  Future<void> _loadProductSalesHistory() async {
    final productSalesHistory =
        await getProductSalesHistory(idProduct: widget.idProduct);

    final spots =
        generateSpotsFromData(productSalesHistory.productSalesHistory);

    setState(() {
      allSpots = spots;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProductSalesHistory();
  }

  @override
  Widget build(BuildContext context) {
    if (allSpots.isEmpty) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }

    final maxYValue =
        allSpots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b) + 100;

    List<int> showingTooltipOnSpots =
        List.generate(allSpots.length, (index) => index);

    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 4,
        shadow: const Shadow(
          blurRadius: 8,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              const Color(0xFFDFF2EB).withOpacity(0.4),
              const Color(0xFFB9E5E8).withOpacity(0.4),
              const Color(0xFF7AB2D3).withOpacity(0.4),
            ],
          ),
        ),
        dotData: const FlDotData(show: true),
        gradient: const LinearGradient(
          colors: [
            Color(darkBlue),
            Color(lightBlue),
          ],
          stops: [0.1, 0.9],
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: LayoutBuilder(
          builder: (context, contraints) {
            return LineChart(
              LineChartData(
                showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                  return ShowingTooltipIndicators([
                    LineBarSpot(
                        tooltipsOnBar,
                        lineBarsData.indexOf(tooltipsOnBar),
                        tooltipsOnBar.spots[index])
                  ]);
                }).toList(),
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipPadding: const EdgeInsets.symmetric(horizontal: 8),
                    getTooltipColor: (spot) => Color(darkBlue).withOpacity(0.9),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map(
                        (spot) {
                          return LineTooltipItem(
                            '${spot.y.toInt()}',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ).toList();
                    },
                  ),
                ),
                lineBarsData: lineBarsData,
                minY: 0,
                maxY: maxYValue,
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    axisNameWidget: Text(''),
                    axisNameSize: 24.0,
                    sideTitles: SideTitles(
                      showTitles: false,
                      reservedSize: 0,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return bottomTitleWidgets(
                          value,
                          meta,
                          contraints.maxWidth,
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    axisNameWidget: Text(
                      'Quantidade',
                      style: TextStyle(
                        color: Color(darkBlue),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sideTitles: SideTitles(
                      showTitles: false,
                      reservedSize: 0,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    axisNameWidget: Text(
                      'Vendas por mês',
                      style: TextStyle(
                        color: Color(darkBlue),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    axisNameSize: 32,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 0,
                    ),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(darkBlue)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
