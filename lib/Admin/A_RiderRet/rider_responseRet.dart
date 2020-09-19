import 'package:WhereTo/Admin/A_RiderRet/rider_viewRets.dart';

class RetrievResponse {

final List<RetieveAlltransac> feature;
  final String error;

  RetrievResponse(this.feature, this.error);

  RetrievResponse.fromJson(List<dynamic> jsons)
  : feature = 
  jsons.cast<Map<String,dynamic>>()
  .map((features) =>
  new RetieveAlltransac.fromJson(features))
  .toList()
  ,error = "" ;

  RetrievResponse.withError(String errorvalue)
  : feature = List(),
  error = errorvalue; 


}