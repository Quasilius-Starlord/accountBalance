
import 'package:account_balance/components/TransactionTypeRenderer/transaction_type_renderer.dart';
import 'package:account_balance/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:account_balance/models/transaction.dart';

import 'package:account_balance/utility/helpers.dart';

class TransactionList extends StatefulWidget {
  List<Transaction> transactionList;
  final Function(String) deleteTransaction;
  TransactionList({super.key, required this.transactionList, required this.deleteTransaction});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    if (widget.transactionList.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 0),
        child:
            const Text('No transactions yet', style: TextStyle(fontSize: 20)),
      );
    }
    return ListView.builder(
        itemCount: widget.transactionList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            elevation: 0.7,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.white,
            margin: const EdgeInsetsDirectional.symmetric(
                vertical: 10, horizontal: 5),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(formatNumber(widget.transactionList.elementAt(index).amount)),
                    Row(
                      children: <Widget>[
                        TransactionTypeRenderer(
                            transactionType: widget.transactionList
                                .elementAt(index)
                                .transactionType),
                        PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem<int>(
                                    value: 0, child: Text('Delete'))
                              ];
                            },
                            onSelected: (value) {
                              if(value == 0){
                                widget.deleteTransaction(widget.transactionList.elementAt(index).guid);
                              }
                            },
                            position: PopupMenuPosition.under)
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
