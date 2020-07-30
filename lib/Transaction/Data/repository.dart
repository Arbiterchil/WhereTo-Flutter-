import 'dart:convert';

import 'package:WhereTo/Transaction/Data/response.dart';
import 'package:WhereTo/Transaction/MyOrder/getMenuPerTransaction.class.dart';
import 'package:WhereTo/Transaction/MyOrder/getTransactionDetails.class.dart';
import 'package:WhereTo/api/api.dart';

class Repository{

       Future<Response> getData() async{
         try{
    
     
        final response = await ApiCall().viewTransac('/getTransactionDetails/3');
        List<MenuOrderTransaction> me = [];
        
        var body = json.decode(response.body);
        for (var body in body){
            MenuOrderTransaction userclass = MenuOrderTransaction
          (
            id: body["id"],
            name: body["name"],
            restaurantName: body["restaurantName"],
            address: body["address"],
            deviceId: body["deviceId"],
            riderId: body["riderId"],
            deliveryAddress: body["deliveryAddress"],
            );

            me.add(userclass);
        }
        print(me.length);
              
        return Response.fromJson(me);

    }catch(error,stacktrace){

         print("Error Occurence. $error and $stacktrace" );
          return Response.withError("$error");


    }

       }



}