// To parse this JSON data, do
//
//     final featuredRestaurant = featuredRestaurantFromJson(jsonString);

import 'dart:convert';

List<FeaturedRestaurant> featuredRestaurantFromJson(String str) => List<FeaturedRestaurant>.from(json.decode(str).map((x) => FeaturedRestaurant.fromJson(x)));



class FeaturedRestaurant {
    FeaturedRestaurant({
        this.id,
        this.restaurantName,
        this.owner,
        this.representative,
        this.latitude,
        this.longitude,
        this.barangayId,
        this.contactNumber,
        this.openTime,
        this.closingTime,
        this.closeOn,
        this.isFeatured,
        this.status,
        this.imagePath,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    final int id;
    final String restaurantName;
    final String owner;
    final String representative;
    final String latitude;
    final String longitude;
    final int barangayId;
    final String contactNumber;
    final String openTime;
    final String closingTime;
    final int closeOn;
    final int isFeatured;
    final int status;
    final String imagePath;
    final int isActive;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory FeaturedRestaurant.fromJson(Map<String, dynamic> json) => FeaturedRestaurant(
        id: json["id"],
        restaurantName: json["restaurantName"],
        owner: json["owner"],
        representative: json["representative"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        barangayId: json["barangayId"],
        contactNumber: json["contactNumber"],
        openTime: json["openTime"],
        closingTime: json["closingTime"],
        closeOn: json["closeOn"],
        isFeatured: json["isFeatured"],
        status: json["status"],
        imagePath: json["imagePath"],
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantName": restaurantName,
        "owner": owner,
        "representative": representative,
        "latitude": latitude,
        "longitude": longitude,
        "barangayId": barangayId,
        "contactNumber": contactNumber,
        "openTime": openTime,
        "closingTime": closingTime,
        "closeOn": closeOn,
        "isFeatured": isFeatured,
        "status": status,
        "imagePath": imagePath,
        "isActive": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
