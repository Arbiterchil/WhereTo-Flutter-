
import 'package:WhereTo/Transaction/productTransaction.dart';
import 'package:flutter/material.dart';


class MyCart extends StatefulWidget {
  final String nameRestau;
  final String restauID;
  final String restaurantAddress;
  MyCart({this.nameRestau, this.restauID, this.restaurantAddress});
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransactionList(
          restaurantAddress: widget.restaurantAddress,
          restauID: widget.restauID,
    ),
    );
  }
  
}
