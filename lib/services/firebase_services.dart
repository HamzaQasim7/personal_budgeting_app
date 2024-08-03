import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/budget_category.dart';

class FirestoreService {
  final CollectionReference _categoriesCollection =
      FirebaseFirestore.instance.collection('budget_categories');

  Future<List<BudgetCategory>> getCategories() async {
    QuerySnapshot snapshot = await _categoriesCollection.get();
    return snapshot.docs.map((doc) {
      return BudgetCategory.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<void> addCategory(BudgetCategory category) async {
    await _categoriesCollection.add(category.toMap());
  }

  Future<void> updateCategory(BudgetCategory category) async {
    await _categoriesCollection.doc(category.id).update({
      'name': category.name,
      'budgetedAmount': category.budgetedAmount,
      'spentAmount': category.spentAmount,
      'color': category.color.value,
      'icon': category.icon.codePoint,
      'currencyCode': category.currencyCode,
    });
  }

  Future<void> deleteCategory(String categoryId) async {
    await _categoriesCollection.doc(categoryId).delete();
  }
}
