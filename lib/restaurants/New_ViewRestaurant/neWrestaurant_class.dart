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
        this.barangayName,
        this.contactNumber,
        this.imagePath
    });

    int id;
    String restaurantName;
    String address;
    String barangayName;
    String contactNumber;
    String imagePath;

    factory NeWRestaurant.fromJson(Map<String, dynamic> json) => NeWRestaurant(
        id: json["id"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        barangayName: json["barangayName"],
        contactNumber: json["contactNumber"],
        imagePath :json["imagePath"]
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
