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
        this.address,
        this.barangayName,
        this.menuName,
        this.categoryName,
        this.imagePath,
    });

    final int menuId;
    final int restaurantId;
    final String restaurantName;
    final String address;
    final String barangayName;
    final String menuName;
    final String categoryName;
    final String imagePath;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        menuId: json["menuId"],
        restaurantId: json["restaurantId"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        barangayName: json["barangayName"],
        menuName: json["menuName"],
        categoryName: json["categoryName"],
        imagePath: json["imagePath"],
    );

    Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "restaurantId": restaurantId,
        "restaurantName": restaurantName,
        "address": address,
        "barangayName": barangayName,
        "menuName": menuName,
        "categoryName": categoryName,
        "imagePath": imagePath,
    };
}

