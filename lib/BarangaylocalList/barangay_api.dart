import 'dart:convert';

import 'package:WhereTo/BarangaylocalList/barangay_class.dart';
import 'package:WhereTo/BarangaylocalList/barangay_response.dart';
import 'package:WhereTo/api/api.dart';

class BaranggayApi{

Future<BaranggayRespone> bararangHoudi() async {

try{
  var response = await  ApiCall().getBararang('/getBarangayList');
  var body = json.decode(response.body);
  // List<Barangays> bararang = [];
  // for(var json in body){
  //   Barangays barangays = Barangays(
  //     id : json["id"],
  //     barangayName : json["barangayName"]);
  //     bararang.add(barangays);
  // }
  return BaranggayRespone.fromJson(body);
  }catch(stacktrace,error){
  print("Error Occurence. $error and $stacktrace" );
  return BaranggayRespone.withError("$error");
}

}

}