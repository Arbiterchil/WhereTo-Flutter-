
import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';

class RiderMenuResponse{


  final List<RiverMenu> rivermenu;
  final String error;

  RiderMenuResponse(this.rivermenu, this.error);
  
  RiderMenuResponse.fromJson(json)
  : rivermenu = json,error = "";

  RiderMenuResponse.withError(String value)
  : rivermenu = List(),
  error = value;


}