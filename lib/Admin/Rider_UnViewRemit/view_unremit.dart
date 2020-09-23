import 'dart:convert';

List<UnViewRemit> unViewRemitFromJson(String str) => List<UnViewRemit>.from(json.decode(str).map((x) => UnViewRemit.fromJson(x)));

String unViewRemitToJson(List<UnViewRemit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnViewRemit {
    UnViewRemit({
        this.id,
        this.riderId,
        this.name,
        this.amount,
        this.imagePath,
        this.status,
        this.createdAt,
    });

    int id;
    int riderId;
    String name;
    double amount;
    dynamic imagePath;
    int status;
    String createdAt;

    factory UnViewRemit.fromJson(Map<String, dynamic> json) => UnViewRemit(
        id: json["id"],
        riderId: json["riderId"],
        name: json["name"],
        amount: json["amount"].toDouble(),
        imagePath: json["imagePath"],
        status: json["status"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "riderId": riderId,
        "name": name,
        "amount": amount,
        "imagePath": imagePath,
        "status": status,
        "created_at": createdAt,
    };
}