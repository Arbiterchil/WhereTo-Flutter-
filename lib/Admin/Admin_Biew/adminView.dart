// To parse this JSON data, do
//
//     final adminView = adminViewFromJson(jsonString);

import 'dart:convert';

AdminView adminViewFromJson(String str) => AdminView.fromJson(json.decode(str));

String adminViewToJson(AdminView data) => json.encode(data.toJson());

class AdminView {
    AdminView({
        this.transactionDetails,
        this.menuList,
    });

    List<TransactionDetail> transactionDetails;
    List<List<MenuList>> menuList;

    factory AdminView.fromJson(Map<String, dynamic> json) => AdminView(
        transactionDetails: List<TransactionDetail>.from(json["transactionDetails"].map((x) => TransactionDetail.fromJson(x))),
        menuList: List<List<MenuList>>.from(json["menuList"].map((x) => List<MenuList>.from(x.map((x) => MenuList.fromJson(x))))),
    );

    Map<String, dynamic> toJson() => {
        "transactionDetails": List<dynamic>.from(transactionDetails.map((x) => x.toJson())),
        "menuList": List<dynamic>.from(menuList.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    };
}

class MenuList {
    MenuList({
        this.id,
        this.menuName,
        this.description,
        this.totalPrice,
        this.quantity,
    });

    int id;
    String menuName;
    String description;
    double totalPrice;
    int quantity;

    factory MenuList.fromJson(Map<String, dynamic> json) => MenuList(
        id: json["id"],
        menuName: json["menuName"],
        description: json["description"],
        totalPrice: json["totalPrice"].toDouble(),
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "menuName": menuName,
        "description": description,
        "totalPrice": totalPrice,
        "quantity": quantity,
    };
}

class TransactionDetail {
    TransactionDetail({
        this.id,
        this.name,
        this.restaurantName,
        this.deliveryAddress,
        this.barangayName,
        this.deliveryCharge,
    });

    int id;
    String name;
    String restaurantName;
    String deliveryAddress;
    String barangayName;
    int deliveryCharge;

    factory TransactionDetail.fromJson(Map<String, dynamic> json) => TransactionDetail(
        id: json["id"],
        name: json["name"],
        restaurantName: json["restaurantName"],
        deliveryAddress: json["deliveryAddress"],
        barangayName: json["barangayName"],
        deliveryCharge: json["deliveryCharge"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "restaurantName": restaurantName,
        "deliveryAddress": deliveryAddress,
        "barangayName": barangayName,
        "deliveryCharge": deliveryCharge,
    };
}
