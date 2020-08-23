import 'dart:convert';

List<AdminDevices> adminDevicesFromJson(String str) => List<AdminDevices>.from(json.decode(str).map((x) => AdminDevices.fromJson(x)));

String adminDevicesToJson(List<AdminDevices> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminDevices {
    AdminDevices({
        this.deviceId,
    });

    String deviceId;

    factory AdminDevices.fromJson(Map<String, dynamic> json) => AdminDevices(
        deviceId: json["deviceId"],
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
    };
}