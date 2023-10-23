import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapme2/custom_widgets/custom_input.dart';
import 'package:mapme2/model/user.dart';
import 'package:mapme2/page/forgotpassword.dart';
import '../component/mymapwiget2.dart';
import '../custom_widgets/button_1.dart';
import '../model/tourist_location.dart';
import '/custom_widgets/myTextfield.dart';
import '/custom_widgets/myTextfield3.dart';
import '/page/homepage.dart';

import '/page/register.dart';
import '/custom_widgets/myTextfield2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class Login extends StatefulWidget{
  final User user;
   Login({Key? key, required this.user}) : super(key: key);

  @override

  State<Login> createState() => _LoginState();
}

class _LoginState  extends State<Login> {


  String email = "";
  String _password = '';


  void usernameCallBackFunction(String data){
    setState(() {
      widget.user.username = data;
    });
  }

  void passwordCallBackFunction(String data){
    setState(() {
      widget.user.password = data;
    });
  }





  void registerMember(){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>  Register(user: widget.user,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[3000],
      body: SafeArea(
        child:SingleChildScrollView(
          child: Center(
              child:Column(
                children: [
                const SizedBox(
                  height: 30,
                  ),
                const Icon(
                    Icons.map_rounded,
                  size: 120,
                  color: Colors.lightGreen,
                      ),
                const SizedBox(
                  height: 30,
                ),
                const Text('MapMe',
                  style:TextStyle(
                    color: Colors.white,
                    fontSize: 40
                  ) ,
                ),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                      color:Colors.grey,
                      fontSize: 26,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomInput(hint_text: "Username", obcureText: false, callback: usernameCallBackFunction),
                const SizedBox(
                  height: 25,),
                  CustomInput(hint_text: "Password", obcureText: true, callback: passwordCallBackFunction),
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 10,
                ),


                  Button_1(
                    

                   onTap: () async {

                     print(widget.user.username);
                     print(widget.user.password);


                     var response = await widget.user.signUserIn();
                     print('data: $response');
                     var data = response['status'];
                     var userData = response['data'];











                     if(response != "No Internet"){

                       if (data == "success") {
                         // Save login state in shared preferences


                         widget.user.isLoggedIn = true;
                         widget.user.email = userData['email'];
                         widget.user.username = userData['username'];;
                         widget.user.name = userData['fullname'];

                         await widget.user.setUserInfoToSharedPreference(); // Save the username

                         var touristSites = await TouristSite.getLocations();

                         Fluttertoast.showToast(
                           msg: "Login Successful",
                           toastLength: Toast.LENGTH_SHORT,
                           gravity: ToastGravity.CENTER,
                           timeInSecForIosWeb: 1,
                           backgroundColor: Colors.grey,
                           textColor: Colors.black,
                           fontSize: 15.0,
                         );
                         Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyMapWidget2(user: widget.user, touristSites: touristSites,)));
                       } else if (data == "Invalid credentials" || data == "Missing username or password") {
                         Fluttertoast.showToast(
                           msg: "Username Or Password Incorrect",
                           toastLength: Toast.LENGTH_SHORT,
                           gravity: ToastGravity.CENTER,
                           timeInSecForIosWeb: 1,
                           backgroundColor: Colors.grey,
                           textColor: Colors.black,
                           fontSize: 15.0,
                         );
                       } else {
                         Fluttertoast.showToast(
                           msg: "An Error Occurred",
                           toastLength: Toast.LENGTH_SHORT,
                           gravity: ToastGravity.CENTER,
                           timeInSecForIosWeb: 1,
                           backgroundColor: Colors.grey,
                           textColor: Colors.black,
                           fontSize: 15.0,
                         );
                       }
                     }else{
                       Fluttertoast.showToast(
                         msg: "No Internet connection",
                         toastLength: Toast.LENGTH_SHORT,
                         gravity: ToastGravity.CENTER,
                         timeInSecForIosWeb: 1,
                         backgroundColor: Colors.grey,
                         textColor: Colors.black,
                         fontSize: 15.0,
                       );
                     }

                   }
                 ),

                const SizedBox(
                  height: 20,
                ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword(user: widget.user,)));
                    },
                    child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(children:[
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color:Colors.grey,
                            ),
                      ),

                      Divider(
                        height: 20,
                      ),
                      Text('Or'),
                      Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                      ),
                    ]


                   ),

                ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Text(
                      'Not A Member?'
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: (){
                        registerMember();
                      },
                      child: const Text('REGISTER FOR FREE',
                      style:TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,

                      )
                      ),
                    )
                  ],
                )
            ])
          ),
        ),
      ),
    );
  }




}
