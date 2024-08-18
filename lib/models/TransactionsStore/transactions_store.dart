import 'package:account_balance/models/transaction.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 2, adapterName: 'TransactionStoreAdapter')
class TransactionStore extends HiveObject{

  List<Transaction> transactions;
  TransactionStore({required this.transactions});

  @override
  String toString() {
    return 'TransactionStore{transactions: $transactions}';
  }
}