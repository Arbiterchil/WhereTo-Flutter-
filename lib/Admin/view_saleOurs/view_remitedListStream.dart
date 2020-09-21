import 'dart:convert';

List<RemittanceList> remittanceListFromJson(String str) => List<RemittanceList>.from(json.decode(str).map((x) => RemittanceList.fromJson(x)));

String remittanceListToJson(List<RemittanceList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RemittanceList {
    RemittanceList({
        this.name,
        this.amount,
        this.createdAt,
    });

    String name;
    double amount;
    DateTime createdAt;

    factory RemittanceList.fromJson(Map<String, dynamic> json) => RemittanceList(
        name: json["name"],
        amount: json["amount"].toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
    };
}