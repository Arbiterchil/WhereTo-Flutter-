import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:WhereTo/restaurants/restaurant.dart';
import 'package:flutter/material.dart';

class SearchDepo extends StatefulWidget {
  @override
  _SearchDepoState createState() => _SearchDepoState();
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
        body: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
                backButt(),
                listData(),
            ],
          ),
        ),
    );

  }

    
    backButt(){
        return new Container(
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0,top: 35.0),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
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
                            color: Colors.black,
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
              
              ),
            ),
          ),
        );
    }
    listData(){
        return Padding(
          padding: const EdgeInsets.only(top: 150.0),
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
              future: _getRest(),
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

                              Navigator.push(context,
                                new MaterialPageRoute(builder: (context) 
                                => ListStactic(
                                  restaurant: snapshot.data[index]
                                  )
                                )
                                );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left:30.0,right: 30.0,top: 20.0,),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                height: 90.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 80.0,
                                        width: 80.0,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage("asset/img/${snapshot.data[index].restaurantName}.png"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20.0,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                         Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(snapshot.data[index].restaurantName,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                    SizedBox(height: 15.0,),
                                     Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(snapshot.data[index].address,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              ),
                          ) : Container();
                        },
                      );



                }
              },
            ),
          ),
        );
    }
}