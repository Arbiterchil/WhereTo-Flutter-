

import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerApi.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerResponse.dart';

class ResponseProviderRider{

  ResponseMenuApiRidr responseMenuApiRidr = ResponseMenuApiRidr();
  Future<ResponseMenuRider> getResposneRiderMenu(){
   return responseMenuApiRidr.detailsMenuRider();
  }
}