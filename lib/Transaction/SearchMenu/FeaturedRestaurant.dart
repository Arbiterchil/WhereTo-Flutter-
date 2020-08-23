// To parse this JSON data, do
//
//     final featuredRestaurant = featuredRestaurantFromJson(jsonString);

import 'dart:convert';

List<FeaturedRestaurant> featuredRestaurantFromJson(String str) => List<FeaturedRestaurant>.from(json.decode(str).map((x) => FeaturedRestaurant.fromJson(x)));

String featuredRestaurantToJson(List<FeaturedRestaurant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeaturedRestaurant {
    FeaturedRestaurant({
        this.id,
        this.restaurantName,
        this.address,
        this.barangayName,
        this.contactNumber,
        this.imagePath
    });

    final int id;
    final String restaurantName;
    final String address;
    final String barangayName;
    final String contactNumber;
    final String imagePath;

    factory FeaturedRestaurant.fromJson(Map<String, dynamic> json) => FeaturedRestaurant(
        id: json["id"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        barangayName: json["barangayName"],
        contactNumber: json["contactNumber"],
        imagePath : json['imagePath']
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantName": restaurantName,
        "address": address,
        "barangayName": barangayName,
        "contactNumber": contactNumber,
        "imagePath" : imagePath
    };
}
