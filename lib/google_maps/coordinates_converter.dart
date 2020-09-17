import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';

class CoordinatesConverter{
  // Future<String> convert(double lat, double lng)async{
  //   List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
  //   return placemarks.first.name;
  // }

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