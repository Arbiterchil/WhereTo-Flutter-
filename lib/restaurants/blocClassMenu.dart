// To parse this JSON data, do
//
//     final isFeatured = isFeaturedFromJson(jsonString);

import 'dart:convert';

List<IsFeatured> isFeaturedFromJson(String str) => List<IsFeatured>.from(json.decode(str).map((x) => IsFeatured.fromJson(x)));



class IsFeatured {
    IsFeatured({
        this.menuId,
        this.restaurantId,
        this.restaurantName,
        this.address,
        this.barangayName,
        this.menuName,
        this.categoryId,
        this.isFeatured,
        this.price,
        this.categoryName,
        this.imagePath,
    });

    final int menuId;
    final int restaurantId;
    final String restaurantName;
    final String address;
    final String barangayName;
    final String menuName;
    final int categoryId;
    final int isFeatured;
    final int price;
    final String categoryName;
    final String imagePath;

    factory IsFeatured.fromJson(Map<String, dynamic> json) => IsFeatured(
        menuId: json["menuId"],
        restaurantId: json["restaurantId"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        barangayName: json["barangayName"],
        menuName: json["menuName"],
        categoryId: json["categoryId"],
        isFeatured: json["isFeatured"],
        price: json["price"],
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
        "categoryId": categoryId,
        "isFeatured": isFeatured,
        "price": price,
        "categoryName": categoryName,
        "imagePath": imagePath,
    };
}


