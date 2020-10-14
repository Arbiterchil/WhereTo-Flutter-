import 'dart:async';

import 'package:WhereTo/Transaction/SearchMenu/FeaturedRestaurant.dart';
import 'package:WhereTo/Transaction/SearchMenu/filteredMenu.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:rxdart/rxdart.dart';


class BlocSearch{
  


PublishSubject<List<FeaturedRestaurant>> _publishSubjectFeautured =PublishSubject();
Stream<List<FeaturedRestaurant>> get sinkSubjectFeatured =>_publishSubjectFeautured.stream;


PublishSubject<List<FilterRestaurant>> _publishSubjectFilter =PublishSubject();
Stream<List<FilterRestaurant>> get sinkSubjectFilter =>_publishSubjectFilter.stream;



Future<void> getRest(String query) async {
final response = await ApiCall().getRestarant('/getFeaturedRestaurant');
List<FeaturedRestaurant> search = featuredRestaurantFromJson(response.body);
var filter=search.where((element) => element.restaurantName.toLowerCase().contains(query.toLowerCase()) || 
element.restaurantName.toUpperCase().contains(query.toUpperCase())).toList();
_publishSubjectFeautured.sink.add(filter);
}

Future<void> getmenu(String query) async {
final response = await ApiCall().getRestarant('/getAllMenu');
List<FilterRestaurant> search = filterRestaurantFromJson(response.body);
var filter =search.where((element) =>  element.menuName.contains(query) || element.menuName.toLowerCase().contains(query) || element.menuName.toUpperCase().contains(query) ||
 element.restaurantName.contains(query) || element.restaurantName.toLowerCase().contains(query) || element.restaurantName.toUpperCase().contains(query) 
|| element.categoryName.contains(query) || element.categoryName.toLowerCase().contains(query) || element.categoryName.toUpperCase().contains(query)).toList();
_publishSubjectFilter.sink.add(filter);
}



void dispose(){
_publishSubjectFeautured.close();
_publishSubjectFilter.close();
}

}