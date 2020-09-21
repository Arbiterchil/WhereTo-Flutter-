import 'dart:convert';

List<RiverMenu> riverMenuFromJson(String str) => List<RiverMenu>.from(json.decode(str).map((x) => RiverMenu.fromJson(x)));

String riverMenuToJson(List<RiverMenu> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiverMenu {
    RiverMenu({
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

    factory RiverMenu.fromJson(Map<String, dynamic> json) => RiverMenu(
        id: json["id"],
        menuName: json["menuName"],
        description: json["description"],
        totalPrice: json["totalPrice"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "menuName": menuName,
        "description": description,
        "totalPrice": totalPrice.toDouble(),
        "quantity": quantity,
    };
}
