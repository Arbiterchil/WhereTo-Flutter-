import 'package:WhereTo/restaurants/New_ViewRestaurant/static_food.dart';
import 'package:flutter/material.dart';

class FoodDisplay extends StatefulWidget {
  @override
  _FoodDisplayState createState() => _FoodDisplayState();
}

class _FoodDisplayState extends State<FoodDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              StaticFoodDisplay(
                                restaurantname: "KFC",
                                foodname: "Potato Frys",
                                description: "Fries and Potato with Dip Ketchup",
                                image: "asset/img/fryandpota.jpg",
                                onTap: (){},
                              ),
                              StaticFoodDisplay(
                                restaurantname: "KFC",
                                foodname: "Vegetarian Food",
                                description: "Vegetarian food in Russia Cussine",
                                image: "asset/img/gulays.jpg",
                                onTap: (){},
                              ),
                              StaticFoodDisplay(
                                restaurantname: "Chowking",
                                foodname: "Noodles Chinese Food",
                                description: "Covid 19 Installed",
                                image: "asset/img/noodles.jpg",
                                onTap: (){},
                              ),
                              StaticFoodDisplay(
                                restaurantname: "Jollibee",
                                foodname: "Burger Extra Chili Hot",
                                description: "Burgers Burgers!",
                                image: "asset/img/burgers.jpg",
                                onTap: (){},
                              ),
                              StaticFoodDisplay(
                                restaurantname: "McDonalds",
                                foodname: "Burger Standard Falbor",
                                description: "Burgers Burgers!",
                                image: "asset/img/fryandpota.jpg",
                                onTap: (){},
                              ),

                            ],
                          ),
                          ],
                        ),
                      ),
                      ),
    );
  }
}