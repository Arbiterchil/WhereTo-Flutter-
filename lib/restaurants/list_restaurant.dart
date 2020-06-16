import 'package:WhereTo/restaurants/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListStactic extends StatefulWidget {
  
   final Restaurant restaurant;

  const ListStactic({Key key, this.restaurant}) : super(key: key);

  @override
  _ListStacticState createState() => _ListStacticState();
}





class _ListStacticState extends State<ListStactic> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.restaurantName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.bold
        ),),
      ),
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF7F7F7)
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[


                  


              ],
            ),
          ),
        ),
    );
  }

 

}

 