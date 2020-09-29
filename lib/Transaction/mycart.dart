
import 'package:WhereTo/Transaction/productTransaction.dart';
import 'package:flutter/material.dart';


class MyCart extends StatefulWidget {
  final String nameRestau;
  final String restauID;
  final double restoLat;
  final double restoLng;
  final double userLat;
  final double userLng;
  MyCart({this.nameRestau, this.restauID, this.restoLat, this.restoLng, this.userLat, this.userLng});
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=> false,
          child: Scaffold(
        body: TransactionList(
            userLat: widget.userLat,
            userLng: widget.userLng,
            restoLat: widget.restoLat,
            restoLng: widget.restoLng,
            restauID: widget.restauID,
      ),
      ),
    );
  }
  
}
