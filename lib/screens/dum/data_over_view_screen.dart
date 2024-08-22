import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int _selectedPeriod = 0; // 0 for weekly, 1 for monthly, 2 for yearly

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Select Period',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _selectedPeriod = 0),
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        _selectedPeriod == 0 ? Colors.white : Colors.black,
                    backgroundColor:
                        _selectedPeriod == 0 ? Colors.blue : Colors.grey[300],
                  ),
                  child: const Text('Weekly'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () => setState(() => _selectedPeriod = 1),
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        _selectedPeriod == 1 ? Colors.white : Colors.black,
                    backgroundColor:
                        _selectedPeriod == 1 ? Colors.blue : Colors.grey[300],
                  ),
                  child: const Text('Monthly'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () => setState(() => _selectedPeriod = 2),
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        _selectedPeriod == 2 ? Colors.white : Colors.black,
                    backgroundColor:
                        _selectedPeriod == 2 ? Colors.blue : Colors.grey[300],
                  ),
                  child: const Text('Yearly'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getChartData(_selectedPeriod),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.3),
                      ),
                    ),
                  ],
                  minX: 0,
                  maxX: _selectedPeriod == 0
                      ? 6
                      : _selectedPeriod == 1
                          ? 11
                          : 11,
                  minY: 0,
                  maxY: 1000,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) {
                          switch (_selectedPeriod) {
                            case 0:
                              return Text([
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat',
                                'Sun'
                              ][value.toInt()]);
                            case 1:
                              return Text([
                                'Jan',
                                'Feb',
                                'Mar',
                                'Apr',
                                'May',
                                'Jun',
                                'Jul',
                                'Aug',
                                'Sep',
                                'Oct',
                                'Nov',
                                'Dec'
                              ][value.toInt()]);
                            case 2:
                              return Text([
                                '2020',
                                '2021',
                                '2022',
                                '2023',
                                '2024',
                                '2025',
                                '2026',
                                '2027',
                                '2028',
                                '2029',
                                '2030'
                              ][value.toInt()]);
                          }
                          return Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          return Text('\$${value.toInt()}');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _getChartData(int period) {
    // Replace this with your actual data
    switch (period) {
      case 0:
        return [
          const FlSpot(0, 500),
          const FlSpot(1, 600),
          const FlSpot(2, 700),
          const FlSpot(3, 800),
          const FlSpot(4, 900),
          const FlSpot(5, 800),
          const FlSpot(6, 700),
        ];
      case 1:
        return [
          const FlSpot(0, 500),
          const FlSpot(1, 550),
          const FlSpot(2, 600),
          const FlSpot(3, 650),
          const FlSpot(4, 700),
          const FlSpot(5, 750),
          const FlSpot(6, 800),
          const FlSpot(7, 850),
          const FlSpot(8, 900),
          const FlSpot(9, 950),
          const FlSpot(10, 1000),
          const FlSpot(11, 950),
        ];
      case 2:
        return [
          const FlSpot(0, 500),
          const FlSpot(1, 550),
          const FlSpot(2, 600),
          const FlSpot(3, 650),
          const FlSpot(4, 700),
          const FlSpot(5, 750),
          const FlSpot(6, 800),
          const FlSpot(7, 850),
          const FlSpot(8, 900),
          const FlSpot(9, 950),
          const FlSpot(10, 1000),
          const FlSpot(11, 950),
        ];
    }
    return [];
  }
}
