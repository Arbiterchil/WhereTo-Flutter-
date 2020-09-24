import 'package:WhereTo/Transaction/MyOrder/payOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class DeliveryCharge {
  Future<Navigator> getDeliveryCharge(LatLng restaurant, LatLng user, BuildContext context, String restauID) async {
    var distance = new Distance();
    final double km = distance.as(LengthUnit.Kilometer,
        restaurant, user);
    double charge = 30.0;
    for (int c = 4; c <= km; c++) {
      if (c > 4) {
        charge += 5;
      } else {
        charge += 0;
      }
    }
    return Navigator.push(context, MaterialPageRoute(builder: (context) =>PayOrder(fee: charge,restauID:restauID)));
  }
}
