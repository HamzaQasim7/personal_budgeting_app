import 'package:flutter/material.dart';

class BudgetCategory {
  String id;
  String name;
  double budgetedAmount;
  double spentAmount;
  Color color;
  IconData icon;
  String currencyCode;

  BudgetCategory({
    required this.id,
    required this.name,
    required this.budgetedAmount,
    this.spentAmount = 0,
    this.color = Colors.blue,
    this.icon = Icons.category,
    this.currencyCode = 'PKR',
  });

  factory BudgetCategory.fromMap(Map<String, dynamic> map, String id) {
    return BudgetCategory(
      id: id,
      name: map['name'],
      budgetedAmount: map['budgetedAmount'],
      spentAmount: map['spentAmount'] ?? 0,
      color: Color(map['color'] ?? Colors.blue.value),
      icon: IconData(map['icon'] ?? Icons.category.codePoint,
          fontFamily: 'MaterialIcons'),
      currencyCode: map['currencyCode'] ?? 'PKR',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'budgetedAmount': budgetedAmount,
      'spentAmount': spentAmount,
      'color': color.value,
      'icon': icon.codePoint,
      'currencyCode': currencyCode,
    };
  }
}
