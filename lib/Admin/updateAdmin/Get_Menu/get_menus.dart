// To parse this JSON data, do
//
//     final menuGet = menuGetFromJson(jsonString);

import 'dart:convert';

MenuGet menuGetFromJson(String str) => MenuGet.fromJson(json.decode(str));

String menuGetToJson(MenuGet data) => json.encode(data.toJson());


class MenuGet {
    MenuGet({
        this.id,
        this.restaurantId,
        this.categoryId,
        this.menuName,
        this.description,
        this.price,
        this.markUpPercentage,
        this.timesBought,
        this.imagePath,
        this.isFeatured,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int restaurantId;
    int categoryId;
    String menuName;
    String description;
    double price;
    double markUpPercentage;
    int timesBought;
    String imagePath;
    int isFeatured;
    int isActive;
    String createdAt;
    String updatedAt;

    factory MenuGet.fromJson(Map<String, dynamic> json) => MenuGet(
        id: json["id"],
        restaurantId: json["restaurant_id"],
        categoryId: json["categoryId"],
        menuName: json["menuName"],
        description: json["description"],
        price: json["price"].toDouble(),
        markUpPercentage: double.parse(json["markUpPercentage"]),
        timesBought: json["timesBought"],
        imagePath: json["imagePath"],
        isFeatured: json["isFeatured"],
        isActive: json["isActive"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
        "categoryId": categoryId,
        "menuName": menuName,
        "description": description,
        "price": price.toDouble(),
        "markUpPercentage": markUpPercentage.toDouble(),
        "timesBought": timesBought,
        "imagePath": imagePath,
        "isFeatured": isFeatured,
        "isActive": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
