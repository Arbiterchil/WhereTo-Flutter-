class Receipt {
  List<TransactionDetails> transactionDetails;
  List<Orders> orders;
  List<RiderDetails> riderDetails;

  Receipt({this.transactionDetails, this.orders, this.riderDetails});

  Receipt.fromJson(Map<String, dynamic> json) {
    if (json['transactionDetails'] != null) {
      transactionDetails = new List<TransactionDetails>();
      json['transactionDetails'].forEach((v) {
        transactionDetails.add(new TransactionDetails.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
    if (json['riderDetails'] != null) {
      riderDetails = new List<RiderDetails>();
      json['riderDetails'].forEach((v) {
        riderDetails.add(new RiderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactionDetails != null) {
      data['transactionDetails'] =
          this.transactionDetails.map((v) => v.toJson()).toList();
    }
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    if (this.riderDetails != null) {
      data['riderDetails'] = this.riderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionDetails {
  int id;
  String name;
  String contactNumber;
  String barangayName;
  String restaurantName;
  String createdAt;
  int deliveryCharge;
  String latitude;
  String longitude;

  TransactionDetails(
      {this.id,
      this.name,
      this.contactNumber,
      this.barangayName,
      this.restaurantName,
      this.createdAt,
      this.deliveryCharge,
      this.latitude,
      this.longitude});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactNumber = json['contactNumber'];
    barangayName = json['barangayName'];
    restaurantName = json['restaurantName'];
    createdAt = json['created_at'];
    deliveryCharge = json['deliveryCharge'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contactNumber'] = this.contactNumber;
    data['barangayName'] = this.barangayName;
    data['restaurantName'] = this.restaurantName;
    data['created_at'] = this.createdAt;
    data['deliveryCharge'] = this.deliveryCharge;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Orders {
  String menuName;
  int totalPrice;
  int quantity;
  int totalAmount;

  Orders({this.menuName, this.totalPrice, this.quantity, this.totalAmount});

  Orders.fromJson(Map<String, dynamic> json) {
    menuName = json['menuName'];
    totalPrice = json['totalPrice'];
    quantity = json['quantity'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuName'] = this.menuName;
    data['totalPrice'] = this.totalPrice;
    data['quantity'] = this.quantity;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}

class RiderDetails {
  String name;
  String contactNumber;

  RiderDetails({this.name, this.contactNumber});

  RiderDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contactNumber = json['contactNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['contactNumber'] = this.contactNumber;
    return data;
  }
}
