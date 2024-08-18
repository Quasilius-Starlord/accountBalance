import 'package:account_balance/models/enums/transaction_type.dart';
import 'package:flutter/material.dart';

class TransactionTypeRenderer extends StatelessWidget {
  TransactionType transactionType;
  TransactionTypeRenderer({super.key, required this.transactionType});

  Color getColorForTransactionType(TransactionType transactionType){
    switch (transactionType){
      case TransactionType.EXPENSE:
        return Colors.blue;
      case TransactionType.INVESTMENT:
        return Colors.green;
      case TransactionType.TAX:
        return Colors.blueGrey;
      break;
    }
  }
  @override
  Widget build(BuildContext context) {
    final Color color = getColorForTransactionType(transactionType);
    return Text(transactionType.name.toLowerCase(), style: TextStyle(
      color: color
    ),);
  }
}
