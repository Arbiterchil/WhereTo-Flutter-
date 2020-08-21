// To parse this JSON data, do
//
//     final viewRemit = viewRemitFromJson(jsonString);

import 'dart:convert';

List<ViewRemit> viewRemitFromJson(String str) => List<ViewRemit>.from(json.decode(str).map((x) => ViewRemit.fromJson(x)));

String viewRemitToJson(List<ViewRemit> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewRemit {
    ViewRemit({
        this.riderId,
        this.name,
        this.imagePath,
    });

    int riderId;
    String name;
    String imagePath;

    factory ViewRemit.fromJson(Map<String, dynamic> json) => ViewRemit(
        riderId: json["riderId"],
        name: json["name"],
        imagePath: json["imagePath"],
    );

    Map<String, dynamic> toJson() => {
        "riderId": riderId,
        "name": name,
        "imagePath": imagePath,
    };
}
