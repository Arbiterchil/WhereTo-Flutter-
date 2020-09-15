class RemittanceList {
  String name;
  int amount;
  String createdAt;

  RemittanceList({this.name, this.amount, this.createdAt});

  RemittanceList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    return data;
  }
}