import 'dart:async';

import 'package:WhereTo/Transaction/SearchMenu/FeaturedRestaurant.dart';
import 'package:WhereTo/Transaction/SearchMenu/filteredMenu.dart';
import 'package:WhereTo/api/api.dart';


class BlocSearch{
  
StreamController<List<FeaturedRestaurant>> streamApi =StreamController.broadcast();
Sink<List<FeaturedRestaurant>> get sinkApi =>streamApi.sink;
Stream<List<FeaturedRestaurant>> get stream =>streamApi.stream;

StreamController<List<FilterRestaurant>> streamMenu =StreamController.broadcast();
Sink<List<FilterRestaurant>> get sinkMenu =>streamMenu.sink;
Stream<List<FilterRestaurant>> get streamMenuApi =>streamMenu.stream;

Future<void> getRest(String query) async {
final response = await ApiCall().getRestarant('/getFeaturedRestaurant');
List<FeaturedRestaurant> search = featuredRestaurantFromJson(response.body);
var filter=search.where((element) => element.restaurantName.toLowerCase().contains(query.toLowerCase()) || 
element.restaurantName.toUpperCase().contains(query.toUpperCase())).toList();
sinkApi.add(filter);
}

Future<void> getmenu(String query) async {
final response = await ApiCall().getRestarant('/getAllMenu');
List<FilterRestaurant> search = filterRestaurantFromJson(response.body);
var filter =search.where((element) =>  element.menuName.contains(query) || element.menuName.toLowerCase().contains(query) ||
 element.restaurantName.contains(query) || element.restaurantName.toLowerCase().contains(query)  
|| element.categoryName.contains(query) || element.categoryName.contains(query)).toList();
sinkMenu.add(filter);
}



void dispose(){
streamApi.close();
streamMenu.close();
}

}