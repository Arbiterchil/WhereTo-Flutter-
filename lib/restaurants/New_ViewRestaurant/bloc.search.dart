import 'dart:async';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/FeaturedRestaurant.dart';
import 'package:WhereTo/restaurants/searchRestaurant.dart';

class BlocSearch{
  
StreamController<List<FeaturedRestaurant>> streamApi =StreamController.broadcast();
Sink<List<FeaturedRestaurant>> get sinkApi =>streamApi.sink;
Stream<List<FeaturedRestaurant>> get stream =>streamApi.stream;

Future<void> getRest(String query) async {
final response = await ApiCall().getRestarant('/getFeaturedRestaurant');
List<FeaturedRestaurant> search = featuredRestaurantFromJson(response.body);
var filter=search.where((element) => element.restaurantName.toLowerCase().contains(query.toLowerCase()) || 
element.restaurantName.toUpperCase().contains(query.toUpperCase())).toList();
sinkApi.add(filter);
}



void dispose(){
streamApi.close();
}

}