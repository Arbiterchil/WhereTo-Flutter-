import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission/permission.dart';

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
  Future<LatLng> getCoordinatesFormat() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String user= localStorage.getString('coordinates');
    var coordinates =user.split(',');
    double lat =double.parse(coordinates[0].toString());
    double lng =double.parse(coordinates[1].toString());
    LatLng latlng = new LatLng(lat,lng);
    return latlng;
  }
  Future<PointLatLng> getCoordinatesPointLang() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String user= localStorage.getString('coordinates');
    var coordinates =user.split(',');
    double lat =double.parse(coordinates[0].toString());
    double lng =double.parse(coordinates[1].toString());
    PointLatLng latlng = new PointLatLng(lat,lng);
    return latlng;
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
  Future<bool> permissions() async{
    var permissions =await Permission.getPermissionsStatus([PermissionName.Location]);
    if(permissions[0].permissionStatus ==PermissionStatus.deny || permissions[0].permissionStatus ==PermissionStatus.notAgain){
      await Permission.requestPermissions([PermissionName.Location]);
      return true;
    }else{
      return false;
    }
  }
  Future<String> getPosition()async{
  Position postion =await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  String coor ="${postion.latitude},${postion.longitude}";
  return coor.toString();
  }
 
  
}
