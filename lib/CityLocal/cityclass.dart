// To parse this JSON data, do
//
//     final cityLocals = cityLocalsFromJson(jsonString);

import 'dart:convert';

List<CityLocals> cityLocalsFromJson(String str) => List<CityLocals>.from(json.decode(str).map((x) => CityLocals.fromJson(x)));

String cityLocalsToJson(List<CityLocals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityLocals {
    CityLocals({
        this.id,
        this.cityName,
    });

    int id;
    String cityName;

    factory CityLocals.fromJson(Map<String, dynamic> json) => CityLocals(
        id: json["id"],
        cityName: json["cityName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cityName": cityName,
    };
}
