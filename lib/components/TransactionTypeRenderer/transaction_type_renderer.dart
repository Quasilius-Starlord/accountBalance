import 'package:account_balance/models/enums/transaction_type.dart';
import 'package:account_balance/utility/helpers.dart';
import 'package:flutter/material.dart';

class TransactionTypeRenderer extends StatelessWidget {
  TransactionType transactionType;
  TransactionTypeRenderer({super.key, required this.transactionType});
  @override
  Widget build(BuildContext context) {
    final Color color = getColorForTransactionType(transactionType);
    return Text(transactionType.name.toLowerCase(), style: TextStyle(
      color: color
    ),);
  }
}
