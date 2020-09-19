// To parse this JSON data, do
//
//     final receiptClass = receiptClassFromJson(jsonString);

import 'dart:convert';

class ReceiptClass {
    ReceiptClass({
        this.transactionDetails,
        this.orders,
        this.riderDetails,
    });

    final List<TransactionDetail> transactionDetails;
    final List<Order> orders;
    final List<RiderDetail> riderDetails;

    ReceiptClass copyWith({
        List<TransactionDetail> transactionDetails,
        List<Order> orders,
        List<RiderDetail> riderDetails,
    }) => 
        ReceiptClass(
            transactionDetails: transactionDetails ?? this.transactionDetails,
            orders: orders ?? this.orders,
            riderDetails: riderDetails ?? this.riderDetails,
        );

    factory ReceiptClass.fromRawJson(String str) => ReceiptClass.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReceiptClass.fromJson(Map<String, dynamic> json) => ReceiptClass(
        transactionDetails: List<TransactionDetail>.from(json["transactionDetails"].map((x) => TransactionDetail.fromJson(x))),
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        riderDetails: List<RiderDetail>.from(json["riderDetails"].map((x) => RiderDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "transactionDetails": List<dynamic>.from(transactionDetails.map((x) => x.toJson())),
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "riderDetails": List<dynamic>.from(riderDetails.map((x) => x.toJson())),
    };
}

class Order {
    Order({
        this.menuName,
        this.totalPrice,
        this.quantity,
        this.totalAmount,
    });

    final String menuName;
    final double totalPrice;
    final int quantity;
    final double totalAmount;

    Order copyWith({
        String menuName,
        double totalPrice,
        int quantity,
        double totalAmount,
    }) => 
        Order(
            menuName: menuName ?? this.menuName,
            totalPrice: totalPrice ?? this.totalPrice,
            quantity: quantity ?? this.quantity,
            totalAmount: totalAmount ?? this.totalAmount,
        );

    factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        menuName: json["menuName"],
        totalPrice: json["totalPrice"].toDouble(),
        quantity: json["quantity"],
        totalAmount: json["totalAmount"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "menuName": menuName,
        "totalPrice": totalPrice,
        "quantity": quantity,
        "totalAmount": totalAmount,
    };
}

class RiderDetail {
    RiderDetail({
        this.name,
        this.contactNumber,
    });

    final String name;
    final String contactNumber;

    RiderDetail copyWith({
        String name,
        String contactNumber,
    }) => 
        RiderDetail(
            name: name ?? this.name,
            contactNumber: contactNumber ?? this.contactNumber,
        );

    factory RiderDetail.fromRawJson(String str) => RiderDetail.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RiderDetail.fromJson(Map<String, dynamic> json) => RiderDetail(
        name: json["name"],
        contactNumber: json["contactNumber"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "contactNumber": contactNumber,
    };
}

class TransactionDetail {
    TransactionDetail({
        this.id,
        this.name,
        this.contactNumber,
        this.barangayName,
        this.restaurantName,
        this.createdAt,
        this.deliveryCharge,
        this.latitude,
        this.longitude,
    });

    final int id;
    final String name;
    final String contactNumber;
    final String barangayName;
    final String restaurantName;
    final DateTime createdAt;
    final int deliveryCharge;
    final String latitude;
    final String longitude;

    TransactionDetail copyWith({
        int id,
        String name,
        String contactNumber,
        String barangayName,
        String restaurantName,
        DateTime createdAt,
        int deliveryCharge,
        String latitude,
        String longitude,
    }) => 
        TransactionDetail(
            id: id ?? this.id,
            name: name ?? this.name,
            contactNumber: contactNumber ?? this.contactNumber,
            barangayName: barangayName ?? this.barangayName,
            restaurantName: restaurantName ?? this.restaurantName,
            createdAt: createdAt ?? this.createdAt,
            deliveryCharge: deliveryCharge ?? this.deliveryCharge,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
        );

    factory TransactionDetail.fromRawJson(String str) => TransactionDetail.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TransactionDetail.fromJson(Map<String, dynamic> json) => TransactionDetail(
        id: json["id"],
        name: json["name"],
        contactNumber: json["contactNumber"],
        barangayName: json["barangayName"],
        restaurantName: json["restaurantName"],
        createdAt: DateTime.parse(json["created_at"]),
        deliveryCharge: json["deliveryCharge"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contactNumber": contactNumber,
        "barangayName": barangayName,
        "restaurantName": restaurantName,
        "created_at": createdAt.toIso8601String(),
        "deliveryCharge": deliveryCharge,
        "latitude": latitude,
        "longitude": longitude,
    };
}
