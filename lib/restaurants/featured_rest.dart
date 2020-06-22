import 'dart:convert';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FearturedRestaurant extends StatefulWidget {
  @override
  _FearturedRestaurantState createState() => _FearturedRestaurantState();
}

Future<List<Restaurant>> _getRest() async{

    var response = await ApiCall().getRestarant('/getFeaturedRestaurant');
    
      List<Restaurant> rests = [];
    

      var bods = json.decode(response.body);
      
      for(var bods in bods){
        
        Restaurant rest = Restaurant
        (bods["id"],
        bods["restaurantName"],
        bods["address"],
        bods["contactNumber"],
        bods["isFeatured"]);

        rests.add(rest);
      }
      print(rests.length);
      return rests;
 }



class _FearturedRestaurantState extends State<FearturedRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child:  Padding(
          padding: const EdgeInsets.only(left: 10.0 , right: 10.0),
          child: _buildAxisHorin(),
          ),
      
      );
    
  }
 
  

  Widget _buildAxisHorin(){
      return  Container(  
            height: 190.0,
            child: FutureBuilder(
              future: _getRest(),
              builder: (BuildContext context , AsyncSnapshot snapshot){
                if(snapshot.data == null){
                  return Container(
                    child: Center(

                      child: Text("Getting the Data Please Wait..."),
                      
                    ),
                  );
                }else{
                  return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    
                  },
                  child: Padding(
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
                              AssetImage("asset/img/${snapshot.data[index].restaurantName}.png"),fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          width: 100.0,
                          child: Text(snapshot.data[index].restaurantName,
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
                  ),
                );
              },
              );
                }
              },
            ),
      );
  }

  

}
