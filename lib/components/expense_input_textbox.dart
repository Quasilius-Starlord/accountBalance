import 'package:account_balance/components/TransactionTypeSelector/transaction_type_selector.dart';
import 'package:account_balance/models/enums/transaction_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ExpenseInputTextbox extends StatefulWidget {
  final Function(int, TransactionType) callback;
  const ExpenseInputTextbox({super.key, required this.callback});
  @override
  State<ExpenseInputTextbox> createState() => _ExpenseInputTextboxState();
}

class _ExpenseInputTextboxState extends State<ExpenseInputTextbox> {
  final textController = TextEditingController();
  TransactionType chosenTransaction = TransactionType.EXPENSE;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
                labelText: 'Enter ${chosenTransaction.name.toLowerCase()}',
                suffixIcon: TransactionTypeSelector(callback: (TransactionType transactionType) {
                  setState(() {
                    chosenTransaction = transactionType;
                  });
                })
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        Expanded(child: IconButton(icon: const Icon(Icons.add), onPressed: () {
          widget.callback(int.parse(textController.value.text), chosenTransaction);
          textController.clear();
        },))
      ],
    );
  }
}
