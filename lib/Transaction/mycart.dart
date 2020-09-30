
import 'package:WhereTo/Transaction/productTransaction.dart';
import 'package:flutter/material.dart';


class MyCart extends StatefulWidget {
  final String nameRestau;
  final String restauID;
  final double restoLat;
  final double restoLng;
  final String baranggay;
  MyCart({this.nameRestau, this.restauID, this.restoLat, this.restoLng, this.baranggay});
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
            baranggay: widget.baranggay,
            restoLat: widget.restoLat,
            restoLng: widget.restoLng,
            restauID: widget.restauID,
      ),
      ),
    );
  }
  
}
