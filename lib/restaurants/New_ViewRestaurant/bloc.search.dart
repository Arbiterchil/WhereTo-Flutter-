import 'dart:async';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/searchRestaurant.dart';

class BlocSearch{
  
StreamController<List<SearchDeposition>> streamApi =StreamController.broadcast();
Sink<List<SearchDeposition>> get sinkApi =>streamApi.sink;
Stream<List<SearchDeposition>> get stream =>streamApi.stream;

Future<void> getRest(String query) async {
final response = await ApiCall().getRestarant('/getFeaturedRestaurant');
List<SearchDeposition> search = searchDepoFromJson(response.body);
var filter=search.where((element) => element.restaurantName.toLowerCase().contains(query.toLowerCase()) || 
element.restaurantName.toUpperCase().contains(query.toUpperCase())).toList();
sinkApi.add(filter);
}



void dispose(){
streamApi.close();
}

}