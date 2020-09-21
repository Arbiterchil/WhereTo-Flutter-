
import 'package:WhereTo/Admin/view_saleOurs/view_remitedListStream.dart';

class RemiitanceListResponse{

  final List<RemittanceList> remitList;
  final String error;

  RemiitanceListResponse(this.remitList, this.error);
  RemiitanceListResponse.fromJson(List<dynamic> json)
  : remitList = 
  json
  .cast<Map<String,dynamic>>()
  .map((e) => new RemittanceList.fromJson(e))
  .toList()
  ,error = "";

  RemiitanceListResponse.withError(String error)
  : remitList = List(),
  error = error;
}