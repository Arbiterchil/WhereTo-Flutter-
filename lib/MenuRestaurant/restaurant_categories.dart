import 'dart:convert';

import 'package:WhereTo/MenuRestaurant/restaurant_categ.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';

class CategScreenTab extends StatefulWidget {
  @override
  _CategScreenTabState createState() => _CategScreenTabState();
}

 Future<List<Category>> _menuRest(int getmeout) async{

    var response = await ApiCall().getMenuRestaurant('/getMenu/$getmeout');

      List<Category> menu = [];

      var body = json.decode(response.body);

      for(var body in body){

          Category mens = Category(
            body['id'],
            body['restaurantName'],
            body['menuName'],
            body['description'],
            body['price'].toDouble(),
          );
        menu.add(mens);

      }

      print(menu.length);
      return menu;
 }
    
class _CategScreenTabState extends State<CategScreenTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}