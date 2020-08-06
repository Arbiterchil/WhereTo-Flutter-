import 'package:WhereTo/modules/profile.dart';
import 'package:flutter/material.dart';

class UserSoloTransport extends StatefulWidget {
  @override
  _UserSoloTransportState createState() => _UserSoloTransportState();
}

class _UserSoloTransportState extends State<UserSoloTransport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                  height: 500,
                  width: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("asset/img/ongoing.png")),
                  ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (context) => Profile()));
                  },
                  child: Container(
                   height: 50,
                   width: 190,
                   decoration: BoxDecoration(
                     color: Color(0xFF0C375B),
                     borderRadius: BorderRadius.all(Radius.circular(50))
                   ),
                   child: Center(
                     child: Text("Back to Home.",
                     style: TextStyle(
                       color: Colors.white,
                       fontFamily: 'Gilroy-light',
                       fontSize: 18.0
                     ),),

                   ),
                  ),
                ),


              ],
            ),
          ),
        )),
    );
  }
}