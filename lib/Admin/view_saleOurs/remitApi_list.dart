import 'dart:convert';

import 'package:WhereTo/Admin/view_saleOurs/view_remitedListStream.dart';
import 'package:WhereTo/Admin/view_saleOurs/view_reponselist.dart';
import 'package:WhereTo/api/api.dart';

class RemittanceListApi{

Future<RemiitanceListResponse> getRemittanceList(String dateFrom,String dateTo) async{

  try{
    var data ={
      "dateFrom":dateFrom,
      "dateTo": dateTo,
    };
    var response= await ApiCall().getRestaurantSalesReport(data, '/getRemittanceList');
    var jsons = json.decode(response.body);
    List<RemittanceList> remitList = List();
    for(var json in jsons){
      RemittanceList remittanceList = RemittanceList(
         name : json['name'],
    amount  :json['amount'],
    createdAt :json['created_at']
      );
      remitList.add(remittanceList);
    }
    return RemiitanceListResponse.fromJson(remitList);
  }catch(stacktrace,error){
    print("Error Occurence. $error and $stacktrace" );
    return RemiitanceListResponse.withError("$error");
  }

}

}