import 'package:WhereTo/Admin/Rider_UnViewRemit/view_unremit.dart';

class UnRemitResponse {



  final List<UnViewRemit> viewRemit;
  final String error;

  UnRemitResponse(this.viewRemit, this.error);

 UnRemitResponse.fromJson(List<dynamic> json)
  : viewRemit = 
  json
  .cast<Map<String,dynamic>>()
  .map((e) => new UnViewRemit.fromJson(e))
  .toList()
  ,error = "" ;
    

  UnRemitResponse.withError(String errorvalue)
  : viewRemit = List(),
  error = errorvalue; 



}