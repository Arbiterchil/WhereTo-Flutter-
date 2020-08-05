import 'package:flutter/material.dart';

class InboxRider extends StatefulWidget {
  @override
  _InboxRiderState createState() => _InboxRiderState();
}

class _InboxRiderState extends State<InboxRider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 500,
                  width: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("asset/img/notifempty.png") 
                    )
                  ),
                )
              ],
             ),
           ),
        ),),
    );
  }
}