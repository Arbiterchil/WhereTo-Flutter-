

import 'dart:convert';

List<GetMenuPerRestaurant> getMenuPerRestaurantFromJson(String str) => List<GetMenuPerRestaurant>.from(json.decode(str).map((x) => GetMenuPerRestaurant.fromJson(x)));

String getMenuPerRestaurantToJson(List<GetMenuPerRestaurant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMenuPerRestaurant {
    GetMenuPerRestaurant({
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

    factory GetMenuPerRestaurant.fromJson(Map<String, dynamic> json) => GetMenuPerRestaurant(
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