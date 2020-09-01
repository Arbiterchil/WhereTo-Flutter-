import 'dart:convert';

import 'package:WhereTo/Admin/A_RiderRet/rider_responseRet.dart';
import 'package:WhereTo/Admin/A_RiderRet/rider_viewRets.dart';
import 'package:WhereTo/api/api.dart';

class RetriveTransacApi {



  Future<RetrievResponse> getTransactionOrder() async {
      
    try{  

        var response = await ApiCall().getTransactionDetails('/getTransactionDetails');
        List<RetieveAlltransac> res = [];

        var body = json.decode(response.body);
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

        return RetrievResponse.fromJson(res);  
        
    }catch(error,stacktrace){
          print("Error Occurence. $error and $stacktrace" );
          return RetrievResponse.withError("$error");
    }
  }

}