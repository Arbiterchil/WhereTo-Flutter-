import 'package:WhereTo/Admin/A_RiderRet/rider_viewRets.dart';

class RemainResponse {



  final List<RetieveAlltransac> retieveAlltransac;
  final String error;


  RemainResponse(this.retieveAlltransac, this.error);


 RemainResponse.fromJson(List<dynamic> json)
  : retieveAlltransac = 
  json.cast<Map<String,dynamic>>().map((e) => new RetieveAlltransac.fromJson(e)).toList()
  ,error = "" ;
    

  RemainResponse.withError(String errorvalue) 
  : retieveAlltransac = List(),
  error = errorvalue; 



}