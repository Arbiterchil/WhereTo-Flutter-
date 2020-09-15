class Unverified {
  int userId;
  String name;
  String imagePath;

  Unverified({this.userId, this.name, this.imagePath});

  Unverified.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['imagePath'] = this.imagePath;
    return data;
  }
}