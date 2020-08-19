// To parse this JSON data, do
//
//     final filterRestaurant = filterRestaurantFromJson(jsonString);

import 'dart:convert';

List<FilterRestaurant> filterRestaurantFromJson(String str) => List<FilterRestaurant>.from(json.decode(str).map((x) => FilterRestaurant.fromJson(x)));

class FilterRestaurant {
    FilterRestaurant({
        this.id,
        this.restaurantName,
        this.address,
        this.barangayName,
        this.menuName,
        this.categoryName,
        this.imagePath,
    });

    final int id;
    final String restaurantName;
    final String address;
    final String barangayName;
    final String menuName;
    final String categoryName;
    final String imagePath;

    factory FilterRestaurant.fromJson(Map<String, dynamic> json) => FilterRestaurant(
        id: json["id"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        barangayName: json["barangayName"],
        menuName: json["menuName"],
        categoryName: json["categoryName"],
        imagePath: json["imagePath"],
    );

    
}

