import 'dart:async';


import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/blocCategory.class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/blocMenu.class.dart';

class MenuBloc{



// StreamController<List<Menu>> streamApi =StreamController.broadcast();
// Sink<List<Menu>> get sinkApi =>streamApi.sink;
// Stream<List<Menu>> get stream =>streamApi.stream;

StreamController<List<Category>> _streamCateg =StreamController.broadcast();
Sink<List<Category>> get sinkCateg =>_streamCateg.sink;
Stream<List<Category>> get streamCateg =>_streamCateg.stream;

getRest(String query, String id) async {
final response = await ApiCall().getRestarant('/getMenuCategory/$id');
List<Menu> search = menuFromJson(response.body);
List<dynamic> filtered =search.where((element) => element.restaurantName.contains(query)).toList();
return filtered;
}
  
Future<void> getCateg() async {
final response = await ApiCall().getRestarant('/getCategories');
List<Category> search = categoryFromJson(response.body);
sinkCateg.add(search);
}


  void dispose(){
    // streamApi.close();
    _streamCateg.close();
  }
}