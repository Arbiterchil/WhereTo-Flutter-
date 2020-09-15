class UnViewRemit {
  int id;
  int riderId;
  String name;
  int amount;
  String imagePath;
  int status;
  String createdAt;

  UnViewRemit(
      {this.id,
      this.riderId,
      this.name,
      this.amount,
      this.imagePath,
      this.status,
      this.createdAt});

  UnViewRemit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    riderId = json['riderId'];
    name = json['name'];
    amount = json['amount'];
    imagePath = json['imagePath'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['riderId'] = this.riderId;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['imagePath'] = this.imagePath;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}