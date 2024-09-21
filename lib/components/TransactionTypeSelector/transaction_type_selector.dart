import 'package:account_balance/models/enums/transaction_type.dart';
import 'package:account_balance/utility/helpers.dart';
import 'package:flutter/material.dart';

class TransactionTypeSelector extends StatefulWidget {
  Function(TransactionType transactionType)? callback;
  TransactionTypeSelector({super.key, this.callback});
  @override
  State<TransactionTypeSelector> createState() => _TransactionTypeSelectorState();
}

class _TransactionTypeSelectorState extends State<TransactionTypeSelector> {
  late TransactionType selectedTransactionType;
  _TransactionTypeSelectorState(){
    selectedTransactionType = TransactionType.EXPENSE;
  }
  void changeTransactionType(){
    const allTransactionType = [
      TransactionType.EXPENSE,
      TransactionType.INVESTMENT,
      TransactionType.TAX,
    ];
    int transactionTypeCount=allTransactionType.length;
    int currentTransactionTypeIndex = allTransactionType.indexOf(selectedTransactionType);
    setState(() {
      selectedTransactionType = allTransactionType[(currentTransactionTypeIndex+1) % transactionTypeCount];
    });
    widget.callback!(selectedTransactionType);
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: changeTransactionType, icon: Icon(Icons.circle_rounded, size: 40, color: getColorForTransactionType(selectedTransactionType)));
  }
}
