

import 'package:WhereTo/Rider/RiderDetails/riderdetails.dart';

class RiderDetailsResponse{

  final List<RiderDetailsTransac> responseDetail;
  final String error;

  RiderDetailsResponse(this.responseDetail, this.error);

  RiderDetailsResponse.fromJson(List<dynamic> json)
  : responseDetail = 
  json.cast<Map<String,dynamic>>()
  .map((e) => new RiderDetailsTransac.fromJson(e))
  .toList(),error = "";

  RiderDetailsResponse.withError(String errors)
  : responseDetail = List()
  ,error = errors;

}