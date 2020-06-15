import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListStatic extends StatefulWidget {
  @override
  _ListStaticState createState() => _ListStaticState();
}

class _ListStaticState extends State<ListStatic> {


  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
            Container(
              margin: EdgeInsets.only(top : 50.0),
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
            ),
        ],
    );
  }
}