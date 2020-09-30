// To parse this JSON data, do
//
//     final retieveAlltransac = retieveAlltransacFromJson(jsonString);

import 'dart:convert';

List<RetieveAlltransac> retieveAlltransacFromJson(String str) => List<RetieveAlltransac>.from(json.decode(str).map((x) => RetieveAlltransac.fromJson(x)));

String retieveAlltransacToJson(List<RetieveAlltransac> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RetieveAlltransac {
    RetieveAlltransac({
        this.id,
        this.name,
        this.contactNumber,
        this.barangayName,
        this.restaurantName,
        this.deliveryAddress,
        this.createdAt,
        this.deviceId,
        this.riderId,
        this.status,
        this.deliveryCharge,
    });

    int id;
    String name;
    String contactNumber;
    String barangayName;
    String restaurantName;
    String deliveryAddress;
    DateTime createdAt;
    String deviceId;
    dynamic riderId;
    int status;
    int deliveryCharge;

    factory RetieveAlltransac.fromJson(Map<String, dynamic> json) => RetieveAlltransac(
        id: json["id"],
        name: json["name"],
        contactNumber: json["contactNumber"],
        barangayName: json["barangayName"],
        restaurantName: json["restaurantName"],
        deliveryAddress: json["deliveryAddress"],
        createdAt: DateTime.parse(json["created_at"]),
        deviceId: json["deviceId"],
        riderId: json["riderId"],
        status: json["status"],
        deliveryCharge: json["deliveryCharge"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contactNumber": contactNumber,
        "barangayName": barangayName,
        "restaurantName": restaurantName,
        "deliveryAddress": deliveryAddress,
        "created_at": createdAt.toIso8601String(),
        "deviceId": deviceId,
        "riderId": riderId,
        "status": status,
        "deliveryCharge": deliveryCharge,
    };
}
