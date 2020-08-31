import 'dart:convert';

List<ViewtransacNeWRestaurant> viewtransacNeWRestaurantFromJson(String str) => List<ViewtransacNeWRestaurant>.from(json.decode(str).map((x) => ViewtransacNeWRestaurant.fromJson(x)));

String viewtransacNeWRestaurantToJson(List<ViewtransacNeWRestaurant> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewtransacNeWRestaurant {
    ViewtransacNeWRestaurant({
        this.id,
        this.name,
        this.contactNumber,
        this.barangayName,
        this.restaurantName,
        this.address,
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
    String address;
    String deliveryAddress;
    String createdAt;
    String deviceId;
    dynamic riderId;
    int status;
    int deliveryCharge;

    factory ViewtransacNeWRestaurant.fromJson(Map<String, dynamic> json) => ViewtransacNeWRestaurant(
        id: json["id"],
        name: json["name"],
        contactNumber: json["contactNumber"],
        barangayName: json["barangayName"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        deliveryAddress: json["deliveryAddress"],
        createdAt:json["created_at"],
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
        "address": address,
        "deliveryAddress": deliveryAddress,
        "created_at": createdAt,
        "deviceId": deviceId,
        "riderId": riderId,
        "status": status,
        "deliveryCharge": deliveryCharge,
    };
}