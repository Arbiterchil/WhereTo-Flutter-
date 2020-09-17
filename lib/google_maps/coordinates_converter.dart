import 'package:geocoder/geocoder.dart';

class CoordinatesConverter{
  Future<String> convert(double lat, double lng)async{
    final coordinates =Coordinates(lat,lng);
    var first;
    try{
    if(coordinates!=null){
    var addresses =await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first =addresses.first;
    }
    }catch(PlatformException){
    return first.addressLine;
    }
    
    
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