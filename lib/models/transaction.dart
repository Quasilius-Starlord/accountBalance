import 'package:account_balance/models/enums/transaction_type.dart';
import 'package:hive/hive.dart';
part 'transaction.g.dart';
@HiveType(typeId: 0, adapterName: "TransactionAdapter")
class Transaction extends HiveObject{
  @HiveField(0)
  final int amount;
  @HiveField(1)
  final DateTime transactionDate;
  @HiveField(2)
  final TransactionType transactionType;
  Transaction(this.amount, this.transactionType, this.transactionDate);
}