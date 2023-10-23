import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapme2/custom_widgets/button_3.dart';
import '../custom_widgets/custom_input.dart';
import 'package:mapme2/model/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'login_.dart';

class ForgotPassword extends StatefulWidget {
  final User user;
  const ForgotPassword({Key? key, required this.user}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  var emailController = TextEditingController();
  String email = "";


  void emailCallBackFunction(String data){
    setState(() {
      widget.user.email = data;

    });
  }

  Future forgotPasswordUser() async {
    var url = Uri.parse("https://absurd-hump.000webhostapp.com/edit.php");

    var response = await http.post(url, body: {
      "email" :  emailController.text,
     });

    var data = json.decode(response.body);
    print(data);

    return data;
  }

  bool isValidEmail(String email) {
    // Use a regular expression to validate email format
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Forgot Password'
              ),
            ),
            body:  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                     children: [
                    const SizedBox(
                    height: 30,
                      ),
                    const Icon(
                        Icons.map_rounded,
                        color: Colors.lightGreen,
                      size: 120,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                        "Enter your Email Account to Re-send your Password",
                      style: TextStyle(
                        fontSize: 22,
                        // color: ,
                      ),
                    ),
                       const SizedBox(
                         height: 20,
                       ),
                       CustomInput(
                          hint_text: "Please Enter your E-mail",
                          obcureText: false,
                          callback: emailCallBackFunction
                      ),
                      const SizedBox(
                          height: 20
                      ),
                       Button_3(
                         onTap: () async {

                             print(widget.user.email);

                             if (widget.user.email.isNotEmpty){

                               var data = await widget.user.forgotPasswordUser();
                               print(data);

                               if (!isValidEmail(widget.user.email)) {
                                 Fluttertoast.showToast(
                                   msg: "Invalid email format",
                                   toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.grey,
                                   textColor: Colors.black,
                                   fontSize: 15.0,
                                 );
                               }
                               else if (data == 'Success'){
                                 Fluttertoast.showToast(
                                     msg: "Please Check Your Email Acoount",
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.CENTER,
                                     timeInSecForIosWeb: 1,
                                     backgroundColor: Colors.grey,
                                     textColor: Colors.black,
                                     fontSize: 15.0
                                     );
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Login(user: widget.user,)));
                               }
                               else if(data == "Error") {
                                 Fluttertoast.showToast(
                                     msg: "Please Check Your Email Acoount",
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.CENTER,
                                     timeInSecForIosWeb: 1,
                                     backgroundColor: Colors.grey,
                                     textColor: Colors.black,
                                     fontSize: 15.0
                                 );
                               }
                               else {
                                 Fluttertoast.showToast(
                                     msg: "Please Check Your Email Address",
                                     toastLength: Toast.LENGTH_SHORT,
                                     gravity: ToastGravity.CENTER,
                                     timeInSecForIosWeb: 1,
                                     backgroundColor: Colors.grey,
                                     textColor: Colors.black,
                                     fontSize: 15.0
                                 );
                               }

                             }

                             },
                       ),
              ],
            )
          ),
        )
      )
    );
  }
}
