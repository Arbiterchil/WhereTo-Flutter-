import 'dart:convert';

import 'package:WhereTo/Admin/Admin_Biew/adminviewResonponse.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';

class AdminApiFromResponses{

  
  Future<AdminViewResponses> getTranssac() async{
    var id = UserGetPref().idSearch;
  try{
  var res = await ApiCall().viewUnremittedList('/ordersOfTheDay/$id');
  return AdminViewResponses.fromJson(json.decode(res.body));
  }catch(stack,error){
  return AdminViewResponses.withError("$error");
  }

  }

}