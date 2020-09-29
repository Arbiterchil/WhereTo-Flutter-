import 'dart:async';
import 'dart:convert';

import 'package:WhereTo/modules/Awalkthrough/walk_t.dart';
import 'package:WhereTo/modules/OtherFeatures/Auth/auth_pref.dart';
import 'package:WhereTo/path.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
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
    authShared.getThos();
   
    super.initState();
    getThis();
    startTime();

  }

  getThis(){
    StreamSubscription<Position> positionStream = getPositionStream().listen(
    (Position position) {
       
        if(position == null){
          print('DESOLE  wala jud');
        }else{
 String livin =  position.latitude.toString() + ', ' + position.longitude.toString();
  print('DESOLE  $livin');
        }
        // print(position == null ? 'Unknown' :
        // position.latitude.toString() + ', ' + position.longitude.toString());
       
    });
    print(positionStream);
  }
  
  startTime(){
    var duration = Duration(seconds: 4);
    return Timer(duration,route);
  }
  route(){
      Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => authShared.openSessionPages()));
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