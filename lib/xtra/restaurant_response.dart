
import 'package:WhereTo/restaurants/restaurant.dart';

// To parse this JSON data, do
//
//     final restaurantResponse = restaurantResponseFromMap(jsonString);

import 'dart:convert';

class RestaurantResponse {
    RestaurantResponse({
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

    final int id;
    final String restaurantName;
    final String address;
    final String contactNumber;
    final String openTime;
    final String closingTime;
    final String closeOn;
    final int isFeatured;
    final int status;
    final DateTime createdAt;
    final DateTime updatedAt;

    RestaurantResponse copyWith({
        int id,
        String restaurantName,
        String address,
        String contactNumber,
        String openTime,
        String closingTime,
        String closeOn,
        int isFeatured,
        int status,
        DateTime createdAt,
        DateTime updatedAt,
    }) => 
        RestaurantResponse(
            id: id ?? this.id,
            restaurantName: restaurantName ?? this.restaurantName,
            address: address ?? this.address,
            contactNumber: contactNumber ?? this.contactNumber,
            openTime: openTime ?? this.openTime,
            closingTime: closingTime ?? this.closingTime,
            closeOn: closeOn ?? this.closeOn,
            isFeatured: isFeatured ?? this.isFeatured,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory RestaurantResponse.fromJson(String str) => RestaurantResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RestaurantResponse.fromMap(Map<String, dynamic> json) => RestaurantResponse(
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

    Map<String, dynamic> toMap() => {
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
