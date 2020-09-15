import 'dart:async';
import 'dart:convert';

import 'package:WhereTo/modules/Awalkthrough/walk_t.dart';
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
  String checks;
  String hens;
    @override
  void initState() {
    _getUserInfo();
    super.initState();
    startTime();
    
  }

  

  void _getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('userTYPO'); 
      setState(() {
        userData = userJson;
      });
  }



  startTime(){
    var duration = Duration(seconds: 5);
    return Timer(duration,route);
  }
  route(){
   

   
      Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => PathWay( 
        getStringthis: userData != null ? userData.toString() : "trialShow"  ,)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
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
                    decoration: BoxDecoration(
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