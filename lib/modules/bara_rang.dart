import 'dart:convert';

List<String> barangaysFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String barangaysToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
