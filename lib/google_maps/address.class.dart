

import 'dart:convert';

List<Deliveryaddress> deliveryaddressFromJson(String str) => List<Deliveryaddress>.from(json.decode(str).map((x) => Deliveryaddress.fromJson(x)));



class Deliveryaddress {
    Deliveryaddress({
        this.id,
        this.userId,
        this.addressName,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
    });

    final int id;
    final int userId;
    final String addressName;
    final String latitude;
    final String longitude;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory Deliveryaddress.fromJson(Map<String, dynamic> json) => Deliveryaddress(
        id: json["id"],
        userId: json["userId"],
        addressName: json["addressName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "addressName": addressName,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
