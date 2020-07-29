// To parse this JSON data, do
//
//     final getPlayerId = getPlayerIdFromJson(jsonString);

import 'dart:convert';

List<GetPlayerId> getPlayerIdFromJson(String str) => List<GetPlayerId>.from(json.decode(str).map((x) => GetPlayerId.fromJson(x)));

String getPlayerIdToJson(List<GetPlayerId> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPlayerId {
    GetPlayerId({
        this.deviceId,
    });

    String deviceId;

    factory GetPlayerId.fromJson(Map<String, dynamic> json) => GetPlayerId(
        deviceId: json["deviceId"],
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
    };
}
