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
  

Future<List<TyepCateg>> _categRest() async{

      var response = await ApiCall().getCategory('/getCategories');

      List<TyepCateg> categ = [];
      var body = json.decode(response.body);

      for(var body in body){

          TyepCateg mens = TyepCateg(
            body['id'],
            body['categoryName'],
          );
        categ.add(mens);

      }
      print(categ.length);
      return categ;
    }

  

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {

    // int getmeouts = widget.restaurant.id;
     return Container(
        child: FutureBuilder(
          future: _categRest(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data == null){
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                        strokeWidth: 3.0,
                        ),
                        ),  
                    ),
                  );
              }else{
                return DefaultTabController(
                  length: snapshot.data.length,
                   child: Scaffold(
                     backgroundColor: Color(0xFF3936ea),
                     appBar: AppBar(
                       backgroundColor: Colors.amber,
                       title: Text( widget.restaurant.restaurantName,
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         color: Colors.black,
                         fontSize: 24.0,
                         fontWeight: FontWeight.bold
                       ),),
                       bottom: TabBar(
                           unselectedLabelColor: Colors.black,
                           indicator: BoxDecoration(
                             color: Color(0xFF3936ea),
                             borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(20),
                               topRight: Radius.circular(20),
                             ),
                             ),
                         isScrollable: true,
                         tabs: snapshot.data.map<Widget>((TyepCateg ty) {
                              return Container(
                                width: 80.0,
                                child: Tab(
                                text: ty.categoryName,
                              ),
                              );
                         }).toList(),
                     ),
                     ), 
                      body: TabBarView(
                        children:snapshot.data.map<Widget>((TyepCateg ty) {
                         
                              return Container(
                                width: 80.0,
                                child: Tab(
                                text: ty.categoryName,
                              ),
                              );
                         
                         }).toList(),),  
                       

            
                   ),
                   
                   );
              }
        },
        ),      
    );     
    
  }

}

 