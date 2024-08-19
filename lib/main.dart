import 'dart:io';

import 'package:account_balance/Configuration/http_overites.dart';
import 'package:account_balance/Hive/Hive.dart';
import 'package:account_balance/pages/LoginPage/login_page.dart';
import 'package:account_balance/pages/Settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:account_balance/models/transaction.dart';
import 'package:account_balance/models/enums/transaction_type.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'utility/helpers.dart';
import 'utility/constants.dart' as constants;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'components/bottom_sheet_test.dart';
import 'components/expense_input_textbox.dart';
import 'package:account_balance/components/TransactionList/transaction_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final HiveManager hiveManager = HiveManager();
  await hiveManager.hiveInitializer();
  runApp(
    const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      restorationScopeId: constants.RESTORATION_SCOPE_ID,
    )
  );
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HiveManager hiveManager = HiveManager();
  int balance = HiveManager().getSalary();
  String? userCredential=HiveManager().getUserCredentials();
  _HomeState(){
    hiveManager.getAllTransactions();
    debugPrint("$balance $userCredential balance salary");
  }
  List<Transaction> transactionsList = HiveManager().getAllTransactions();
  void addExpense(int expense) {
    List<Transaction> transactions = hiveManager.putTransaction(
        Transaction(
          expense,
          TransactionType.EXPENSE,
          DateTime.now(),
          Guid.generate().value
        ));
    setState(() {
      balance = balance-expense;
      transactionsList = transactions;
    });
    hiveManager.setSalary(balance);
  }
  void deleteTransaction(String guid){
    Transaction transaction = transactionsList.firstWhere((element) => element.guid == guid);
    transactionsList.remove(transaction);
      hiveManager.deleteTransactionAt(guid);
    setState(() {
      balance = balance+transaction.amount;
      transactionsList = transactionsList;
    });
    hiveManager.setSalary(balance);
  }
  void updateCredential(String token){
    hiveManager.setUserCredentials(token);
    setState(() {
      userCredential= token;
    });
  }
  void clearCredential(){
    setState(() {
      userCredential= null;
    });
  }
  void clearTransactions(){
    // hiveManager.getSalary()
    setState(() {
      balance = 40000;
      transactionsList= [];
    });
  }
  void setBalance(int salary){
    hiveManager.setSalary(salary);
    setState(() {
      balance = salary;
    });
  }
  @override
  Widget build(BuildContext context) {
    final List<Transaction> renderTransactionList = List.from(transactionsList.reversed);
    if(userCredential == null){
      return Scaffold(
        body: SafeArea(
          child: LoginPage(updateCredential: updateCredential),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Manage Balance'),
          centerTitle: false,
          backgroundColor: Colors.lightBlue,
          actions: <Widget>[
            IconButton(onPressed: () {
              hiveManager.purgeHive();
              clearCredential();
              clearTransactions();
            }, icon: const Icon(Icons.logout)),
            PopupMenuButton(icon: const Icon(Icons.more_vert),itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Setting"),
                  ),
              ];
            }, padding: const EdgeInsetsDirectional.symmetric(horizontal: 10), onSelected: (value) {
              if(value == 0){
                //   goto setting
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Settings(salary: balance, setSalary: setBalance,);
                }));
              }
            })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Remaining balance: ${formatNumber(balance)}', style: const TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.w800
              )),
              ExpenseInputTextbox(
                callback: addExpense,
              ),
              TransactionList(transactionList: renderTransactionList, deleteTransaction: deleteTransaction)
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(context: context, builder: (ctx) {
              return BottomSheetTest(
                callback: addExpense,
              );
            });
          },
          backgroundColor: Colors.lightBlue,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );
    }
  }
}