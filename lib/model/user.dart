import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User {

  String name = "";
  String username = "";
  String password = "";
  String email = "";
  bool isLoggedIn = false;

  Future<void>getUserInfoFromSharedPreference() async {
    print("Getting user info from shared preference");

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    // id = prefs.getString('id') ?? '';

    name = prefs.getString('name') ?? '';
    email = prefs.getString('email')?? '';
    // username = prefs.getString('username')?? '';




    print('done loading');



  }

  Future<void>setUserInfoToSharedPreference() async {
    print("Setting user info to shared preference");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isLoggedIn", isLoggedIn) ;
    // await prefs.setString("id", id) ;
    await prefs.setString("email", email) ;
    await prefs.setString("name", name) ;
    // await prefs.setString("user_type", user_type) ;
    await prefs.setString("username", username) ;





  }




  Future signUserIn() async {
    var url = Uri.parse("https://absurd-hump.000webhostapp.com/login.php");

    try {
      var response = await http.post(url, body: {
        "username": username,
        "password": password,
      });

      var data = json.decode(response.body);
      print(data);

      return data;



    } catch (e) {
      return "no Internet";
      // Error handling when there is no internet connection
      // Fluttertoast.showToast(
      //   msg: "No Internet Connection",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.grey,
      //   textColor: Colors.black,
      //   fontSize: 15.0,
      // );
    }
  }

  Future registerUser() async {
    var url = Uri.parse("https://absurd-hump.000webhostapp.com/register.php");

    var response = await http.post(url, body: {
      "fullname": name,
      "email" :  email,
      "username": username,
      "password": password,
    });

    var data = json.decode(response.body);
    print(data);

    return data;


  }
  Future forgotPasswordUser() async {
    var url = Uri.parse("https://absurd-hump.000webhostapp.com/edit.php");

    var response = await http.post(url, body: {
      "email" : email,
    });

    var data = json.decode(response.body);
    print(data);

    return data;

  }
  Future changePasswordUser() async {
    var url = Uri.parse("https://absurd-hump.000webhostapp.com/change.php");

    var response = await http.post(url, body: {
      "email" : email,
      "password" : password,
    });

    var data = json.decode(response.body);
    print(data);

    return data;

  }




  Future<void> logout() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);



  }







}