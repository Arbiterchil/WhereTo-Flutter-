
import 'dart:convert';

import 'package:WhereTo/Admin/A_RiderRet/rider_viewRets.dart';
import 'package:WhereTo/Admin/A_Rider_Remain/rider_remainResponse.dart';
import 'package:WhereTo/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemainApi {

  Future<RemainResponse> getRemaintran() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
     var idfromSave = localStorage.getString('menuplustrans');
  try{
    var reponse = await ApiCall().getTransactionDetailsById('/getTransactionDetailsById/$idfromSave');
    // var body = json.decode(reponse.body);
    // List<RetieveAlltransac> res = [];
    //     for(var body in body){
    //         RetieveAlltransac retieveAlltransac = RetieveAlltransac(
    //    id: body['id'],
    //     name: body['name'],
    //     contactNumber: body['contactNumber'],
    //     barangayName: body['barangayName'],
    //    restaurantName: body['restaurantName'],
    //     restoLatitude: double.parse(body['restoLatitude']) ,
    //     restoLongitude: double.parse(body['restoLongitude']),
    //     transLatitude: double.parse(body['transLatitude'],),
    //     transLongitude: double.parse(body['transLongitude']),
    //     createdAt: body['created_at'],
    //     deviceId: body['deviceId'],
    //     status: body['status'],
    //     riderId: body['riderId'],
    //     deliveryCharge: body['deliveryCharge'],
    //         );
    //         res.add(retieveAlltransac);
    //     }
    return RemainResponse.fromJson(json.decode(reponse.body));
  }catch(stacktrace,error){
     print("Error Occurence. $error and $stacktrace" );
      return RemainResponse.withError("$error");
  }
}
}
