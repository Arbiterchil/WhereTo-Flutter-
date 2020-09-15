class Barangays {
  int id;
  String barangayName;

  Barangays({this.id, this.barangayName});

  Barangays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barangayName = json['barangayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barangayName'] = this.barangayName;
    return data;
  }
}