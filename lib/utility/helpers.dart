import 'package:account_balance/models/enums/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatNumber(int num){
  return NumberFormat("#,##0.00", "en_US").format(num);
}

Color getColorForTransactionType(TransactionType transactionType){
  switch (transactionType){
    case TransactionType.EXPENSE:
      return Colors.blue;
    case TransactionType.INVESTMENT:
      return Colors.green;
    case TransactionType.TAX:
      return Colors.redAccent;
      break;
  }
}