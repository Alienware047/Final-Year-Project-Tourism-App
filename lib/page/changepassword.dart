import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../component/mymapwiget2.dart';
import '../custom_widgets/button_4.dart';
import '../custom_widgets/custom_input.dart';
import '../model/user.dart';
import 'login_.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key, required this.user}) : super(key: key);
final User user;
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String email = "";
  String password = "";

  void passwordCallBackFunction(String data){
    setState(() {
      widget.user.password = data;
    });
  }

  void emailCallBackFunction(String data){
    setState(() {
      widget.user.email = data;

    });
  }

  Future changePasswordUser() async {
    var url = Uri.parse("https://absurd-hump.000webhostapp.com/change.php");

    var response = await http.post(url, body: {
      "email" : emailController.text,
      "password" : passwordController.text,
    });

    var data = json.decode(response.body);
    print(data);

    return data;

  }


  bool isStrongPassword(String password) {
    // Check if the password contains both numbers and characters
    final hasNumber = password.contains(RegExp(r'\d'));
    final hasCharacter = password.contains(RegExp(r'[a-zA-Z]'));

    // Check if the password length is at least 8 characters
    final isLongEnough = password.length >= 8;

    return hasNumber && hasCharacter && isLongEnough;
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
                  'Change Password'
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
                        "Please Enter your New Password to Change Password",
                        style: TextStyle(
                          fontSize: 22,
                          // color: ,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomInput(
                        hint_text: "Please Enter your Email Account",
                        obcureText: false,
                        callback: emailCallBackFunction,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInput(
                        hint_text: "Please Enter your New Password",
                        obcureText: true,
                        callback: passwordCallBackFunction,
                      ),
                      const SizedBox(
                          height: 20
                      ),
                      Button_4(
                        onTap: () async {

                          print(widget.user.email);
                          print(widget.user.password);

                          if (widget.user.password.isNotEmpty && widget.user.email.isNotEmpty){
                            print(widget.user.email);
                            print(widget.user.password);

                            var data = await widget.user.changePasswordUser();
                            print(data);

                            if (!isStrongPassword(widget.user.password) && !isValidEmail(widget.user.email)) {
                              Fluttertoast.showToast(
                                msg: "Invalid email or Password format",
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
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMapWidget2(user: widget.user, touristSites:touristSites ,)));
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
                                  msg: "Please Try Again",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.black,
                                  fontSize: 15.0
                              );
                            }

                          }
                          else {
                            Fluttertoast.showToast(
                                msg: "Please Fill All The Textbox Above",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.black,
                                fontSize: 15.0
                            );
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
