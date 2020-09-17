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
        for(var body in body){
            RetieveAlltransac retieveAlltransac = RetieveAlltransac(
        id: body['id'],
        name: body['name'],
        contactNumber: body['contactNumber'],
        barangayName: body['barangayName'],
        restaurantName: body['restaurantName'],
        restoLatitude: body['restoLatitude'] ,
        restoLongitude:body['restoLongitude'] ,
        transLatitude: body['transLatitude'],
        transLongitude: body['transLongitude'],
        createdAt: body['created_at'],
        deviceId: body['deviceId'],
        riderId: body['riderId'],
        status: body['status'],
        deliveryCharge: body['deliveryCharge'],
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