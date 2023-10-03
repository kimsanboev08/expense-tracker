import 'package:flutter/material.dart';
import 'package:tracker/models/expense.dart';
import 'package:tracker/widgets/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.myList,
    required this.onRemoveExpense,
  });

  final List<Expense> myList;
  final void Function(Expense removedExpense) onRemoveExpense;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: myList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(myList[index]),
        onDismissed: (direction) {
          onRemoveExpense(myList[index]);
        },
        child: ExpenseItem(myList[index]),
      ),
    );
  }
}
