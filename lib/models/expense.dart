import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid(); // make a unique id
final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  work,
  home,
  leisure,
}

enum Payment {
  cash,
  visa,
  discover,
  amex,
  payPal,
}

const icons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff_rounded,
  Category.work: Icons.work,
  Category.home: Icons.home,
  Category.leisure: Icons.movie,
};

class Expense {
  Expense({
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
    required this.paymentMenthod,
  }) : id = uuid.v4();

  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Category category;
  final Payment paymentMenthod;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpensePackage {
  const ExpensePackage({
    required this.category,
    required this.expenses,
  });

  ExpensePackage.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((oneExpense) => oneExpense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
