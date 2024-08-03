import 'package:flutter/foundation.dart';
import 'package:intern_test/model/budget_category.dart';

import '../services/firebase_services.dart';

class BudgetProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<BudgetCategory> _categories = [];

  List<BudgetCategory> get categories => _categories;
  double get totalBudget =>
      _categories.fold(0, (sum, category) => sum + category.budgetedAmount);
  double get totalSpent =>
      _categories.fold(0, (sum, category) => sum + category.spentAmount);

  Future<void> fetchCategories() async {
    _categories = await _firestoreService.getCategories();
    notifyListeners();
  }

  Future<void> addCategory(BudgetCategory category) async {
    await _firestoreService.addCategory(category);
    await fetchCategories();
  }

  Future<void> updateCategory(BudgetCategory category) async {
    await _firestoreService.updateCategory(category);
    int index = _categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      _categories[index] = category;
    }
    notifyListeners();
  }

  Future<void> deleteCategory(String categoryId) async {
    await _firestoreService.deleteCategory(categoryId);
    await fetchCategories();
  }
}
