import 'package:latlong/latlong.dart';

class DeliveryCharge {
  Future<double> getDeliveryCharge(LatLng restaurant, LatLng user) async {
    var distance = new Distance();
    final double km = distance.as(LengthUnit.Kilometer,
        restaurant, user);
    double charge = 40.0;
    for (int c = 4; c <= km; c++) {
      if (c > 4) {
        charge += 5;
      } else {
        charge += 0;
      }
    }
    return charge;
  }
}
