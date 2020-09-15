import 'package:WhereTo/Admin/A_RiderRet/rider_viewRets.dart';

class RetrievResponse {

final List<RetieveAlltransac> feature;
  final String error;

  RetrievResponse(this.feature, this.error);

  RetrievResponse.fromJson(List<RetieveAlltransac> json)
  : feature = json,error = "" ;
    

  RetrievResponse.withError(String errorvalue)
  : feature = List(),
  error = errorvalue; 


}