import 'dart:convert';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/carousel_rest.dart';
import 'package:WhereTo/restaurants/featured_rest.dart';
import 'package:WhereTo/restaurants/restaurant.dart';
import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import '../bloc.Navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';


class RestDel extends StatefulWidget with NavigationStates{

  @override
_RestDel createState() => _RestDel();
}

class _RestDel extends State<RestDel>{
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     body: Container(
       height: MediaQuery.of(context).size.height,
       child: Stack(
         children: <Widget>[
           
             Container(
               height: MediaQuery.of(context).size.height,
               child: SingleChildScrollView(
                 physics: AlwaysScrollableScrollPhysics(),
                 child: Container(
                          margin: EdgeInsets.only(top:70.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                              // color: Color(0xFF3936ea),
                              color: Colors.white60,
                          ),
                          child: Column(
                            children: <Widget>[
                              CarouselSex(),
                               SizedBox(height: 8.0),
                               Row(
                                 children: <Widget>[
                                     Padding(
                                          padding: const EdgeInsets.only(left: 45 ,),
                                          child:
                                           Text("Popular : ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                              ), 
                                        ),
                                 ],
                               ),
                             
                               SizedBox(height: 8.0),
                              FearturedRestaurant(),
                              SizedBox(height: 15.0),
                              Row(
                                 children: <Widget>[
                                     Padding(
                                          padding: const EdgeInsets.only(left: 45 ,),
                                          child:
                                           Text("More Restaurant : ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                              ), 
                                        ),
                                 ],
                               ),
                               SizedBox(height: 8.0),
                                SizedBox(
                                  height: 200.0,
                                  width: 350.0,
                                  child:  ListView(
                                  children: <Widget>[
                         Card(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 15, top: 10, bottom: 10),
                                    width: MediaQuery.of(context).size.width,
                                    
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              height: 80.0,
                                              width: 80.0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 10.0,bottom: 10.0),
                                                child: CircleAvatar(
                                                  backgroundImage:AssetImage('asset/img/app.jpg'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                            'McDocoDoco',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //   Padding(
                                        //   padding: const EdgeInsets.only(left: 45 ,),
                                        //   child: Text("Likod sa Amung Balai rani. Street",
                                        //     textAlign: TextAlign.center,
                                        //     style: TextStyle(
                                        //       color: Color(0xFF9b9b9b),
                                        //       fontSize: 15.0,
                                        //       decoration: TextDecoration.none,
                                        //       fontWeight: FontWeight.normal,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),             
                            Card(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 15, top: 10, bottom: 10),
                                    width: MediaQuery.of(context).size.width,
                                    
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              height: 80.0,
                                              width: 80.0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 10.0,bottom: 10.0),
                                                child: CircleAvatar(
                                                  backgroundImage:AssetImage('asset/img/fbmYkDz.jpg'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                            'Joblebelie',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //   Padding(
                                        //   padding: const EdgeInsets.only(left: 45 ,),
                                        //   child: Text("Likod sa Amung Balai rani. Street",
                                        //     textAlign: TextAlign.center,
                                        //     style: TextStyle(
                                        //       color: Color(0xFF9b9b9b),
                                        //       fontSize: 15.0,
                                        //       decoration: TextDecoration.none,
                                        //       fontWeight: FontWeight.normal,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                            Card(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 15, top: 10, bottom: 10),
                                    width: MediaQuery.of(context).size.width,
                                    
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              height: 80.0,
                                              width: 80.0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 10.0,bottom: 10.0),
                                                child: CircleAvatar(
                                                  backgroundImage:AssetImage('asset/img/mWWsAhL.jpg'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                            'FrapeChups',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //   Padding(
                                        //   padding: const EdgeInsets.only(left: 45 ,),
                                        //   child: Text("Likod sa Amung Balai rani. Street",
                                        //     textAlign: TextAlign.center,
                                        //     style: TextStyle(
                                        //       color: Color(0xFF9b9b9b),
                                        //       fontSize: 15.0,
                                        //       decoration: TextDecoration.none,
                                        //       fontWeight: FontWeight.normal,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                      Card(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 15, top: 10, bottom: 10),
                                    width: MediaQuery.of(context).size.width,
                                    
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              height: 80.0,
                                              width: 80.0,
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 10.0,bottom: 10.0),
                                                child: CircleAvatar(
                                                  backgroundImage:AssetImage('asset/img/76134055_p0.png'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                            'Mang Kanor',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //   Padding(
                                        //   padding: const EdgeInsets.only(left: 45 ,),
                                        //   child: Text("Likod sa Amung Balai rani. Street",
                                        //     textAlign: TextAlign.center,
                                        //     style: TextStyle(
                                        //       color: Color(0xFF9b9b9b),
                                        //       fontSize: 15.0,
                                        //       decoration: TextDecoration.none,
                                        //       fontWeight: FontWeight.normal,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
               ],
             ),
                                ),
                               Container(

                    margin: EdgeInsets.only(top:30.0, left: 70, right:70.0, ),
                    width: 200.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: MaterialButton(
              onPressed: (){},
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child:  GestureDetector(
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return SearchDepo();
                                      }));
                },
                child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.arrow_downward,
                                                  color: Color(0xFF262AAA),
                                                ),
                                              ),
                                              
                                                Text(
                                                'Show More...',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.0,
                                                    decoration: TextDecoration.none,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              
                                            ],
                                          ),
              ),
              ),
                  ),
                                SizedBox(height: 30.0),
                                Text("Alright Reserve in 2020",style: 
                                TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.0,
                                ),),
                                SizedBox(height: 10.0),

                            ],
                          ),
                        ),
                        
               ),
             ),
           
         ],
       ),
       
     ),
    );
  } 
}


               