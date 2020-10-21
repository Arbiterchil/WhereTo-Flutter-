import 'package:WhereTo/Admin/add_Rider.dart/rider_forms.dart';
import 'package:flutter/material.dart';

class AddRiderAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: WillPopScope(
          child: SafeArea(
            child: SingleChildScrollView(
             physics: BouncingScrollPhysics(),
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