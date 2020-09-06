
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_class.dart';

class NewRestaurantResponse {


  final List<NeWRestaurant> feature;
  final String error;

  NewRestaurantResponse(this.feature, this.error);

  NewRestaurantResponse.fromJson(List<dynamic> json)
  : feature = json,error = "" ;
    

  NewRestaurantResponse.withError(String errorvalue)
  : feature = List(),
  error = errorvalue; 
}