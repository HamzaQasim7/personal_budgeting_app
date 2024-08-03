import 'package:flutter/material.dart';
import 'package:intern_test/screens/edit_screen/add_edit_budget_screen.dart';
import 'package:provider/provider.dart';

import '../model/budget_category.dart';
import '../provider/budget_provider.dart';

class CategoryListItem extends StatelessWidget {
  final BudgetCategory category;

  const CategoryListItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    double progress = category.budgetedAmount > 0
        ? category.spentAmount / category.budgetedAmount
        : 0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditCategoryScreen(category: category),
          ),
        );
        Provider.of<BudgetProvider>(context, listen: false).fetchCategories();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              spreadRadius: 3,
              blurRadius: 0,
              offset: Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            Icon(category.icon, color: category.color),
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(fontWeightDelta: 2),
                  ),
                  Text(
                      'Budget: ${category.currencyCode} ${category.budgetedAmount.toStringAsFixed(2)}'),
                ],
              ),
            ),
            const Spacer(),
            CircularProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                category.spentAmount > category.budgetedAmount
                    ? Colors.red
                    : Colors.green,
              ),
            ),
            // Text(
            //   'Spent: ${category.currencyCode} ${category.spentAmount.toStringAsFixed(2)}',
            //   style: TextStyle(
            //     color: category.spentAmount > category.budgetedAmount
            //         ? Colors.red
            //         : Colors.green,
            //   ),
            // ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
