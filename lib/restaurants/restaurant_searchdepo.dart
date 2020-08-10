import 'dart:convert';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/restaurants/FoodDisplay.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_view.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/static_food.dart';
import 'package:WhereTo/restaurants/new_Carousel.dart';
import 'package:WhereTo/restaurants/static_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchDepo extends StatefulWidget {
  @override
  _SearchDepoState createState() => _SearchDepoState();
}

class _SearchDepoState extends State<SearchDepo> {


     final scaffoldKey = new GlobalKey<ScaffoldState>(); 
      var userData;
  var constant;
  bool casting;
  String getRestaurant;
  String searchit;
  TextEditingController search = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[   
                Stack(
                  children: <Widget>[
                     NewCarousel(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, top: 100, left: 20),
                        child: Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.80),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              cursorColor: Color(0xFF0C375B),
                              controller: search,
                              style: TextStyle(
                                  color: Color(0xFF0C375B),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy-light'),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                  top: 7.0,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF0C375B),
                                ),
                                hintText: "Search",
                              ),
                              // onChanged: (input) {
                              //   setState(() {
                              //     searchit = input;
                              //   });
                              // },
                               onSubmitted: (input){
                                  setState(() {
                                    searchit = input;
                                    print(searchit);
                                    
                                  });
                              },
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,top: 10),
                        child: GestureDetector(
                          onTap: () => UserDialog_Help.exit(context),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.exit_to_app,
                                color:Color(0xFF0C375B),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        
                        ),
                    ),

                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 170),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Satisfy Your Own",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 35.0,
                                  fontFamily: 'Gilroy-ExtraBold'),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "CRAVINGS",
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                  fontFamily: 'Gilroy-ExtraBold'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
               SharedPrefCallnameData(),
                SizedBox(height: 40,),
                 Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(
                        width: 170,
                        height: 40,
                          child: Text("Popular Food in Restaurant's",
                          style: TextStyle(
                                color:Color(0xFF0C375B),
                                fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    fontFamily: 'Gilroy-light' 
                          ),),
                  
                      ),
                    ),
                    SizedBox(height: 10,),
                    FoodDisplay(),
                   SizedBox(height: 10,),               
                  Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(
                       width: 170,
                        height: 40,
                          child: Text("Popular Fast Food",
                          style: TextStyle(
                                color:Color(0xFF0C375B),
                                fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    fontFamily: 'Gilroy-light' 
                          ),),
                     
                      ),
                    ),
                    SizedBox(height: 5.0,),
                   Padding(
                     padding: const EdgeInsets.only(left: 10,right: 10),
                     child: NewRestaurantViewFeatured(),
                   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

}