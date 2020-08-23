import 'dart:async';


import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/blocMenu.class.dart';

class MenuBloc{



StreamController<List<Menu>> _streamApi =StreamController.broadcast();
Sink<List<Menu>> get sinkApi =>_streamApi.sink;
Stream<List<Menu>> get stream =>_streamApi.stream;

Future<void> getRest(String query) async {
final response = await ApiCall().getRestarant('/getAllMenu');
List<Menu> search = menuFromJson(response.body);

}



  void dispose(){
    _streamApi.close();
  }
}