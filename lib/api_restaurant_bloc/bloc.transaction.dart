import 'dart:async';

import 'package:WhereTo/MenuRestaurant/categ_type.dart';
import 'package:WhereTo/MenuRestaurant/restaurant_menu_list.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/bloc.provider.dart';



class BlocTransaction implements BlocBase{

  int number =0;
  int val =0;
  int incrementer =0;
  int total =0;
  StreamController<int> streamInt =StreamController.broadcast();
  Sink<int> get sinkInt => streamInt.sink;
  Stream<int> get streamInteger => streamInt.stream;

  // StreamController<int> streamInc =StreamController.broadcast();
  // Sink<int> get sinkInc => streamInc.sink;
  // Stream<int> get streamIntc => streamInc.stream;

 


  StreamController<List<RestaurantMenu>> streamAPI =StreamController.broadcast();
  Sink<List<RestaurantMenu>> get sinkAPI => streamAPI.sink;
  Stream<List<RestaurantMenu>> get streamTrans=>streamAPI.stream;

  StreamController<List<TyepCateg>> streamType =StreamController.broadcast();
  Sink<List<TyepCateg>> get sinkType => streamType.sink;
  Stream<List<TyepCateg>> get streamCategory=>streamType.stream;

  Future<void> menuList(String restau, String menuName, int id) async{
    final response = await ApiCall().getCategory('/getMenuCategory/$id');
    final List<RestaurantMenu> restList = restaurantMenuFromJson(response.body);
    final query = restList
        .where((element) =>
            element.restaurantName.contains(restau) &&
            element.menuName.contains(menuName))
        .toList();
    sinkAPI.add(query);
  }

  Future<void> category() async{
    final response = await ApiCall().getCategory('/getCategories');
    final List<TyepCateg> category = tyepCategFromJson(response.body);
    sinkType.add(category);
  }

  
    add(int total){
    List<int> addItems =[];
    addItems.add(total);
    for(var items in addItems){
    sinkInt.add(items);
    }
  }

  // increment(){
  //   sinkInc.add(++incrementer);
  // }
  // decrement(){
  //   sinkInc.add(--incrementer);
  // }



  @override
  void dispose() {
    streamInt.close();
    // streamInc.close();
    streamAPI.close();
    streamType.close();
  }

}