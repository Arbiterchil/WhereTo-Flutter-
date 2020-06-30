// To parse this JSON data, do
//
//     final orderList = orderListFromJson(jsonString);

import 'dart:convert';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
    OrderList({
        this.userId,
        this.order,
        this.optionalAddress,
    });

    int userId;
    List<Order> order;
    String optionalAddress;

    factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        userId: json["userId"],
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
        optionalAddress: json["optionalAddress"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "order": List<dynamic>.from(order.map((x) => x.toJson())),
        "optionalAddress": optionalAddress,
    };
}

class Order {
    Order({
        this.menuId,
        this.quantity,
    });

    int menuId;
    int quantity;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        menuId: json["menuId"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "quantity": quantity,
    };
}
