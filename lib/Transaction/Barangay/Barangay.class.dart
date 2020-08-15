// To parse this JSON data, do
//
//     final barangayList = barangayListFromJson(jsonString);

import 'dart:convert';

List<BarangayList> barangayListFromJson(String str) => List<BarangayList>.from(json.decode(str).map((x) => BarangayList.fromJson(x)));

String barangayListToJson(List<BarangayList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BarangayList {
    BarangayList({
        this.id,
        this.barangayName,
    });

    final int id;
    final String barangayName;

    factory BarangayList.fromJson(Map<String, dynamic> json) => BarangayList(
        id: json["id"],
        barangayName: json["barangayName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "barangayName": barangayName,
    };
}
