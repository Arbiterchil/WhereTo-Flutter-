import 'dart:ui';

import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class RiderPending extends StatefulWidget {

  final String message;
  final Function function;

  const RiderPending({Key key, this.message, this.function}) : super(key: key);
  @override
  _RiderPendingState createState() => _RiderPendingState();
}

class _RiderPendingState extends State<RiderPending> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
        child: Dialog(
           shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.message,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy-light',
                  fontSize: 14,
                ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: widget.function,
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: pureblue,
                      
                    ),
                    child: Center(
                      child: Text("Ok",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'Gilroy-light'
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
    );
  }
}