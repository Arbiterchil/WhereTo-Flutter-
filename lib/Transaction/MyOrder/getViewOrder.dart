// To parse this JSON data, do
//
//     final viewUserOrder = viewUserOrderFromJson(jsonString);

import 'dart:convert';

List<ViewUserOrder> viewUserOrderFromJson(String str) => List<ViewUserOrder>.from(json.decode(str).map((x) => ViewUserOrder.fromJson(x)));

String viewUserOrderToJson(List<ViewUserOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewUserOrder {
    ViewUserOrder({
        this.id,
        this.restaurantName,
        this.address,
        this.deliveryAddress,
        this.createdAt,
        this.riderId,
        this.status,
    });

    final int id;
    final String restaurantName;
    final String address;
    final String deliveryAddress;
    final DateTime createdAt;
    final dynamic riderId;
    final int status;

    factory ViewUserOrder.fromJson(Map<String, dynamic> json) => ViewUserOrder(
        id: json["id"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        deliveryAddress: json["deliveryAddress"],
        createdAt: DateTime.parse(json["created_at"]),
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
