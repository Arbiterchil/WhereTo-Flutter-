import 'dart:convert';

List<ViewRemit> viewRemitFromJson(String str) => List<ViewRemit>.from(json.decode(str).map((x) => ViewRemit.fromJson(x)));

String viewRemitToJson(List<ViewRemit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewRemit {
    ViewRemit({
        this.riderId,
        this.name,
        this.amount,
        this.imagePath,
        this.status,
        this.createdAt,
    });

    int riderId;
    String name;
    int amount;
    String imagePath;
    int status;
    String createdAt;

    factory ViewRemit.fromJson(Map<String, dynamic> json) => ViewRemit(
        riderId: json["riderId"],
        name: json["name"],
        amount: json["amount"],
        imagePath: json["imagePath"],
        status: json["status"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "riderId": riderId,
        "name": name,
        "amount": amount,
        "imagePath": imagePath,
        "status": status,
        "created_at": createdAt,
    };
}