// To parse this JSON data, do
//
//     final filteringMenuTrial = filteringMenuTrialFromJson(jsonString);

import 'dart:convert';

List<FilteringMenuTrial> filteringMenuTrialFromJson(String str) => List<FilteringMenuTrial>.from(json.decode(str).map((x) => FilteringMenuTrial.fromJson(x)));

String filteringMenuTrialToJson(List<FilteringMenuTrial> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilteringMenuTrial {
    FilteringMenuTrial({
        this.menuId,
        this.restaurantId,
        this.restaurantName,
        this.latitude,
        this.longitude,
        this.barangayName,
        this.menuName,
        this.categoryId,
        this.isFeatured,
        this.categoryName,
        this.imagePath,
        this.totalPrice,
    });

    int menuId;
    int restaurantId;
    String restaurantName;
    String latitude;
    String longitude;
    String barangayName;
    String menuName;
    int categoryId;
    int isFeatured;
    String categoryName;
    String imagePath;
    double totalPrice;

    factory FilteringMenuTrial.fromJson(Map<String, dynamic> json) => FilteringMenuTrial(
        menuId: json["menuId"],
        restaurantId: json["restaurantId"],
        restaurantName: json["restaurantName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        barangayName: json["barangayName"],
        menuName: json["menuName"],
        categoryId: json["categoryId"],
        isFeatured: json["isFeatured"],
        categoryName: json["categoryName"],
        imagePath: json["imagePath"],
        totalPrice: json["totalPrice"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "restaurantId": restaurantId,
        "restaurantName": restaurantName,
        "latitude": latitude,
        "longitude": longitude,
        "barangayName": barangayName,
        "menuName": menuName,
        "categoryId": categoryId,
        "isFeatured": isFeatured,
        "categoryName": categoryName,
        "imagePath": imagePath,
        "totalPrice": totalPrice,
    };
}
