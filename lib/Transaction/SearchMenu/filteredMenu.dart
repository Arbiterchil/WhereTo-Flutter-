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
        this.address,
        this.barangayName,
        this.menuName,
        this.categoryId,
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
    final String categoryName;
    final String imagePath;

    factory FilterRestaurant.fromJson(Map<String, dynamic> json) => FilterRestaurant(
        menuId: json["menuId"],
        restaurantId: json["restaurantId"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        barangayName: json["barangayName"],
        menuName: json["menuName"],
        categoryId: json["categoryId"],
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
        "categoryName": categoryName,
        "imagePath": imagePath,
    };
}


