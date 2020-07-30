import 'dart:convert';
import 'package:WhereTo/Rider_ViewMenuTransac/riderMenu_reponse.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_reponse.dart';
import 'package:WhereTo/api/api.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RiderApi {
  

  int index;
  var constant;
  var finalID;
  bool checkValue = true;

  Future<RiderResponse> getViewTransac() async{

    try{
      SharedPreferences local = await SharedPreferences.getInstance();
        
          var check = local.getBool("cuurentIdtrans");
        if(check !=null ){

            if(check){
                  finalID = local.getString("menuplustrans");
                  print(finalID);

            }else{
              print("No Id Getter.");
            }

        }
        print(finalID);
        final response = await ApiCall().viewTransac('/getTransactionDetails/$finalID');
        List<RiderViewClass> riderme = [];
        
        var body = json.decode(response.body);
        for (var body in body){
            RiderViewClass riderViewClass = RiderViewClass
          (
            id: body["id"],
            name: body["name"],
            restaurantName: body["restaurantName"],
            address: body["address"],
            deviceId: body["deviceId"],
            riderId: body["riderId"],
            deliveryAddress: body["deliveryAddress"],
            );

            riderme.add(riderViewClass);
        }
        print(riderme.length);
              
        return RiderResponse.fromJson(riderme);

    }catch(error,stacktrace){

         print("Error Occurence. $error and $stacktrace" );
          return RiderResponse.withError("$error");


    }



  }




}