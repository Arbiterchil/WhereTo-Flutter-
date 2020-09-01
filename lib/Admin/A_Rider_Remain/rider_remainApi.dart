
import 'dart:convert';

import 'package:WhereTo/Admin/A_RiderRet/rider_viewRets.dart';
import 'package:WhereTo/Admin/A_Rider_Remain/rider_remainResponse.dart';
import 'package:WhereTo/api/api.dart';

class RemainApi {

  Future<RemainResponse> getRemaintran(String id) async {
  try{
    var reponse = await ApiCall().getTransactionDetailsById('/getTransactionDetailsById/$id');
    var body = json.decode(reponse.body);
    List<RetieveAlltransac> res = [];
        for(var json in body){
            RetieveAlltransac retieveAlltransac = RetieveAlltransac(
        id: json["id"],
        name: json["name"],
        contactNumber: json["contactNumber"],
        barangayName: json["barangayName"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        deliveryAddress: json["deliveryAddress"],
        createdAt: json["created_at"],
        deviceId: json["deviceId"],
        riderId: json["riderId"],
        status: json["status"],
        deliveryCharge: json["deliveryCharge"],
            );
            res.add(retieveAlltransac);
        }
    return RemainResponse.fromJson(res);
  }catch(stacktrace,error){
     print("Error Occurence. $error and $stacktrace" );
      return RemainResponse.withError("$error");
  }
}
}
