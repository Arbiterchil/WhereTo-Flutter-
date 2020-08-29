import 'package:WhereTo/Admin/updateAdmin/Get_Restaurant/get_Restaurant.dart';

class RestaurantGetResponse {



  final RestaurantGets restaurantGets;
  final String error;

  RestaurantGetResponse(this.restaurantGets, this.error);

 RestaurantGetResponse.fromJson(json)
  : restaurantGets = RestaurantGets.fromJson(json),error = "" ;
    

  RestaurantGetResponse.withError(String errorvalue)
  : restaurantGets = RestaurantGets(),
  error = errorvalue; 



}