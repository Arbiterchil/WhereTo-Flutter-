// To parse this JSON data, do
//
//     final baranClass = baranClassFromJson(jsonString);

import 'dart:convert';

List<BaranClass> baranClassFromJson(String str) => List<BaranClass>.from(json.decode(str).map((x) => BaranClass.fromJson(x)));

String baranClassToJson(List<BaranClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BaranClass {
    BaranClass({
        this.id,
        this.cityId,
        this.barangayName,
        this.charge,
    });

    int id;
    int cityId;
    String barangayName;
    int charge;

    factory BaranClass.fromJson(Map<String, dynamic> json) => BaranClass(
        id: json["id"],
        cityId: json["cityId"],
        barangayName: json["barangayName"],
        charge: json["charge"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cityId": cityId,
        "barangayName": barangayName,
        "charge": charge,
    };
}
