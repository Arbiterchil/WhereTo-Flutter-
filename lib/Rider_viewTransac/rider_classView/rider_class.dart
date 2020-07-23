// To parse this JSON data, do
//
//     final riderViewClass = riderViewClassFromJson(jsonString);

import 'dart:convert';

List<RiderViewClass> riderViewClassFromJson(String str) => List<RiderViewClass>.from(json.decode(str).map((x) => RiderViewClass.fromJson(x)));

String riderViewClassToJson(List<RiderViewClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiderViewClass {
    RiderViewClass({
        this.id,
        this.name,
        this.restaurantName,
        this.address,
        this.deliveryAddress,    });

    int id;
    String name;
    String restaurantName;
    String address;
    String deliveryAddress;

    factory RiderViewClass.fromJson(Map<String, dynamic> json) => RiderViewClass(
        id: json["id"],
        name: json["name"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        deliveryAddress: json["deliveryAddress"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "restaurantName": restaurantName,
        "address": address,
        "deliveryAddress": deliveryAddress,
    };
}
