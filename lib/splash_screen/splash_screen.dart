import 'dart:async';

import 'package:WhereTo/path.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
    @override
  void initState() {
    super.initState();
    startTime();
  }
  startTime() async{
    var duration = Duration(seconds: 4);
    return Timer(duration,route);
  }
  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => PathWay()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color:  
          Color(0xFF398AE5)
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
                    decoration: eCBox,
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