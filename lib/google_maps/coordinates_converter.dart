import 'package:geocoder/geocoder.dart';

class CoordinatesConverter{
  Future<String> convert(String coord)async{
    var split =coord.split(',');
    double lat =double.parse(split[0].toString());
    double lng =double.parse(split[1].toString());
    final coordinates =Coordinates(lat,lng);
    var addresses =await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first =addresses.first;
    return first.addressLine;
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
}