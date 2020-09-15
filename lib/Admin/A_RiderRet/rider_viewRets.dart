class RetieveAlltransac {
  int id;
  String name;
  String contactNumber;
  String barangayName;
  String restaurantName;
  String address;
  String deliveryAddress;
  String createdAt;
  String deviceId;
  String riderId;
  int status;
  int deliveryCharge;

  RetieveAlltransac(
      {this.id,
      this.name,
      this.contactNumber,
      this.barangayName,
      this.restaurantName,
      this.address,
      this.deliveryAddress,
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
    address = json['address'];
    deliveryAddress = json['deliveryAddress'];
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
    data['address'] = this.address;
    data['deliveryAddress'] = this.deliveryAddress;
    data['created_at'] = this.createdAt;
    data['deviceId'] = this.deviceId;
    data['riderId'] = this.riderId;
    data['status'] = this.status;
    data['deliveryCharge'] = this.deliveryCharge;
    return data;
  }
}