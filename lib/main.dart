import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'utility/helpers.dart';
import 'utility/constants.dart' as constants;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'components/bottom_sheet_test.dart';
import 'components/expense_input_textbox.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = await path_provider.getApplicationDocumentsDirectory();
  print('path${path != null ? path.path : ''}');
  Hive.init(path.path);
  // Hive.deleteFromDisk();
  final expenseBox = await Hive.openBox(constants.EXPENSES_BOX_NAME);
  if(expenseBox.get(constants.BALANCE_KEY) == null) {
    expenseBox.put(constants.BALANCE_KEY, 40000);
  }
  if(expenseBox.get(constants.EXPENSE_KEY) == null) {
    expenseBox.put(constants.EXPENSE_KEY, <int>[]);
  }
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
  final expenseBox = Hive.box(constants.EXPENSES_BOX_NAME);
  int balance=Hive.box(constants.EXPENSES_BOX_NAME).get(constants.BALANCE_KEY, defaultValue: 20000);
  List<int> expensesList = Hive.box(constants.EXPENSES_BOX_NAME).get(constants.EXPENSE_KEY);
  // List<int> expensesList = [];
  void addExpense(int expense) {
    expensesList.add(expense);
    setState(() {
      balance = balance-expense;
      expensesList = expensesList;
    });
    expenseBox.put(constants.BALANCE_KEY, balance);
    expenseBox.put(constants.EXPENSE_KEY, expensesList);
  }
  @override
  Widget build(BuildContext context) {
    final List<int> renderExpenseList = List.from(expensesList.reversed);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Balance'),
        centerTitle: false,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
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
          ExpensesList(expensesList: renderExpenseList)
        ],
      ),
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

class ExpensesList extends StatelessWidget {
  final List<int> expensesList;
  const ExpensesList({super.key, required this.expensesList});

  @override
  Widget build(BuildContext context) {
    if(expensesList.isEmpty){
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 0),
          child: const Text('No expenses has been added', style: TextStyle(fontSize: 20)),

      );
    }
    return ListView.builder(
      itemCount: expensesList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Text(formatNumber(expensesList.elementAt(index)));
      }
    );
  }
}
