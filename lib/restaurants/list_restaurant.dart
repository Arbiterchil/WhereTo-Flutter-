import 'dart:convert';

import 'package:WhereTo/MenuRestaurant/categ_list.dart';
import 'package:WhereTo/MenuRestaurant/categ_type.dart';
import 'package:WhereTo/MenuRestaurant/restaurant_categ.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:WhereTo/restaurants/restaurant.dart';
class ListStactic extends StatefulWidget {
  
   final Restaurant restaurant;
  
  const ListStactic({Key key, this.restaurant,}) : super(key: key);
 
  @override
  _ListStacticState createState() => _ListStacticState();
}

   

class _ListStacticState extends State<ListStactic> with SingleTickerProviderStateMixin {
  
  // final List<TyepCateg> typesong;
  // _ListStacticState(this.typesong);

  TabController tabsControl;
   int haha;
  

  @override
  void initState() {
    super.initState();

    // tabsControl = TabController(vsync: this,length: categ.length);
  }

  @override
  Widget build(BuildContext context) {

    // int getmeouts = widget.restaurant.id;
      
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.restaurantName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.bold
        ),
        ),
        
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.amber,
        ),
        child: CategList(),
      ),
           
    );
  }

}

 