
import 'package:WhereTo/Transaction/productTransaction.dart';
import 'package:flutter/material.dart';


class MyCart extends StatefulWidget {
  final String nameRestau;
  final String restauID;
  final String barangay;
  MyCart({this.nameRestau, this.restauID, this.barangay});
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransactionList(
          barangay: widget.barangay,
          restauID: widget.restauID,
    ),
    );
  }
  
}
