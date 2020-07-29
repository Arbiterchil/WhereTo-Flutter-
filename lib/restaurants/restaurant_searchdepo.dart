import 'dart:convert';

import 'package:WhereTo/AnCustom/restaurant_front.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/profile.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:WhereTo/restaurants/restaurant.dart';
import 'package:WhereTo/restaurants/restaurant_del.dart';
import 'package:WhereTo/restaurants/searchRestaurant.dart';
import 'package:flutter/material.dart';

import '../designbuttons.dart';

class SearchDepo extends StatefulWidget {
  @override
  _SearchDepoState createState() => _SearchDepoState();
}

    


   Future<List<SearchDeposition>> getRest() async {
   final response =await ApiCall().getRestarant('/getFeaturedRestaurant');
   List<SearchDeposition> search =searchDepoFromJson(response.body);
   return search;
 }

 


class _SearchDepoState extends State<SearchDepo> {
  
TextEditingController search = new TextEditingController();
    String searchit = "";
  @override
  void initState() {
    super.initState();
  
  }

  @override
  void dispose() {
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(

      backgroundColor:Color(0xFF398AE5),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                newListUp(),
                listData(),
              ],
            ),
              ),),
      ),
      

    );

  }

    Widget newListUp(){
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: DesignButton(
                                  height: 55,
                                  width: 55,
                                  color: Color(0xFF398AE5),
                                  offblackBlue: Offset(-4, -4),
                                  offsetBlue: Offset(4, 4),
                                  blurlevel: 4.0,
                                  icon: Icons.arrow_back,
                                  iconSize: 30.0,
                                  onTap: ()  {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                          return Profile();
                                        }));
                                     
                              },
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: DesignButton(
                                  height: 55,
                                  width: 55,
                                  color: Color(0xFF398AE5),
                                  offblackBlue: Offset(-4, -4),
                                  offsetBlue: Offset(4, 4),
                                  blurlevel: 4.0,
                                  icon: Icons.view_list,
                                  iconSize: 30.0,
                                  onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                          return RestDel();
                                        }));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25.0,),
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                             BoxShadow(
                            color:  Colors.blue[500],
                            blurRadius: 6,
                            offset: Offset(-6, -6),
                            ),
                            BoxShadow(
                              color:Colors.blue.shade700,
                              blurRadius: 6,
                              offset: Offset(6, 6),
                            ),
                            ],
                            ),
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: search,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(top:14.0,),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF398AE5),
                                ),
                                hintText: "Search",
                              ),
                              onChanged: (input){
                                setState(() {
                                    searchit = input;
                                });
                              },
                            )
                      ),

                ],
              ),
            ),
          ),
        );


    }  
    
    Widget listData(){
        return Padding(
          padding: const EdgeInsets.only(top: 180.0),
          child: new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
              ),
            ),
            child: FutureBuilder(
              future: getRest(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.data == null){
                  return Container(
                    child: Center(
                      child: Text("Restaurants Loading"),
                    ),
                  );
                }else{
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context , int index){
                          return snapshot.data[index].restaurantName.contains(searchit)
                          |snapshot.data[index].address.contains(searchit) ? GestureDetector(
                            onTap: (){

                              // Navigator.push(context,
                              //   new MaterialPageRoute(builder: (context) 
                              //   => ListStactic(
                              //      nameRestau: snapshot.data[index].restaurantName.toString(),
                              //     )
                              //   )
                              //   );    
                            },
                            child: RestaurantFront(
                              image: "asset/img/${snapshot.data[index].restaurantName}.png",
                              restaurantName:snapshot.data[index].restaurantName ,
                              restaurantAddress: snapshot.data[index].address,
                              openAndclose: snapshot.data[index].openTime+"-"+snapshot.data[index].closingTime,
                              onTap: (){
                                Navigator.push(context,
                                new MaterialPageRoute(builder: (context) 
                                => ListStactic(
                                    restauID: snapshot.data[index].id.toString(),
                                   nameRestau: snapshot.data[index].restaurantName.toString(),
                                  )
                                )
                                ); 
                              },
                            ),
                          ): Container();
                        },
                      );



                }
              },
            ),
          ),
        );
    }
}