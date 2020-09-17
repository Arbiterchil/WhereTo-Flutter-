class RetieveAlltransac {
  int id;
  String name;
  String contactNumber;
  String barangayName;
  String restaurantName;
  String restoLatitude;
  String restoLongitude;
  String transLatitude;
  String transLongitude;
  String createdAt;
  String deviceId;
  int riderId;
  int status;
  int deliveryCharge;

  RetieveAlltransac(
      {this.id,
      this.name,
      this.contactNumber,
      this.barangayName,
      this.restaurantName,
      this.restoLatitude,
      this.restoLongitude,
      this.transLatitude,
      this.transLongitude,
      this.createdAt,
      this.deviceId,
      this.riderId,
      this.status,
      this.deliveryCharge});

  RetieveAlltransac.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactNumber = json['contactNumber'];
    barangayName = json['barangayName'];
    restaurantName = json['restaurantName'];
    restoLatitude = json['restoLatitude'];
    restoLongitude = json['restoLongitude'];
    transLatitude = json['transLatitude'];
    transLongitude = json['transLongitude'];
    createdAt = json['created_at'];
    deviceId = json['deviceId'];
    riderId = json['riderId'];
    status = json['status'];
    deliveryCharge = json['deliveryCharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contactNumber'] = this.contactNumber;
    data['barangayName'] = this.barangayName;
    data['restaurantName'] = this.restaurantName;
    data['restoLatitude'] = this.restoLatitude;
    data['restoLongitude'] = this.restoLongitude;
    data['transLatitude'] = this.transLatitude;
    data['transLongitude'] = this.transLongitude;
    data['created_at'] = this.createdAt;
    data['deviceId'] = this.deviceId;
    data['riderId'] = this.riderId;
    data['status'] = this.status;
    data['deliveryCharge'] = this.deliveryCharge;
    return data;
  }
}