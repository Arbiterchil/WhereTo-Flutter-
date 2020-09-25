// To parse this JSON data, do
//
//     final restaurantGets = restaurantGetsFromJson(jsonString);

import 'dart:convert';

RestaurantGets restaurantGetsFromJson(String str) => RestaurantGets.fromJson(json.decode(str));

String restaurantGetsToJson(RestaurantGets data) => json.encode(data.toJson());

class RestaurantGets {
    RestaurantGets({
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

    int id;
    String restaurantName;
    String owner;
    String representative;
    double latitude;
    double longitude;
    int barangayId;
    String contactNumber;
    String openTime;
    String closingTime;
    int closeOn;
    int isFeatured;
    int status;
    String imagePath;
    int isActive;
    String createdAt;
    String updatedAt;

    factory RestaurantGets.fromJson(Map<String, dynamic> json) => RestaurantGets(
        id: json["id"],
        restaurantName: json["restaurantName"],
        owner: json["owner"],
        representative: json["representative"],
        latitude: double.parse(json["latitude"]),
        longitude: double.parse(json["longitude"]),
        barangayId: json["barangayId"],
        contactNumber: json["contactNumber"],
        openTime: json["openTime"],
        closingTime: json["closingTime"],
        closeOn: json["closeOn"],
        isFeatured: json["isFeatured"],
        status: json["status"],
        imagePath: json["imagePath"],
        isActive: json["isActive"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
