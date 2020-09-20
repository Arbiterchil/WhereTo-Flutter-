import 'package:WhereTo/Admin/Rider_viewRemit/view_remit.dart';

class RemitResponse {



  final List<ViewRemit> viewRemit;
  final String error;

  RemitResponse(this.viewRemit, this.error);

 RemitResponse.fromJson(List<dynamic> json)
  : viewRemit = 
  json
  .cast<Map<String,dynamic>>()
  .map((e) => new ViewRemit.fromJson(e))
  .toList()
  ,error = "" ;
    

  RemitResponse.withError(String errorvalue)
  : viewRemit = List(),
  error = errorvalue; 



}