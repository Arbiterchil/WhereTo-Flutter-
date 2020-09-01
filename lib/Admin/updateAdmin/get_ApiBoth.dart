import 'dart:convert';

import 'package:WhereTo/Admin/updateAdmin/Get_Menu/get_menuResponse.dart';
import 'package:WhereTo/Admin/updateAdmin/Get_Restaurant/get_RestaurantResponse.dart';
import 'package:WhereTo/api/api.dart';

class ApiMR {

  Future<MenuGetResponse> getMenuusedID(int id) async {
  try{
    var reponse = await ApiCall().getMenu('/getMenuById/$id');
    var body = json.decode(reponse.body);
    return MenuGetResponse.fromJson(body);
  }catch(stacktrace,error){
     print("Error Occurence. $error and $stacktrace" );
      return MenuGetResponse.withError("$error");
  }
}

Future<RestaurantGetResponse> getRestaurantusedID(int id) async {
  try{
    var reponse = await ApiCall().getMenu('/getRestaurantById/$id');
    var body = json.decode(reponse.body);
    return RestaurantGetResponse.fromJson(body);
  }catch(stacktrace,error){
     print("Error Occurence. $error and $stacktrace" );
      return RestaurantGetResponse.withError("$error");
  }
}

}