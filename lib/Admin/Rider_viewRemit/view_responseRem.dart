import 'package:WhereTo/Admin/Rider_viewRemit/view_remit.dart';

class RemitResponse {



  final List<ViewRemit> viewRemit;
  final String error;

  RemitResponse(this.viewRemit, this.error);

 RemitResponse.fromJson(json)
  : viewRemit = json,error = "" ;
    

  RemitResponse.withError(String errorvalue)
  : viewRemit = List(),
  error = errorvalue; 



}