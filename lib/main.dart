
import 'package:WhereTo/api_restaurant_bloc/bloc.Restaurant.dart';
import 'package:WhereTo/api_restaurant_bloc/bloc.provider.dart';
import 'package:WhereTo/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
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
    return BlocProvider(
      bloc: Blocrestaurant(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         body: SplashScreen(),
        // body: _isLoggedIn ? Home() :  LoginPage(),
      ),
      
    ),
    );
  }
}