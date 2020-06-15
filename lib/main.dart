import 'package:WhereTo/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/homepage.dart';
import 'modules/login_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  // bool _isLoggedIn = false;

  @override
  void initState() {
    // _checkIfLoggedIn();
    super.initState();
  }

  // void _checkIfLoggedIn() async{
  //     // check if token is there
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     var token = localStorage.getString('token');
  //     if(token!= null){
  //        setState(() {
  //           _isLoggedIn = true;
  //        });
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         body: SplashScreen(),
        // body: _isLoggedIn ? Home() :  LoginPage(),
      ),
      
    );
  }
}