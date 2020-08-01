// To parse this JSON data, do
//
//     final getViewOrders = getViewOrdersFromJson(jsonString);

import 'dart:convert';

List<GetViewOrders> getViewOrdersFromJson(String str) => List<GetViewOrders>.from(json.decode(str).map((x) => GetViewOrders.fromJson(x)));

String getViewOrdersToJson(List<GetViewOrders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetViewOrders {
    GetViewOrders({
        this.id,
        this.restaurantName,
        this.address,
        this.deliveryAddress,
        this.createdAt,
        this.riderId,
        this.status,
    });

    int id;
    String restaurantName;
    String address;
    String deliveryAddress;
    DateTime createdAt;
    dynamic riderId;
    int status;

    factory GetViewOrders.fromJson(Map<String, dynamic> json) => GetViewOrders(
        id: json["id"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        deliveryAddress: json["deliveryAddress"],
        riderId: json["riderId"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantName": restaurantName,
        "address": address,
        "deliveryAddress": deliveryAddress,
        "created_at": createdAt.toIso8601String(),
        "riderId": riderId,
        "status": status,
    };
}
