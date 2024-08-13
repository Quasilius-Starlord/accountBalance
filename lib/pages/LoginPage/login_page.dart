import 'dart:convert';

import 'package:account_balance/models/user.dart';
import 'package:account_balance/utility/networkConfiguration/apiConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:account_balance/utility/constants.dart' as constants;
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  final Function(String) updateCredential;
  const LoginPage({super.key, required this.updateCredential});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isDisabled = false;
  bool viewPassword = false;

  void handleFormSubmit(BuildContext context) async {
    debugPrint(
        jsonEncode(
            <String, String>{
              "username": usernameController.value.text,
              "password": passwordController.value.text
            }
        )
    );
    try{
      final response = await http.post(
        Uri.parse("${ApiConfiguration.endPoint}${ApiConfiguration.login}"),
        headers: <String, String>{
          HttpConstants.contentType: HttpConstants.applicationJson
        },
        body: jsonEncode(
            <String, String>{
              "username": usernameController.value.text.trim(),
              "password": passwordController.value.text.trim()
            }
        )
      );
      debugPrint(Uri.parse("${ApiConfiguration.endPoint}${ApiConfiguration.login}").toString());
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      if(response.statusCode == 202){
        debugPrint("login successful");
        User user = User.fromMap(jsonDecode(response.body));
        debugPrint(response.headers[HttpConstants.authorization]);
        String jsonToken = response.headers[HttpConstants.authorization].toString();
        // debugPrint(User.fromMap(jsonDecode(response.body)).toString());
        debugPrint(user.toString());
        widget.updateCredential(jsonToken);
      } else if(response.statusCode == 400 || response.statusCode == 401){
        final errorResponse = jsonDecode(response.body);
        for(String key in errorResponse.keys){
          String? error = errorResponse[key];
          debugPrint(error.toString());
          if(error!=null && error.isNotEmpty){
            final snack = SnackBar(content: Text(error));
            ScaffoldMessenger.of(context).showSnackBar(snack);
          }
        }
      }
    }catch(e){
      debugPrint("Error $e");
      final snack = SnackBar(content: Text("Network error encountered"));
      ScaffoldMessenger.of(context).showSnackBar(snack);
      e.toString();
    } finally {
      setState(() {
        isDisabled = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
            child: Text(
                "Account Balance",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Username",
              hintText: "Ex. Arya"
            ),
            controller: usernameController,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Password",
              suffixIcon: IconButton(onPressed: () {
                setState(() {
                  viewPassword=!viewPassword;
                });
              }, icon: Icon(viewPassword ? Icons.visibility : Icons.visibility_off))
            ),
            controller: passwordController,
            obscureText: !viewPassword,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  isDisabled = true;
                });
                debugPrint("Submit form");
                Future.delayed(const Duration(milliseconds: 1000), () {handleFormSubmit(context);});
            },
              style: ButtonStyle(
                backgroundColor: (isDisabled ? const MaterialStatePropertyAll<Color>(Colors.black12) : const MaterialStatePropertyAll<Color>(Colors.blueAccent)),
              ),
              child: const Text(
                  "Submit",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

            ),
          )
        ],
      ),
    );
  }
}
