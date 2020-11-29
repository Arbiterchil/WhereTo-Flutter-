// To parse this JSON data, do
//
//     final retieveAlltransac = retieveAlltransacFromJson(jsonString);

import 'dart:convert';

List<RetieveAlltransac> retieveAlltransacFromJson(String str) => List<RetieveAlltransac>.from(json.decode(str).map((x) => RetieveAlltransac.fromJson(x)));

String retieveAlltransacToJson(List<RetieveAlltransac> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RetieveAlltransac {
    RetieveAlltransac({
        this.id,
        this.restaurantId,
        this.name,
        this.contactNumber,
        this.restaurantName,
        this.barangayName,
        this.deliveryAddress,
        this.createdAt,
        this.deviceId,
        this.riderId,
        this.status,
        this.deliveryCharge,
    });

    int id;
    int restaurantId;
    String name;
    String contactNumber;
    String restaurantName;
    String barangayName;
    String deliveryAddress;
    String createdAt;
    String deviceId;
    int riderId;
    int status;
    int deliveryCharge;

    factory RetieveAlltransac.fromJson(Map<String, dynamic> json) => RetieveAlltransac(
        id: json["id"],
        restaurantId: json["restaurantId"],
        name: json["name"],
        contactNumber: json["contactNumber"],
        restaurantName: json["restaurantName"],
        barangayName: json["barangayName"],
        deliveryAddress: json["deliveryAddress"],
        createdAt: json["created_at"],
        deviceId: json["deviceId"],
        riderId: json["riderId"],
        status: json["status"],
        deliveryCharge: json["deliveryCharge"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantId": restaurantId,
        "name": name,
        "contactNumber": contactNumber,
        "restaurantName": restaurantName,
        "barangayName": barangayName,
        "deliveryAddress": deliveryAddress,
        "created_at": createdAt,
        "deviceId": deviceId,
        "riderId": riderId,
        "status": status,
        "deliveryCharge": deliveryCharge,
    };
}
