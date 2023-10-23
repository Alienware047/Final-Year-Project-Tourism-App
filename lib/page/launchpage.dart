
import 'package:flutter/material.dart';
import 'package:mapme2/page/homepage.dart';
import 'package:mapme2/page/login_.dart';

import '../component/mymapwiget2.dart';
import '../model/tourist_location.dart';
import '../model/user.dart';





class LaunchPage extends StatefulWidget {


  static const routeName = "/";

  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  late User user;







  Future<void> loadPreferences() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();


    user = User();
    await user.getUserInfoFromSharedPreference();
    var loggedIn = user.isLoggedIn;


    print(loggedIn);


    if(loggedIn == false || loggedIn == null) {



      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  Login(user: user)),
        );
      });




    }else {

      print("hello");

      var touristSites = await TouristSite.getLocations();
      print(touristSites);

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  MyMapWidget2(touristSites: touristSites,user: User(),)),
        );
      });




    }


  }

  @override
  Widget build(BuildContext context) {

    print('launchpage');


        return FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {



            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'MapMe',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set the text color to white

                      ),
                    ),
                    SizedBox(height: 30),
                    CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            );
          },
          future: loadPreferences(),

        );

  }
}