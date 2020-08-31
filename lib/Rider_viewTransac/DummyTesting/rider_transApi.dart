
import 'dart:convert';

import 'package:WhereTo/Rider_viewTransac/DummyTesting/response_NewriderbyId.dart';
import 'package:WhereTo/Rider_viewTransac/DummyTesting/rider_newtrans.dart';
import 'package:WhereTo/Rider_viewTransac/DummyTesting/rider_transResponse.dart';
import 'package:WhereTo/api/api.dart';

class ViewNewTransacApi{

Future<RiderNewtransaCResponse> getOrderTransac() async{

  try{
    var response = await ApiCall().getTransactionDetails('/getTransactionDetails');
    var body = json.decode(response.body);
    List<ViewtransacNeWRestaurant> views=[];
     for(var json in body){
      ViewtransacNeWRestaurant viewtransacNeWRestaurant = ViewtransacNeWRestaurant(

       id: json["id"],
        name: json["name"],
        contactNumber: json["contactNumber"],
        barangayName: json["barangayName"],
        restaurantName: json["restaurantName"],
        address: json["address"],
        deliveryAddress: json["deliveryAddress"],
        createdAt:json["created_at"],
        deviceId: json["deviceId"],
        riderId: json["riderId"],
        status: json["status"],
        deliveryCharge: json["deliveryCharge"],

      );
      views.add(viewtransacNeWRestaurant);
     }
    return RiderNewtransaCResponse.fromJson(views);
  }catch(stackTrace,error){
     print("Error Occurence. $error and $stackTrace" );
          return RiderNewtransaCResponse.withError("$error");
  }

}




}