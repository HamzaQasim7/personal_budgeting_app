import 'package:flutter/material.dart';
import 'package:intern_test/provider/budget_provider.dart';
import 'package:intern_test/screens/edit_screen/add_edit_budget_screen.dart';
import 'package:intern_test/screens/new_screen.dart';
import 'package:provider/provider.dart';

import '../../model/budget_category.dart';
import '../../widgets/category_list_items.dart';
import 'data_over_view_screen.dart';

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

  List<AccountCardData> accountCards = List.generate(
    3,
    (index) => AccountCardData(
      cardName: 'HBL',
      holderName: 'Hamza',
      cardNumber: '022799723780',
      backgroundImagePath: 'assets/images/networking.png',
      cardColor: Colors.transparent,
      cardType: 'Credit card',
      expiryDate: '07/2023',
    ),
  );

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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi!, Good Evening'),
                            Text(
                              'Hamza',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AccountCardsCarousel(cards: accountCards),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            SmallCardWidget(
                              title: 'Income',
                              amount:
                                  '${category.currencyCode} ${budgetProvider.totalBudget.toStringAsFixed(1)}',
                              cardColor: Colors.green.shade200,
                            ),
                            const SizedBox(width: 8),
                            SmallCardWidget(
                              title: 'Expense',
                              cardColor: Colors.red.shade200,
                              amount:
                                  "${category.currencyCode} ${budgetProvider.totalSpent.toStringAsFixed(1)}",
                            ),
                          ],
                        ),
                        // const SizedBox(height: 20),
                        // Padding(
                        //   padding: const EdgeInsets.all(16.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       SizedBox(
                        //         width: 150,
                        //         child: BudgetPieChart(
                        //             categories: budgetProvider.categories),
                        //       ),
                        //       const SizedBox(),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'All categories',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(fontWeightDelta: 2),
                              ),
                              TextButton(
                                  onPressed: () {}, child: const Text('Show'))
                            ],
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
                    ),
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
          MaterialPageRoute(builder: (context) => const OverviewScreen()),
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

class SmallCardWidget extends StatelessWidget {
  const SmallCardWidget({
    super.key,
    required this.amount,
    required this.cardColor,
    required this.title,
  });

  final String amount, title;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: MediaQuery.sizeOf(context).width * 0.4,
      height: MediaQuery.sizeOf(context).height * 0.08,
      decoration: BoxDecoration(
          color: cardColor, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              amount,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black54),
            ),
          ],
        ),
      ),
    ));
  }
}
