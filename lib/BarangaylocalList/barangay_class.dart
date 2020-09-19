import 'dart:convert';

List<Barangays> barangaysFromJson(String str) => List<Barangays>.from(json.decode(str).map((x) => Barangays.fromJson(x)));

String barangaysToJson(List<Barangays> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Barangays {
    Barangays({
        this.id,
        this.barangayName,
    });

    int id;
    String barangayName;

    factory Barangays.fromJson(Map<String, dynamic> json) => Barangays(
        id: json["id"],
        barangayName: json["barangayName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "barangayName": barangayName,
    };
}