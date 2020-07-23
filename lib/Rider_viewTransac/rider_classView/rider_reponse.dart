
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';

class RiderResponse {



  final List<RiderViewClass> riderview;
  final String error;

  RiderResponse(this.riderview, this.error);

 RiderResponse.fromJson(json)
  : riderview = json,error = "" ;
    

  RiderResponse.withError(String errorvalue)
  : riderview = List(),
  error = errorvalue; 



}