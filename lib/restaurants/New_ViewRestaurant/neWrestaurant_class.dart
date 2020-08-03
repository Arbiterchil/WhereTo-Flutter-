// To parse this JSON data, do
//
//     final neWRestaurant = neWRestaurantFromJson(jsonString);

import 'dart:convert';

List<NeWRestaurant> neWRestaurantFromJson(String str) => List<NeWRestaurant>.from(json.decode(str).map((x) => NeWRestaurant.fromJson(x)));

String neWRestaurantToJson(List<NeWRestaurant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NeWRestaurant {
    NeWRestaurant({
        this.id,
        this.restaurantName,
        this.address,
        this.contactNumber,
        this.openTime,
        this.closingTime,
        this.closeOn,
        this.isFeatured,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String restaurantName;
    String address;
    String contactNumber;
    String openTime;
    String closingTime;
    String closeOn;
    int isFeatured;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    factory NeWRestaurant.fromJson(Map<String, dynamic> json) => NeWRestaurant(
        id: json["id"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        contactNumber: json["contactNumber"],
        openTime: json["openTime"],
        closingTime: json["closingTime"],
        closeOn: json["closeOn"],
        isFeatured: json["isFeatured"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantName": restaurantName,
        "address": address,
        "contactNumber": contactNumber,
        "openTime": openTime,
        "closingTime": closingTime,
        "closeOn": closeOn,
        "isFeatured": isFeatured,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
