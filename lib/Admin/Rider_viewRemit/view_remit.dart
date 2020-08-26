import 'dart:convert';

List<ViewRemit> viewRemitFromJson(String str) => List<ViewRemit>.from(json.decode(str).map((x) => ViewRemit.fromJson(x)));

String viewRemitToJson(List<ViewRemit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewRemit {
    ViewRemit({
        this.id,
        this.riderId,
        this.amount,
        this.imagePath,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int riderId;
    int amount;
    String imagePath;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    factory ViewRemit.fromJson(Map<String, dynamic> json) => ViewRemit(
        id: json["id"],
        riderId: json["riderId"],
        amount: json["amount"],
        imagePath: json["imagePath"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "riderId": riderId,
        "amount": amount,
        "imagePath": imagePath,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}