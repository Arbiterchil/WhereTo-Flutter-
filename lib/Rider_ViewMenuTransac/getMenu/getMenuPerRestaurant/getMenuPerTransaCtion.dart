// To parse this JSON data, do
//
//     final menuPerRes = menuPerResFromJson(jsonString);

import 'dart:convert';

class MenuPerRes {
    MenuPerRes({
        this.id,
        this.menuName,
        this.description,
        this.imagePath,
        this.isFeatured,
        this.totalPrice,
    });

    int id;
    String menuName;
    String description;
    String imagePath;
    int isFeatured;
    double totalPrice;

    factory MenuPerRes.fromRawJson(String str) => MenuPerRes.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MenuPerRes.fromJson(Map<String, dynamic> json) => MenuPerRes(
        id: json["id"],
        menuName: json["menuName"],
        description: json["description"],
        imagePath: json["imagePath"],
        isFeatured: json["isFeatured"],
        totalPrice: json["totalPrice"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "menuName": menuName,
        "description": description,
        "imagePath": imagePath,
        "isFeatured": isFeatured,
        "totalPrice": totalPrice,
    };
}
