// To parse this JSON data, do
//
//     final tyepCateg = tyepCategFromJson(jsonString);

import 'dart:convert';

List<TyepCateg> tyepCategFromJson(String str) => List<TyepCateg>.from(json.decode(str).map((x) => TyepCateg.fromJson(x)));

String tyepCategToJson(List<TyepCateg> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TyepCateg {
    TyepCateg({
        this.id,
        this.categoryName,
    });

    int id;
    String categoryName;

    factory TyepCateg.fromJson(Map<String, dynamic> json) => TyepCateg(
        id: json["id"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryName": categoryName,
    };
}
