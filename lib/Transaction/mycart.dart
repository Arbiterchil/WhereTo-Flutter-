
import 'package:WhereTo/Transaction/productTransaction.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:flutter/material.dart';





class MyCart extends StatefulWidget {
   final String nameRestau;
   MyCart({ this.nameRestau});
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: true,
        leading: IconButton(
           icon: Icon(Icons.arrow_back_ios), 
           onPressed: (){
            //  Navigator.pushReplacement(context, MaterialPageRoute(
            // builder: (context) => ListStactic(nameRestau: widget.nameRestau,)));
            Navigator.pop(context);
           }), 
        title: Text("My Cart", style: TextStyle(),),
        
      ),
      body: TransactionList(),
    );
  }
}