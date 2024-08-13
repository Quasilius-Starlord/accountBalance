import 'package:account_balance/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:account_balance/models/transaction.dart';

import 'package:account_balance/utility/helpers.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactionList;
  TransactionList({super.key, required this.transactionList});

  @override
  Widget build(BuildContext context) {
    if(transactionList.isEmpty){
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 0),
        child: const Text('No transactions yet', style: TextStyle(fontSize: 20)),
      );
    }
    return ListView.builder(
        itemCount: transactionList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Text(formatNumber(transactionList.elementAt(index).amount));
        }
    );
  }
}

