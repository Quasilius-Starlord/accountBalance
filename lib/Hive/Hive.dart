import 'package:account_balance/models/enums/transaction_type.dart';
import 'package:account_balance/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:account_balance/utility/constants.dart' as constants;

class HiveManager{
  late final Box<dynamic> expenseBox;
  late final Box<Transaction> transactionBox;
  late final Box<dynamic> userBox;
  Future<void> hiveInitializer() async {
    WidgetsFlutterBinding.ensureInitialized();
    final path = await path_provider.getApplicationDocumentsDirectory();
    await Hive.initFlutter();
    Hive.init(path.path);
    Hive.registerAdapter(TransactionAdapter());
    Hive.registerAdapter(TransactionTypeAdapter());
    if(!Hive.isBoxOpen(constants.EXPENSES_BOX_NAME)){
      await Hive.openBox(constants.EXPENSES_BOX_NAME);
    }
    if(!Hive.isBoxOpen(constants.USER_BOX_NAME)){
      await Hive.openBox(constants.USER_BOX_NAME);
    }
    if(!Hive.isBoxOpen(constants.TRANSACTION_BOX_NAME)){
      await Hive.openBox<Transaction>(constants.TRANSACTION_BOX_NAME);
    }
    expenseBox = Hive.box(constants.EXPENSES_BOX_NAME);
    transactionBox = Hive.box<Transaction>(constants.TRANSACTION_BOX_NAME);
    userBox = Hive.box(constants.USER_BOX_NAME);
    if(expenseBox.get(constants.BALANCE_KEY) == null) {
      expenseBox.put(constants.BALANCE_KEY, 40000);
    }
  }
  int getSalary(){
    return expenseBox.get(constants.BALANCE_KEY) ?? 40000;
  }
  void setSalary(int salary){
    expenseBox.put(constants.BALANCE_KEY, salary);
  }
  String? getUserCredentials(){
    return userBox.get(constants.CREDENTIAL_KEY, defaultValue: null);
  }
  void setUserCredentials(String? jsonToken){
    userBox.put(constants.CREDENTIAL_KEY, jsonToken);
  }

  void purgeHive(){
    userBox.clear();
    expenseBox.clear();
    transactionBox.clear();
  }

  List<Transaction> getAllTransactions(){
    if(transactionBox.values.isEmpty){
      return [].cast<Transaction>();
    }
    return transactionBox.values.toList();
  }
  List<Transaction> putTransaction(Transaction transaction){
    List<Transaction> transactions = getAllTransactions();
    transactions.add(transaction);
    transactionBox.put(transaction.guid, transaction);
    debugPrint("${transactions.toString()} Updated transactions to be put in box");
    return transactions;
  }

  void deleteTransactionAt(String guid){
    transactionBox.delete(guid);
  }

  static final HiveManager _instance = HiveManager._privateConstructor();
  HiveManager._privateConstructor(){
    debugPrint("Instance of hive");
  }
  factory HiveManager() {
    return _instance;
  }
  static const String data="private data";
}