import 'package:account_balance/components/expense_input_textbox.dart';
import 'package:flutter/material.dart';

class BottomSheetTest extends StatelessWidget {
  Function(int) callback;

  BottomSheetTest({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: <Widget>[
            const Text('Add Expense', style: TextStyle(fontSize: 25)),
            ExpenseInputTextbox(callback: (int expense) {
              callback(expense);
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            })
          ],
        ),
      ),
    );
  }
}
