import 'dart:convert';

class Restaurant{

  final int id;
  final String restaurantName;
  final String address;
  final String contactNumber;
  final int isFeatured;

Restaurant(
  this.id,
  this.restaurantName,
  this.address,
  this.contactNumber,
  this.isFeatured
);

Restaurant.fromJson(Map<String,dynamic>json)
: id = json['id'],
  restaurantName = json['restaurantName'],
  address = json['address'],
  contactNumber = json['contactNumber'],
  isFeatured = json["isFeatured"];




}
