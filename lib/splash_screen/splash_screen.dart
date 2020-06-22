import 'dart:async';

import 'package:WhereTo/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          color: Colors.blueAccent,
          // image: DecorationImage(
          //   image: AssetImage("asset/img/bgback.png"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200.0,
              height: 200.0,
              child: Image.asset("asset/img/nc.png"),
            ),
            SizedBox(height: 30.0,),
            Padding(
              padding: const EdgeInsets.only(top: 20.0,), 
               ),
            Text("Where to Muertos",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0
                ),
                 ),
                 CircularProgressIndicator(
                   backgroundColor: Colors.white,
                   strokeWidth: 3.0,
                 ),  
          ],
        ),
      ),
    );
  }
}