import 'package:WhereTo/restaurants/New_ViewRestaurant/static_food.dart';
import 'package:WhereTo/restaurants/blocClassMenu.dart';
import 'package:WhereTo/restaurants/blocMenuFeatured.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:flutter/material.dart';

class FoodDisplay extends StatefulWidget {
  @override
  _FoodDisplayState createState() => _FoodDisplayState();
}


BlocisFeatured blocFeatured;
    Future<void>getBloc() async {
    await blocFeatured.getIsFeatured();
    }

    Future<void> disposeBloc() async {
    blocFeatured.dispose();
    }
class _FoodDisplayState extends State<FoodDisplay> {

  @override
  Widget build(BuildContext context) {
    setState(() {
     blocFeatured =BlocisFeatured();
     getBloc();
    });
    return Container(
      height: 220,
      child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder<List<IsFeatured>>(
                          stream: blocFeatured.stream,
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              if(snapshot.data.length >0){
                              return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index){
                                if(snapshot.data.length >0){
                                return StaticFoodDisplay(
                                restaurantname: snapshot.data[index].restaurantName,
                                foodname: snapshot.data[index].menuName,
                                description: snapshot.data[index].categoryName,
                                image: snapshot.data[index].imagePath,
                                onTap: (){
                                  Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ListStactic(
                                                    restauID: snapshot
                                                        .data[index].restaurantId
                                                        .toString(),
                                                    nameRestau: snapshot
                                                        .data[index]
                                                        .restaurantName
                                                        .toString(),
                                                        baranggay: snapshot.data[index].barangayName,
                                                     address:snapshot.data[index].address.toString(),
                                                     categID: snapshot.data[index].categoryId.toString(),  
                                                  )));
                                },
                              ); 
                                }else{  
                                  return Container();
                                }
                              });
                              }else{
                                return Container();
                              }
                            }else{  
                              return Container();
                            }
                          }),
                      ),
                      ),
    );
  }
}