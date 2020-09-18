// To parse this JSON data, do
//
//     final receipt = receiptFromJson(jsonString);


class Receipt {
    Receipt({
        this.transactionDetails,
        this.orders,
        this.riderDetails,
    });

    final List<TransactionDetail> transactionDetails;
    final List<Order> orders;
    final List<RiderDetail> riderDetails;

    factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        transactionDetails: json["transactionDetails"] == null ? null : List<TransactionDetail>.from(json["transactionDetails"].map((x) => TransactionDetail.fromJson(x))),
        orders: json["orders"] == null ? null : List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        riderDetails: json["riderDetails"] == null ? null : List<RiderDetail>.from(json["riderDetails"].map((x) => RiderDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "transactionDetails": transactionDetails == null ? null : List<dynamic>.from(transactionDetails.map((x) => x.toJson())),
        "orders": orders == null ? null : List<dynamic>.from(orders.map((x) => x.toJson())),
        "riderDetails": riderDetails == null ? null : List<dynamic>.from(riderDetails.map((x) => x.toJson())),
    };
}

class Order {
    Order({
        this.menuName,
        this.totalPrice,
        this.quantity,
        this.totalAmount,
    });

    final String menuName;
    final int totalPrice;
    final int quantity;
    final int totalAmount;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        menuName: json["menuName"] == null ? null : json["menuName"],
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
    );

    Map<String, dynamic> toJson() => {
        "menuName": menuName == null ? null : menuName,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "quantity": quantity == null ? null : quantity,
        "totalAmount": totalAmount == null ? null : totalAmount,
    };
}

class RiderDetail {
    RiderDetail({
        this.name,
        this.contactNumber,
    });

    final String name;
    final String contactNumber;

    factory RiderDetail.fromJson(Map<String, dynamic> json) => RiderDetail(
        name: json["name"] == null ? null : json["name"],
        contactNumber: json["contactNumber"] == null ? null : json["contactNumber"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "contactNumber": contactNumber == null ? null : contactNumber,
    };
}

class TransactionDetail {
    TransactionDetail({
        this.id,
        this.name,
        this.contactNumber,
        this.barangayName,
        this.restaurantName,
        this.createdAt,
        this.deliveryCharge,
        this.latitude,
        this.longitude,
    });

    final int id;
    final String name;
    final String contactNumber;
    final String barangayName;
    final String restaurantName;
    final DateTime createdAt;
    final int deliveryCharge;
    final String latitude;
    final String longitude;

    factory TransactionDetail.fromJson(Map<String, dynamic> json) => TransactionDetail(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        contactNumber: json["contactNumber"] == null ? null : json["contactNumber"],
        barangayName: json["barangayName"] == null ? null : json["barangayName"],
        restaurantName: json["restaurantName"] == null ? null : json["restaurantName"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        deliveryCharge: json["deliveryCharge"] == null ? null : json["deliveryCharge"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "contactNumber": contactNumber == null ? null : contactNumber,
        "barangayName": barangayName == null ? null : barangayName,
        "restaurantName": restaurantName == null ? null : restaurantName,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "deliveryCharge": deliveryCharge == null ? null : deliveryCharge,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
    };
}
