// To parse this JSON data, do
//
//     final menuOrderTransaction = menuOrderTransactionFromJson(jsonString);

import 'dart:convert';

List<MenuOrderTransaction> menuOrderTransactionFromJson(String str) => List<MenuOrderTransaction>.from(json.decode(str).map((x) => MenuOrderTransaction.fromJson(x)));

String menuOrderTransactionToJson(List<MenuOrderTransaction> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuOrderTransaction {
    MenuOrderTransaction({
        this.id,
        this.name,
        this.restaurantName,
        this.address,
        this.deliveryAddress,
        this.createdAt,
        this.deviceId,
        this.riderId,
    });

    int id;
    String name;
    String restaurantName;
    String address;
    String deliveryAddress;
    DateTime createdAt;
    String deviceId;
    dynamic riderId;

    factory MenuOrderTransaction.fromJson(Map<String, dynamic> json) => MenuOrderTransaction(
        id: json["id"],
        name: json["name"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        deliveryAddress: json["deliveryAddress"],
        createdAt: DateTime.parse(json["created_at"]),
        deviceId: json["deviceId"],
        riderId: json["riderId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "restaurantName": restaurantName,
        "address": address,
        "deliveryAddress": deliveryAddress,
        "created_at": createdAt.toIso8601String(),
        "deviceId": deviceId,
        "riderId": riderId,
    };
}
