import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';


class CoordinatesConverter{

  Future<String> getAddressByLocation(String coordinates) async{
    var split =coordinates.split(',');
    double lat =double.parse(split[0].toString());
    double lng =double.parse(split[1].toString());
    final coord =Coordinates(lat,lng);
    var place =await Geocoder.local.findAddressesFromCoordinates(coord);
    return place.first.addressLine;
  }

  Future<String> addressByCity(String coord) async{
    var split =coord.split(',');
    double lat =double.parse(split[0].toString());
    double lng =double.parse(split[1].toString());
    final coordinates =Coordinates(lat,lng);
    var addresses =await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first =addresses.first;
    return first.locality;
  }
  Future<String> getCoordinates(AsyncSnapshot<List<ViewUserOrder>> snapshot, int index)async{
    return await CoordinatesConverter().getAddressByLocation("${snapshot.data[index].restoLatitude},${snapshot.data[index].restoLongitude}");
    // var user =await CoordinatesConverter().getAddressByLocation("${snapshot.data[index].transLatitude},${snapshot.data[index].transLongitude}");

    
  }
}