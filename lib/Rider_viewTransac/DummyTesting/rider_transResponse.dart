
import 'package:WhereTo/Rider_viewTransac/DummyTesting/rider_newtrans.dart';

class RiderNewtransaCResponse{

final List<ViewtransacNeWRestaurant> viewNewRes;
  final String error;

  RiderNewtransaCResponse(this.viewNewRes, this.error);

  RiderNewtransaCResponse.fromJson(json)
  : viewNewRes = json,error = "" ;
    

  RiderNewtransaCResponse.withError(String errorvalue)
  : viewNewRes = List(),
  error = errorvalue; 
}