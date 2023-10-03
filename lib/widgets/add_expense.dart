import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({
    super.key,
    required this.saveAll,
  });

  final void Function(Expense newExpense) saveAll;

  @override
  State<AddExpense> createState() {
    return _AddExpense();
  }
}

class _AddExpense extends State<AddExpense> {
  // Variables
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;
  Payment _selectedPayment = Payment.visa;

  //animationController
  AnimationController? animationController;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 10, 1, 1);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void submit() {
    // Check values one by one
    final amount = double.tryParse(_amountController.text);
    final invalidAmount = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null ||
        _selectedCategory.name.trim().isEmpty ||
        _selectedPayment.name.trim().isEmpty) {
      // Generate an error Message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please fill in all the required fields.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Try Again'))
          ],
        ),
      );
      return;
    }
    widget.saveAll(
      Expense(
        name: _titleController.text.toUpperCase(),
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory,
        paymentMenthod: _selectedPayment,
      ),
    );
    Navigator.pop(context); // close the pop up after 'Save'
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text(
                'New Expense',
                style: GoogleFonts.publicSans(),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 177,
                child: TextField(
                  controller: _amountController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$',
                    label: Text(
                      'Amount',
                      style: GoogleFonts.publicSans(),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _datePicker,
                child: Row(
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : formatter.format(_selectedDate!),
                      style: GoogleFonts.publicSans(),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Icon(
                      Icons.calendar_month,
                      color: Color.fromARGB(255, 42, 113, 237),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 177,
                child: DropDownTextField(
                  enableSearch: false,
                  textFieldDecoration: InputDecoration(
                    label: Text(
                      'Payment Method',
                      style: GoogleFonts.publicSans(),
                    ),
                  ),
                  dropDownItemCount: 5,
                  dropDownList: Payment.values
                      .map(
                        (payment) => DropDownValueModel(
                          name: payment.name.toUpperCase(),
                          value: payment.name,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    String pName = '';
                    int l = 0;
                    int length = Payment.values.length;
                    for (int i = 0; i < length; i++) {
                      Payment current = Payment.values[i];
                      pName = '${current.name.toUpperCase()}, ${current.name}';
                      l = value.toString().length;
                      if (pName == value.toString().substring(19, l - 1)) {
                        _selectedPayment = current;
                      }
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 168,
                child: DropDownTextField(
                  enableSearch: true,
                  searchAutofocus: false,
                  searchShowCursor: false,
                  searchKeyboardType: TextInputType.text,
                  textFieldDecoration: InputDecoration(
                    label: Text(
                      'Select Category',
                      style: GoogleFonts.publicSans(),
                    ),
                  ),
                  searchDecoration: const InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    alignLabelWithHint: false,
                    hintText: 'Search',
                  ),
                  dropDownItemCount: 5,
                  dropDownList: Category.values
                      .map(
                        (category) => DropDownValueModel(
                          name: category.name.toUpperCase(),
                          value: category.name,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    String cName = '';
                    int l = 0;
                    int length = Category.values.length;
                    for (int i = 0; i < length; i++) {
                      Category current = Category.values[i];
                      cName = '${current.name.toUpperCase()}, ${current.name}';
                      l = value.toString().length;
                      if (cName == value.toString().substring(19, l - 1)) {
                        _selectedCategory = current;
                      }
                    }
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 28, 153, 255),
                ),
                onPressed: submit,
                child: const Text('Save'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 28, 153, 255),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 28, 153, 255),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
