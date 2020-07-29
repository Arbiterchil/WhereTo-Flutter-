// To parse this JSON data, do
//
//     final transactionDetails = transactionDetailsFromJson(jsonString);

import 'dart:convert';

List<TransactionDetails> transactionDetailsFromJson(String str) => List<TransactionDetails>.from(json.decode(str).map((x) => TransactionDetails.fromJson(x)));

String transactionDetailsToJson(List<TransactionDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionDetails {
    TransactionDetails({
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
    int riderId;

    factory TransactionDetails.fromJson(Map<String, dynamic> json) => TransactionDetails(
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
