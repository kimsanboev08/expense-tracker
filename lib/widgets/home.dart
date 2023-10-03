import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/main.dart';
import 'package:tracker/models/expense.dart';
import 'package:tracker/widgets/add_expense.dart';
import 'package:tracker/widgets/chart.dart';
import 'package:tracker/widgets/expenses_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Home> {
  final List<Expense> _spent = [
    Expense(
      name: 'Walmart',
      amount: 20.95,
      date: DateTime.now(),
      category: Category.food,
      paymentMenthod: Payment.amex,
    ),
    Expense(
      name: 'Oppenheimer',
      amount: 12.83,
      date: DateTime.now(),
      category: Category.leisure,
      paymentMenthod: Payment.cash,
    ),
  ];

  void _add() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.8,
        child: AddExpense(saveAll: newExpense),
      ),
    );
  }

  void newExpense(Expense a) {
    setState(() {
      _spent.add(a);
    });
  }

  void _remove(Expense removedExpense) {
    final int removedIndex = _spent.indexOf(removedExpense);
    setState(() {
      _spent.remove(removedExpense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Removed"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _spent.insert(removedIndex, removedExpense);
            });
          },
        ),
      ),
    );
  }

  double get total {
    double sum = 0;

    for (final expense in _spent) {
      sum += expense.amount;
    }

    return sum;
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text("No Expenses Listed"),
    );

    if (_spent.isNotEmpty) {
      mainContent = ExpensesList(
        myList: _spent,
        onRemoveExpense: _remove,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        titleSpacing: 10,
        title: Text(
          'Expense Tracker',
          style: GoogleFonts.publicSans(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _add,
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              const Color.fromARGB(255, 207, 234, 255),
            ],
            stops: const [0.55, 0.5],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: horizontalMargin,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: GoogleFonts.publicSans(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 11.5,
                      left: 5,
                    ),
                    child: Text(
                      '- Total',
                      style: GoogleFonts.publicSans(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Chart(expenses: _spent),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: mainContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
