// To parse this JSON data, do
//
//     final getSalerepo = getSalerepoFromJson(jsonString);

import 'dart:convert';

List<GetSalerepo> getSalerepoFromJson(String str) => List<GetSalerepo>.from(json.decode(str).map((x) => GetSalerepo.fromJson(x)));

String getSalerepoToJson(List<GetSalerepo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSalerepo {
    GetSalerepo({
        this.id,
        this.menuName,
        this.price,
        this.quantity,
        this.total,
    });

    int id;
    String menuName;
    int price;
    int quantity;
    int total;

    factory GetSalerepo.fromJson(Map<String, dynamic> json) => GetSalerepo(
        id: json["id"],
        menuName: json["menuName"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "menuName": menuName,
        "price": price,
        "quantity": quantity,
        "total": total,
    };
}
