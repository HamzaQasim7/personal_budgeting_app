import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/budget_category.dart';

class BudgetPieChart extends StatelessWidget {
  final List<BudgetCategory> categories;

  const BudgetPieChart({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 5,
            sections: _generatePieChartSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections() {
    double totalBudget =
        categories.fold(0, (sum, item) => sum + item.budgetedAmount);
    return categories.map((category) {
      double percentage = (category.budgetedAmount / totalBudget) * 100;
      return PieChartSectionData(
        color: category.color,
        value: category.budgetedAmount,
        title: '${category.name}\n${percentage.toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}
