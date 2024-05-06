import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ExpenseInputTextbox extends StatefulWidget {
  final Function(int) callback;
  const ExpenseInputTextbox({super.key, required this.callback});

  @override
  State<ExpenseInputTextbox> createState() => _ExpenseInputTextboxState();
}

class _ExpenseInputTextboxState extends State<ExpenseInputTextbox> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
            labelText: 'Enter Expense',
            suffixIcon: IconButton(icon: const Icon(Icons.add),
                onPressed: () {
                  if(textController.text.isEmpty) {
                    return;
                  }
                  if (kDebugMode) {
                    print('Add button pressed');
                  }
                  FocusScope.of(context).unfocus();
                  widget.callback(int.parse(textController.text));
                  textController.clear();
                })
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
