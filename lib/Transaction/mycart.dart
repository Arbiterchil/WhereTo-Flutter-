import 'package:WhereTo/Transaction/morpling.dart';
import 'package:WhereTo/Transaction/productTransaction.dart';
import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCart extends StatefulWidget {
  final String nameRestau;
  final String restauID;
  MyCart({this.nameRestau, this.restauID});
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TransactionList(
          restauID: widget.restauID,
    ),
    );
  }
  
}
