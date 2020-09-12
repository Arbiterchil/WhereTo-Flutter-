import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ID {
  String googleKey = "AIzaSyCdnmS1dtMXFTu5JHnJluRmEyyRU-sPZFk";

  Future<String> getId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    return user['id'].toString();
  }
  Future<String> getaddress() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    return user['address'].toString();
  }
  Future<String> getCoordinates() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user= localStorage.getString('coordinates');
    return user.toString();
  }
  Future<String> getnewCoordinates() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user= localStorage.getString('newCoordinates');
    return user.toString();
  }
  Future<String> getnewAddress() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user= localStorage.getString('newAddress');
    return user.toString();
  }
}
