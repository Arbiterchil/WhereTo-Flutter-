import 'package:WhereTo/Transaction/SearchMenu/filteredMenu.dart';
import 'dart:async';

import 'package:WhereTo/api/api.dart';

class BlocRestaurant{
StreamController<List<FilterRestaurant>> streamMenu =StreamController.broadcast();
Sink<List<FilterRestaurant>> get sinkMenu =>streamMenu.sink;
Stream<List<FilterRestaurant>> get streamMenuApi =>streamMenu.stream;

Future<void> getmenu(String query) async {
final response = await ApiCall().getRestarant('/getAllMenu');
List<FilterRestaurant> search = filterRestaurantFromJson(response.body);
var filter =search.where((element) =>  element.menuName.contains(query) || element.menuName.toLowerCase().contains(query) ||
 element.restaurantName.contains(query) || element.restaurantName.toLowerCase().contains(query)  
|| element.categoryName.contains(query) || element.categoryName.contains(query)).toList();
sinkMenu.add(filter);
}

void dispose() =>streamMenu..close();

}