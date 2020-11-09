
import 'dart:convert';

import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerTransaction.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuResponseTran.dart';
import 'package:WhereTo/api/api.dart';

class ApiGetMenuTran{

Future<GetMenuPertransactionResponse> detailsMenu(int id) async{

  try{
    var response = await ApiCall().getRestarant('/getMenuPerTransaction/$id');
    return GetMenuPertransactionResponse.fromJson(json.decode(response.body));
  }catch(stacktrace,error){
    return GetMenuPertransactionResponse.withError("$error");
  }
}
}