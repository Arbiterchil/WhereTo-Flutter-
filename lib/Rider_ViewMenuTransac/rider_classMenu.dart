
import 'dart:convert';

List<RiverMenu> riverMenuFromJson(String str) => List<RiverMenu>.from(json.decode(str).map((x) => RiverMenu.fromJson(x)));

String riverMenuToJson(List<RiverMenu> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiverMenu {
    RiverMenu({
        this.menuName,
        this.description,
        this.price,
        this.quantity,
    });

    String menuName;
    String description;
    int price;
    int quantity;

    factory RiverMenu.fromJson(Map<String, dynamic> json) => RiverMenu(
        menuName: json["menuName"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "menuName": menuName,
        "description": description,
        "price": price,
        "quantity": quantity,
    };
}
