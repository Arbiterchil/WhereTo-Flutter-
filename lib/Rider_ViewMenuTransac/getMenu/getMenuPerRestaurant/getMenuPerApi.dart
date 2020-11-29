
import 'dart:convert';

import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerResponse.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerTransaCtion.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';

class ResponseMenuApiRidr{

  

  Future<ResponseMenuRider> detailsMenuRider() async{

    var id = UserGetPref().restaurntIdEdit;

  try{
  
    var response = await ApiCall().getRestarant('/getMenuPerRestaurant/$id');
    
    return ResponseMenuRider.fromJson(json.decode(response.body));

  }catch(stacktrace,error){
    return ResponseMenuRider.withError("$error");
  }
}



}