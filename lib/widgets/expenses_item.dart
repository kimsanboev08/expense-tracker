import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/main.dart';
import 'package:tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.name,
              style: GoogleFonts.publicSans(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                Text(
                  ' - ${expense.paymentMenthod.name.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 110,
                  child: Row(
                    children: [
                      Icon(
                        icons[expense.category],
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        expense.formattedDate,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
