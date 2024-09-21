import 'package:account_balance/components/expense_input_textbox.dart';
import 'package:account_balance/models/enums/transaction_type.dart';
import 'package:flutter/material.dart';

class BottomSheetTest extends StatelessWidget {
  Function(int, TransactionType) callback;

  BottomSheetTest({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: <Widget>[
            Text('Add Expense', style: TextStyle(fontSize: 25)),

            // ExpenseInputTextbox(callback: (int expense) {
            //   callback(expense);
            //   Navigator.pop(context);
            //   FocusScope.of(context).unfocus();
            // })
          ],
        ),
      ),
    );
  }
}
