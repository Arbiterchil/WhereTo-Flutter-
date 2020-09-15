class NeWRestaurant {
  int id;
  String restaurantName;
  String owner;
  String representative;
  String address;
  int barangayId;
  String contactNumber;
  String openTime;
  String closingTime;
  int closeOn;
  int isFeatured;
  int status;
  String imagePath;
  int isActive;
  String createdAt;
  String updatedAt;

  NeWRestaurant(
      {this.id,
      this.restaurantName,
      this.owner,
      this.representative,
      this.address,
      this.barangayId,
      this.contactNumber,
      this.openTime,
      this.closingTime,
      this.closeOn,
      this.isFeatured,
      this.status,
      this.imagePath,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  NeWRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantName = json['restaurantName'];
    owner = json['owner'];
    representative = json['representative'];
    address = json['address'];
    barangayId = json['barangayId'];
    contactNumber = json['contactNumber'];
    openTime = json['openTime'];
    closingTime = json['closingTime'];
    closeOn = json['closeOn'];
    isFeatured = json['isFeatured'];
    status = json['status'];
    imagePath = json['imagePath'];
    isActive = json['isActive'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurantName'] = this.restaurantName;
    data['owner'] = this.owner;
    data['representative'] = this.representative;
    data['address'] = this.address;
    data['barangayId'] = this.barangayId;
    data['contactNumber'] = this.contactNumber;
    data['openTime'] = this.openTime;
    data['closingTime'] = this.closingTime;
    data['closeOn'] = this.closeOn;
    data['isFeatured'] = this.isFeatured;
    data['status'] = this.status;
    data['imagePath'] = this.imagePath;
    data['isActive'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}