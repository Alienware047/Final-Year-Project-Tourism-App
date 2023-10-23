import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapme2/page/homepage.dart';
import 'package:mapme2/page/login_.dart';
import '../custom_widgets/custom_input.dart';
import '../model/user.dart';
import '/custom_widgets/myTextfield.dart';
import '/custom_widgets/button_2.dart';
import '/custom_widgets/myTextfield2.dart';
 import '/custom_widgets/myTextfield3.dart';




class Register extends StatefulWidget {
  final User user;
  const Register({Key? key, required this.user}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var fullNameControlller = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();








  void nameCallBackFunction(String data){
    setState(() {
      widget.user.name = data;
    });
  }

  void emailCallBackFunction(String data){
    setState(() {
      widget.user.email = data;
    });
  }

  void passwordCallBackFunction(String data){
    setState(() {
      widget.user.password = data;
    });
  }

  void usernameCallBackFunction(String data){
    setState(() {
      widget.user.username = data;
    });
  }

  bool isValidEmail(String email) {
    // Use a regular expression to validate email format
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
  bool isStrongPassword(String password) {
    // Check if the password contains both numbers and characters
    final hasNumber = password.contains(RegExp(r'\d'));
    final hasCharacter = password.contains(RegExp(r'[a-zA-Z]'));

    // Check if the password length is at least 8 characters
    final isLongEnough = password.length >= 8;

    return hasNumber && hasCharacter && isLongEnough;
  }

  Future registerUser() async {
    var url = Uri.parse("https://absurd-hump.000webhostapp.com/register.php");

    var response = await http.post(url, body: {
      "fullname": fullNameControlller.text,
      "email" :  emailController.text,
      "username": usernameController.text,
      "password": passwordController.text,
    });

    var data = json.decode(response.body);
    print(data);

    if (!isStrongPassword(passwordController.text)) {
      Fluttertoast.showToast(
        msg: "Password must contain at least 8 characters including numbers and characters",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 15.0,
      );
    }
    else if (!isValidEmail(emailController.text)) {
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
    else if (data == "Success") {
      Fluttertoast.showToast(
        msg: "Registration Complete",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 15.0,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  Login(user: widget.user,)));
    }
    else if(data == "EmailAlreadyUsed"){
      Fluttertoast.showToast(
          msg: "Email Already Used",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 15.0);
    }
    else {
      Fluttertoast.showToast(
        msg: "Please Fill In All The Requirements",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 15.0,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
          const Text('Login',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          backgroundColor: Colors.lightGreen,

        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:  [
                  const SizedBox(
                    height:30,
                  ),
                  const Icon(
                    Icons.map_rounded,
                    size:  120,
                    color: Colors.lightGreen,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  const Text('MapMe',
                    style: TextStyle(
                      fontSize: 40,

                    ),
                  ),
                  const Text('Registration Requirement',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // MyInput(
                  //   controller: fullNameControlller,
                  //   hintText: 'Please Enter Full Name',
                  //   obscureText: false,
                  //
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInput(hint_text: "Fullname", obcureText: false, callback: nameCallBackFunction),
                  const SizedBox(
                    height: 25,
                  ),

                  CustomInput(hint_text: "username", obcureText: false, callback: usernameCallBackFunction),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomInput(hint_text: "Email", obcureText: false, callback: emailCallBackFunction),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomInput(hint_text: "Password", obcureText: true, callback: passwordCallBackFunction),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Button_2(
                    onTap: () async {

                      if(widget.user.email.isNotEmpty && widget.user.name.isNotEmpty && widget.user.password.isNotEmpty){

                        var data = await widget.user.registerUser();


                        if (!isStrongPassword(widget.user.password)) {
                          Fluttertoast.showToast(
                            msg: "Password must contain at least 8 characters including numbers and characters",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black,
                            fontSize: 15.0,
                          );
                        }

                        else if (data == "EmailAlreadyUsed") {
                        Fluttertoast.showToast(
                        msg: "Email Already Used",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.black,
                        fontSize: 15.0,
                        );
                        }else if (data == "Success") {
                          Fluttertoast.showToast(
                            msg: "Registration Complete",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black,
                            fontSize: 15.0,
                          );
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>  Login(user: widget.user,)));
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please Fill In All The Requirements",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black,
                            fontSize: 15.0,
                          );
                        }



                      }
                      // registerUser();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}

