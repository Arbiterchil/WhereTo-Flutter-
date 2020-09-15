import 'package:WhereTo/Admin/A_RiderRet/rider_viewRets.dart';

class RemainResponse {



  final List<RetieveAlltransac> retieveAlltransac;
  final String error;


  RemainResponse(this.retieveAlltransac, this.error);


 RemainResponse.fromJson(List<RetieveAlltransac> json)
  : retieveAlltransac = json,error = "" ;
    

  RemainResponse.withError(String errorvalue) 
  : retieveAlltransac = List(),
  error = errorvalue; 



}