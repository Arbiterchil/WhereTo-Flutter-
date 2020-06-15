import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FearturedRestaurant extends StatefulWidget {
  @override
  _FearturedRestaurantState createState() => _FearturedRestaurantState();
}
 List<Restaurant> _rest = List<Restaurant>();

 Future<List<Restaurant>> _getRest() async{

    var response = await ApiCall().getRestarant('/getFeaturedRestaurant');
    
    var rest = List<Restaurant>();
    

      var bods = json.decode(response.body);
      
      for(Map bods in bods){
        rest.add(Restaurant.fromJson(bods));
      }
     
    

    return rest;
 }
class _FearturedRestaurantState extends State<FearturedRestaurant> {
  @override
  Widget build(BuildContext context) {
     _getRest().then((value) {
        if(mounted){
           setState(() {
          _rest.addAll(value);
        });
        }
        
      });
    return Container(
        // color: Color(0xFF3936ea),
        child:  Padding(
          padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
          child: _buildAxisHorin(),
          ),
      
      );
    
  }
 
  

  Widget _buildAxisHorin(){
      return  Container(  
            height: 190.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _rest.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    left: 10.0,
                    right: 10.0
                  ),
                  child: Column(
                    children: <Widget>[
                       Container(
                        width: 120.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: 
                            AssetImage("asset/img/${_rest[index].restaurantName}.png"),fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        width: 100.0,
                        child: Text(_rest[index].restaurantName,
                        maxLines: 2,
                        style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0
                        ),
                        ),
                      ),
                     
                      // SizedBox(height: 5.0,),

                    ],
                  ),
                );
              },
              ),
      );
  }

  

}
