import 'package:WhereTo/Admin/add_Rider.dart/rider_forms.dart';
import 'package:flutter/material.dart';

class AddRiderAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: WillPopScope(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
                      gradient: LinearGradient(
                              stops: [0.1,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
                    ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                         horizontal: 40.0,
                         vertical: 80.0,
                       ),
                       child: Column(
                         children: <Widget>[
                           RiderForms(),
                         ],
                       ),
            )),
        ), 
      onWillPop: () async => false),
    );
  }
}