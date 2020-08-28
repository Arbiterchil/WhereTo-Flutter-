import 'package:WhereTo/Admin/Rider_UnViewRemit/view_unremit.dart';

class UnRemitResponse {



  final List<UnViewRemit> viewRemit;
  final String error;

  UnRemitResponse(this.viewRemit, this.error);

 UnRemitResponse.fromJson(json)
  : viewRemit = json,error = "" ;
    

  UnRemitResponse.withError(String errorvalue)
  : viewRemit = List(),
  error = errorvalue; 



}