// To parse this JSON data, do
//
//     final filterRestaurant = filterRestaurantFromJson(jsonString);

import 'dart:convert';

List<FilterRestaurant> filterRestaurantFromJson(String str) => List<FilterRestaurant>.from(json.decode(str).map((x) => FilterRestaurant.fromJson(x)));



class FilterRestaurant {
    FilterRestaurant({
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

    final int menuId;
    final int restaurantId;
    final String restaurantName;
    final String latitude;
    final String longitude;
    final String barangayName;
    final String menuName;
    final int categoryId;
    final int isFeatured;
    final String categoryName;
    final String imagePath;
    final double totalPrice;

    factory FilterRestaurant.fromJson(Map<String, dynamic> json) => FilterRestaurant(
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


