import 'package:WhereTo/Admin/add_Rider.dart/rider_forms.dart';
import 'package:flutter/material.dart';

class AddRiderAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: WillPopScope(
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
        
      onWillPop: () async => false),
    );
  }
}