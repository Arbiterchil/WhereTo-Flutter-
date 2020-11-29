// To parse this JSON data, do
//
//     final cityAdmin = cityAdminFromJson(jsonString);

import 'dart:convert';

List<CityAdmin> cityAdminFromJson(String str) => List<CityAdmin>.from(json.decode(str).map((x) => CityAdmin.fromJson(x)));

String cityAdminToJson(List<CityAdmin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityAdmin {
    CityAdmin({
        this.id,
        this.cityName,
    });

    int id;
    String cityName;

    factory CityAdmin.fromJson(Map<String, dynamic> json) => CityAdmin(
        id: json["id"],
        cityName: json["cityName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cityName": cityName,
    };
}
