
import 'dart:convert';

import 'package:WhereTo/Rider/RiderDetails/ridrDetailsresonse.dart';
import 'package:WhereTo/api/api.dart';

class RiderDetailApi{

Future<RiderDetailsResponse> details(int id) async{

  try{
    var response = await ApiCall().getRestarant('/getTransactionDetailsById/$id');
    return RiderDetailsResponse.fromJson(json.decode(response.body));
  }catch(stacktrace,error){
    return RiderDetailsResponse.withError("$error");
  }
}

}