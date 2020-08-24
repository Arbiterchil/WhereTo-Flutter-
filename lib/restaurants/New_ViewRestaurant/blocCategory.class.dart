// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

class Category {
    Category({
        this.id,
        this.categoryName,
    });

    final int id;
    final String categoryName;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryName": categoryName,
    };
}
