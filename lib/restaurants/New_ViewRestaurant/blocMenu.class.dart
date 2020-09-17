// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

List<Menu> menuFromJson(String str) => List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

class Menu {
    Menu({
        this.menuId,
        this.restaurantId,
        this.restaurantName,
        this.latitude,
        this.longitude,
        this.menuName,
        this.description,
        this.imagePath,
        this.totalPrice,
    });

    final int menuId;
    final int restaurantId;
    final String restaurantName;
    final String latitude;
    final String longitude;
    final String menuName;
    final String description;
    final String imagePath;
    final double totalPrice;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        menuId: json["menuId"],
        restaurantId: json["restaurantId"],
        restaurantName: json["restaurantName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        menuName: json["menuName"],
        description: json["description"],
        imagePath: json["imagePath"],
        totalPrice: json["totalPrice"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "restaurantId": restaurantId,
        "restaurantName": restaurantName,
        "latitude": latitude,
        "longitude": longitude,
        "menuName": menuName,
        "description": description,
        "imagePath": imagePath,
        "totalPrice": totalPrice,
    };
}
