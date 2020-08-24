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
        this.menuName,
        this.description,
        this.price,
        this.imagePath,
    });

    final int menuId;
    final int restaurantId;
    final String restaurantName;
    final String menuName;
    final String description;
    final int price;
    final String imagePath;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        menuId: json["menuId"],
        restaurantId: json["restaurantId"],
        restaurantName: json["restaurantName"],
        menuName: json["menuName"],
        description: json["description"],
        price: json["price"],
        imagePath: json["imagePath"],
    );

    Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "restaurantId": restaurantId,
        "restaurantName": restaurantName,
        "menuName": menuName,
        "description": description,
        "price": price,
        "imagePath": imagePath,
    };
}
