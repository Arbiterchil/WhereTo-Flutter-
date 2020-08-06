import 'dart:convert';

import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';
import 'package:WhereTo/Transaction/Data/response.dart';
import 'package:WhereTo/Transaction/MyOrder/getMenuPerTransaction.class.dart';
import 'package:WhereTo/Transaction/MyOrder/getTransactionDetails.class.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/api/api.dart';

class Repository{

       Future<Response> getData() async{
         try{
    
     
        final response = await ApiCall().viewTransac('/viewCurrentOrders/3');
        List<ViewUserOrder> riderme = [];
        
        final body = json.decode(response.body);
        for (var body in body){
            ViewUserOrder riderViewClass = ViewUserOrder
          (
            id: body["id"],
            restaurantName: body["restaurantName"],
            address: body["address"],
            deliveryAddress: body["deliveryAddress"],
            riderId: body["riderId"],
            status: body['status'],
            );

            riderme.add(riderViewClass);
        }
        print(riderme.length);
              
        return Response.fromJson(riderme);

    }catch(error,stacktrace){

         print("Error Occurence. $error and $stacktrace" );
          return Response.withError("$error");


    }

       }



}