import 'package:geocoder/geocoder.dart';

class Payload {
  getCoordinates()async {
    final street = "Penongs Quirante II";
    final query ="Penongs $street, Tagum, Davao del Norte";
    final coordinates4 =new Coordinates(7.4281297, 125.8066161);
    final coordinates5 =new Coordinates(7.4282444, 125.8067206);

    final coordinates =new Coordinates(7.4492403,125.81070700000001);
    var addresses =await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first =addresses.first;
    print("${first.featureName}, ${first.adminArea} ${first.locality}, ${first.subAdminArea}");
    var queryaddresses =await Geocoder.local.findAddressesFromQuery(query);
    var second =queryaddresses.first;
  }
}
