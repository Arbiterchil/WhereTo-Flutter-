

import 'package:WhereTo/Admin/trialSearch/filteringMenu.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerRestaurant.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerTransaCtion.dart';

class ResponseMenuRider{

  final List<GetMenuPerRestaurant> filter;
  final String error;

  ResponseMenuRider(this.filter, this.error);

  ResponseMenuRider.fromJson(List<dynamic> json)
  : filter = 
  json.cast<Map<String,dynamic>>()
  .map((e) => new GetMenuPerRestaurant.fromJson(e))
  .toList(),
  error = "";

  ResponseMenuRider.withError(String errors)
  : filter = List()
  ,error = errors;

}