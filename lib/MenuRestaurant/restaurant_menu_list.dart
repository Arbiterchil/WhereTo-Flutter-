// To parse this JSON data, do
//
//     final restaurantMenu = restaurantMenuFromJson(jsonString);

import 'dart:convert';

List<RestaurantMenu> restaurantMenuFromJson(String str) => List<RestaurantMenu>.from(json.decode(str).map((x) => RestaurantMenu.fromJson(x)));

String restaurantMenuToJson(List<RestaurantMenu> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantMenu {
    RestaurantMenu({
        this.id,
        this.restaurantName,
        this.menuName,
        this.description,
        this.price,
    });

    int id;
    String restaurantName;
    String menuName;
    String description;
    int price;

    factory RestaurantMenu.fromJson(Map<String, dynamic> json) => RestaurantMenu(
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
