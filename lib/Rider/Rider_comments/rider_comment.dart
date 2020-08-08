import 'dart:convert';

List<RiderComments> riderCommentsFromJson(String str) => List<RiderComments>.from(json.decode(str).map((x) => RiderComments.fromJson(x)));

String riderCommentsToJson(List<RiderComments> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiderComments {
    RiderComments({
        this.comment,
    });

    String comment;

    factory RiderComments.fromJson(Map<String, dynamic> json) => RiderComments(
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
    };
}
