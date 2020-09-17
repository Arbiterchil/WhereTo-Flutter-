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
        this.restoLatitude,
        this.restoLongitude,
        this.transLatitude,
        this.transLongitude,
        this.createdAt,
        this.riderId,
        this.status,
    });

    final int id;
    final String restaurantName;
    final String restoLatitude;
    final String restoLongitude;
    final String transLatitude;
    final String transLongitude;
    final DateTime createdAt;
    final int riderId;
    final int status;

    factory ViewUserOrder.fromJson(Map<String, dynamic> json) => ViewUserOrder(
        id: json["id"],
        restaurantName: json["restaurantName"],
        restoLatitude: json["restoLatitude"],
        restoLongitude: json["restoLongitude"],
        transLatitude: json["transLatitude"],
        transLongitude: json["transLongitude"],
        createdAt: DateTime.parse(json["created_at"]),
        riderId: json["riderId"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "restaurantName": restaurantName,
        "restoLatitude": restoLatitude,
        "restoLongitude": restoLongitude,
        "transLatitude": transLatitude,
        "transLongitude": transLongitude,
        "created_at": createdAt.toIso8601String(),
        "riderId": riderId,
        "status": status,
    };
}
