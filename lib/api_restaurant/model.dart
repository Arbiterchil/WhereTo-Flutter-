// To parse this JSON data, do
//
//     final restaurantList = restaurantListFromJson(jsonString);

import 'dart:convert';

class RestaurantList {
  
    final int id;
    final String restaurantName;
    final String menuName;
    final String description;
    final int price;
    
    RestaurantList({
        this.id,
        this.restaurantName,
        this.menuName,
        this.description,
        this.price,
    });


    RestaurantList copyWith({
        int id,
        String restaurantName,
        String menuName,
        String description,
        int price,
    }) => 
        RestaurantList(
            id: id ?? this.id,
            restaurantName: restaurantName ?? this.restaurantName,
            menuName: menuName ?? this.menuName,
            description: description ?? this.description,
            price: price ?? this.price,
        );

    factory RestaurantList.fromRawJson(String str) => RestaurantList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        id: json["id"],
        restaurantName: json["restaurantName"],
        menuName: json["menuName"],
        description: json["description"],
        price: json["price"],
    );
    Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantName": restaurantName,
        "menuName": menuName,
        "description": description,
        "price": price,
    };

    
}
