
import 'package:WhereTo/Admin/view_saleOurs/view_remitedListStream.dart';

class RemiitanceListResponse{

  final List<RemittanceList> remitList;
  final String error;

  RemiitanceListResponse(this.remitList, this.error);
  RemiitanceListResponse.fromJson(List<RemittanceList> json)
  : remitList = json,error = "";

  RemiitanceListResponse.withError(String error)
  : remitList = List(),
  error = error;
}