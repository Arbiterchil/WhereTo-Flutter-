import 'dart:async';
import 'dart:convert';

import 'package:WhereTo/path.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  var userData;
  String hens;
    @override
  void initState() {
    super.initState();
    startTime();
    _getUserInfo();
  }

  void _getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  }



  startTime() async{
    var duration = Duration(seconds: 4);
    return Timer(duration,route);
  }
  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => PathWay( getStringthis: userData == null ? "1" :hens = userData['userType'].toString(),)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
           gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Align(
                alignment: Alignment.center,
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    padding: EdgeInsets.all(20.0),
                    // decoration: eCBoxDark,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                       borderRadius: BorderRadius.circular(110),
                      color: Colors.white
                    ),
                    child: Container(
                    child: Image.asset("asset/img/logo.png"),
            ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  

}