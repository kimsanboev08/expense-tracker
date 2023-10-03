import 'package:flutter/material.dart';
import 'package:tracker/main.dart';
import 'package:tracker/models/expense.dart';
import 'package:tracker/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpensePackage> get packages {
    List<ExpensePackage> allPackages = [];
    for (final expenseCategory in Category.values) {
      allPackages.add(ExpensePackage.forCategory(expenses, expenseCategory));
    }
    return allPackages;
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final package in packages) {
      if (package.totalExpenses > maxTotalExpense) {
        maxTotalExpense = package.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: 10,
      ),
      padding: const EdgeInsets.only(
        top: 10,
        left: 8,
        right: 8,
        bottom: 16,
      ),
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final package in packages)
                  ChartBar(
                    fill: package.totalExpenses == 0
                        ? 0
                        : package.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: packages
                .map(
                  (package) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        icons[package.category],
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
