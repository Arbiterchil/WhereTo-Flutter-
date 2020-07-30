import 'dart:async';

import 'package:WhereTo/MenuRestaurant/categ_type.dart';
import 'package:WhereTo/MenuRestaurant/restaurant_menu_list.dart';
import 'package:WhereTo/Transaction/MyOrder/bloc.provider.dart';
import 'package:WhereTo/Transaction/MyOrder/getMenuPerTransaction.class.dart';
import 'package:WhereTo/api/api.dart';




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


  StreamController<List<MenuOrderTransaction>> menutransactionStream =StreamController.broadcast();
  Sink<List<MenuOrderTransaction>> get transactionType =>menutransactionStream.sink;
  Stream<List<MenuOrderTransaction>> get streamMenuTransaction=> menutransactionStream.stream;
  

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

  Future<void> getMenuTransaction(var id) async{
    final response = await ApiCall().getData('/getMenuPerTransaction/$id');
    final List<MenuOrderTransaction> transaction = menuOrderTransactionFromJson(response.body);
    transactionType.add(transaction);
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
    menutransactionStream.close();
  }

}