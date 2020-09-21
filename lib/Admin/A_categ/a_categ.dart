import 'dart:convert';

List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
    Categories({
        this.id,
        this.categoryName,
    });

    int id;
    String categoryName;

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryName": categoryName,
    };
}