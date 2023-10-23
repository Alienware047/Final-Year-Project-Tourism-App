

import 'package:flutter/material.dart';

import 'package:mapme2/page/launchpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );





  runApp(const MyApp());
}
class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MapMe',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightGreen,

        ),
        debugShowCheckedModeBanner: false,
        home: const LaunchPage()

    );
  }
}