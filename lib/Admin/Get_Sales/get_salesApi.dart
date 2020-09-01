import 'dart:convert';

import 'package:WhereTo/Admin/Get_Sales/get_SaleResponses.dart';
import 'package:WhereTo/Admin/Get_Sales/get_saleClass.dart';
import 'package:WhereTo/api/api.dart';

class GetSaleApi {



  Future<GetSaleResponse> getRestaurantSalesReport(String datexTo, String datexFrom, int idx) async {
     
        try {
          var data = 
      {
        "restaurantId": idx,
        "dateFrom": datexTo,
        "dateTo": datexFrom
      };
          var response = await ApiCall().getRestaurantSalesReport(data,'/getRestaurantSalesReport');
          List<GetSalerepo> saleas = [];
          var body = json.decode(response.body);
          for(var json in body){
          GetSalerepo gets =  GetSalerepo(
             id: json["id"],
        deliveryAddress: json["deliveryAddress"],
        menuName: json["menuName"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
          );
          saleas.add(gets);
          }
                  
       return GetSaleResponse.fromJson(saleas);  

    }catch(error,stacktrace){
          print("Error Occurence. $error and $stacktrace" );
          return GetSaleResponse.withError("$error");
    }

  }

}