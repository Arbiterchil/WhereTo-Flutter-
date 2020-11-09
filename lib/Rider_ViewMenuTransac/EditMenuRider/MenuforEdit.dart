// To parse this JSON data, do
//
//     final menuForEdit = menuForEditFromJson(jsonString);

import 'dart:convert';

List<MenuForEdit> menuForEditFromJson(String str) => List<MenuForEdit>.from(json.decode(str).map((x) => MenuForEdit.fromJson(x)));

String menuForEditToJson(List<MenuForEdit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuForEdit {
    MenuForEdit({
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

    factory MenuForEdit.fromJson(Map<String, dynamic> json) => MenuForEdit(
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
