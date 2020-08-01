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
 OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
                constant =notification.payload.additionalData; 
                
               
                  if(constant != null){
                    print(constant['id'].toString());
                   
                    
                    finalID = constant['id'];

                  }else{
                    print("No Data");
                  }
            
    });
    try{
      if(constant != null){
                    print(constant['id'].toString());
                
                    
                    finalID = constant['id'];

                  }else{
                    print("No Data");
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