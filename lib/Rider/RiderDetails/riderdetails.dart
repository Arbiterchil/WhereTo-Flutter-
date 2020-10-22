// To parse this JSON data, do
//
//     final riderDetailsTransac = riderDetailsTransacFromJson(jsonString);

import 'dart:convert';

List<RiderDetailsTransac> riderDetailsTransacFromJson(String str) => List<RiderDetailsTransac>.from(json.decode(str).map((x) => RiderDetailsTransac.fromJson(x)));

String riderDetailsTransacToJson(List<RiderDetailsTransac> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiderDetailsTransac {
    RiderDetailsTransac({
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
    String createdAt;
    String deviceId;
    dynamic riderId;
    int status;
    int deliveryCharge;

    factory RiderDetailsTransac.fromJson(Map<String, dynamic> json) => RiderDetailsTransac(
        id: json["id"],
        name: json["name"],
        contactNumber: json["contactNumber"],
        barangayName: json["barangayName"],
        restaurantName: json["restaurantName"],
        deliveryAddress: json["deliveryAddress"],
        createdAt: json["created_at"],
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
        "created_at": createdAt,
        "deviceId": deviceId,
        "riderId": riderId,
        "status": status,
        "deliveryCharge": deliveryCharge,
    };
}
