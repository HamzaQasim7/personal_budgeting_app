import 'package:flutter/material.dart';
import 'package:intern_test/provider/budget_provider.dart';
import 'package:intern_test/screens/edit_screen/add_edit_budget_screen.dart';
import 'package:provider/provider.dart';

import '../../model/budget_category.dart';
import '../../widgets/budget_pie_chart.dart';
import '../../widgets/category_list_items.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

final BudgetProvider budgetProvider = BudgetProvider();

class _DashboardState extends State<Dashboard> {
  late Future<void> _fetchFuture;

  @override
  void initState() {
    super.initState();
    _fetchFuture = _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    await Provider.of<BudgetProvider>(context, listen: false).fetchCategories();
  }

  BudgetCategory category = BudgetCategory(id: '', name: '', budgetedAmount: 0);
  final totalBudget = budgetProvider.totalBudget.toStringAsFixed(1);
  final totalSpent = budgetProvider.totalSpent.toStringAsFixed(1);
  final currencyCode = budgetProvider.defaultCurrencyCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshCategories,
        child: FutureBuilder(
          future: _fetchFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Consumer<BudgetProvider>(
                builder: (context, budgetProvider, child) {
                  if (budgetProvider.categories.isEmpty) {
                    return const Center(
                        child: Text('No categories found. Add one!'));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 12),
                        child: _buildHeader(),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Budget',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .apply(fontSizeFactor: 0.7),
                                ),
                                Text(
                                  '${category.currencyCode} ${budgetProvider.totalBudget.toStringAsFixed(1)}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  'Total Spent',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .apply(fontSizeFactor: 0.7),
                                ),
                                Text(
                                  "${category.currencyCode} ${budgetProvider.totalSpent.toStringAsFixed(1)}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 150,
                              child: BudgetPieChart(
                                  categories: budgetProvider.categories),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'All categories',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(fontWeightDelta: 2),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: budgetProvider.categories.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            final category = budgetProvider.categories[index];
                            return Dismissible(
                              key: Key(category.id),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                budgetProvider.deleteCategory(category.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('${category.name} deleted')),
                                );
                              },
                              child: CategoryListItem(category: category),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 12),
      child: Text(
        'Dashboard',
        style:
            Theme.of(context).textTheme.titleLarge!.apply(fontSizeFactor: 0.8),
      ),
    );
  }

  Future<void> _refreshCategories() async {
    setState(() {
      _fetchFuture = _fetchCategories();
    });
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AddEditCategoryScreen()),
        );
        _refreshCategories();
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
