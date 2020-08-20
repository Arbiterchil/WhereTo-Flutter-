import 'dart:convert';

List<Unverified> unverifiedFromJson(String str) => List<Unverified>.from(json.decode(str).map((x) => Unverified.fromJson(x)));

String unverifiedToJson(List<Unverified> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Unverified {
    Unverified({
        this.userId,
        this.name,
        this.imagePath,
    });
  
    int userId;
    String name;
    String imagePath;

    factory Unverified.fromJson(Map<String, dynamic> json) => Unverified(
        userId: json["userId"],
        name: json["name"],
        imagePath: json["imagePath"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "imagePath": imagePath,
    };
}