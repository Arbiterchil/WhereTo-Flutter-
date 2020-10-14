import 'dart:convert';

import 'package:WhereTo/CityLocal/cityresponse.dart';
import 'package:WhereTo/api/api.dart';

class CityApi{

Future<CityResponses> cityLocals() async{
  try{
    var cityresponse = await ApiCall().getBararang('/getCity');
    return CityResponses.fromJson(json.decode(cityresponse.body));
  }catch(stacktrace,error){
    print("Error Occurence. $error and $stacktrace" );
    return CityResponses.withError("$error");
  }
}

}