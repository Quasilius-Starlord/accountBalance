import 'package:account_balance/Hive/Hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  int salary;
  final Function(int) setSalary;
  Settings({super.key, required this.salary, required this.setSalary});
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final salaryController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    salaryController.text = widget.salary.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            backgroundColor: Colors.lightBlue,
          ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: salaryController,
                decoration: const InputDecoration(
                  hintText: "Salary",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ]
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.only(top: 10),
                child: TextButton(
                    onPressed: (){
                      widget.setSalary(int.parse(salaryController.value.text));
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(Colors.blueAccent),
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      )
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.white),)),
              )
            ],
          ),
        ),
      )
    );
  }
}
