import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/newRetaurant_api.dart';

class NewRestaurantprovider{

NewRestaurantApi newRestaurantApi = NewRestaurantApi();

 Future<NewRestaurantResponse> getNewFeaturing(String cityId){
   return newRestaurantApi.getFeaturedRestaurant(cityId);
 } 


}