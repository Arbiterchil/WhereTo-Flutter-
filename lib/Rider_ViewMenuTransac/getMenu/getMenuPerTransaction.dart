// To parse this JSON data, do
//
//     final getMenuPerTransaction = getMenuPerTransactionFromJson(jsonString);

import 'dart:convert';

List<GetMenuPerTransaction> getMenuPerTransactionFromJson(String str) => List<GetMenuPerTransaction>.from(json.decode(str).map((x) => GetMenuPerTransaction.fromJson(x)));

String getMenuPerTransactionToJson(List<GetMenuPerTransaction> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMenuPerTransaction {
    GetMenuPerTransaction({
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

    factory GetMenuPerTransaction.fromJson(Map<String, dynamic> json) => GetMenuPerTransaction(
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
