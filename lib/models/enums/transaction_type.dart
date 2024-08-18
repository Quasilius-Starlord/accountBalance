import 'package:hive/hive.dart';

part 'transaction_type.g.dart';
@HiveType(typeId: 1, adapterName: 'TransactionTypeAdapter')
enum TransactionType {
  @HiveField(0)
  TAX,
  @HiveField(1)
  INVESTMENT,
  @HiveField(2)
  EXPENSE
}