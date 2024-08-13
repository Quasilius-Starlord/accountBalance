// import 'dart:convert';
//
// import 'package:account_balance/models/user.dart';
// import 'package:account_balance/utility/networkConfiguration/apiConfiguration.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SignupPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final usernameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   bool isDisabled = false;
//   void handleFormSubmit() async {
//     debugPrint(
//         jsonEncode(
//             <String, String>{
//               "username": usernameController.value.text,
//               "password": passwordController.value.text
//             }
//         )
//     );
//     try{
//       final response = await http.post(
//           Uri.parse("${ApiConfiguration.endPoint}${ApiConfiguration.login}"),
//           headers: <String, String>{
//             HttpConstants.contentType: HttpConstants.applicationJson
//           },
//           body: jsonEncode(
//               <String, String>{
//                 "username": usernameController.value.text,
//                 "password": passwordController.value.text
//               }
//           )
//       );
//       debugPrint(Uri.parse("${ApiConfiguration.endPoint}${ApiConfiguration.login}").toString());
//       debugPrint(response.statusCode.toString());
//       debugPrint(response.body);
//       debugPrint(response.headers[HttpConstants.authorization]);
//
//       User user = User.fromMap(jsonDecode(response.body));
//       // debugPrint(User.fromMap(jsonDecode(response.body)).toString());
//       debugPrint(user.toString());
//     }catch(e){
//       debugPrint("Error $e");
//       e.toString();
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//       child: Column(
//         children: <Widget>[
//           const SizedBox(
//             width: double.infinity,
//             child: Text(
//               "Account Balance",
//               style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold
//               ),
//             ),
//           ),
//           TextField(
//             decoration: const InputDecoration(
//                 labelText: "Email",
//                 hintText: "Ex. email@email.com"
//             ),
//             controller: emailController,
//           ),
//           TextField(
//             decoration: const InputDecoration(
//                 labelText: "Username",
//                 hintText: "Ex. Arya"
//             ),
//             controller: usernameController,
//           ),
//           TextField(
//             decoration: const InputDecoration(
//               labelText: "Password",
//             ),
//             controller: passwordController,
//             obscureText: true,
//           ),
//           TextField(
//             decoration: const InputDecoration(
//               labelText: "Confirm Password",
//             ),
//             controller: confirmPasswordController,
//             obscureText: true,
//           ),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
//             child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   isDisabled = true;
//                 });
//                 debugPrint("Submit form");
//                 handleFormSubmit();
//               },
//               style: const ButtonStyle(
//                 backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueAccent),
//               ),
//               child: const Text(
//                 "Submit",
//                 style: TextStyle(
//                     color: Colors.white
//                 ),
//               ),
//
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
