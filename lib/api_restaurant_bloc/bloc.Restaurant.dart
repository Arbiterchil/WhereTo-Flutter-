import 'dart:async';
import 'dart:convert';


import 'package:WhereTo/MenuRestaurant/restaurant_menu_list.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/bloc.provider.dart';

class Blocrestaurant implements BlocBase{

StreamController<List<RestaurantMenu>> streamApi =StreamController.broadcast();
Sink<List<RestaurantMenu>> get sinkApi =>streamApi.sink;
Stream<List<RestaurantMenu>> get stream =>streamApi.stream;




//   Future<List<RestaurantMenu>> menuList(int id, String restau) async{
//   var response = await ApiCall().getCategory('/getMenuCategory/$id');
//   List<RestaurantMenu> restaurant =[];
//   var body =json.decode(response.body);
//   for(var body in body){
//       RestaurantMenu restaurantMenu =RestaurantMenu(
//       body['id'], body['restaurantName'], body['menuName'], body['description'], body['price'],
//       );
//       if(body['restaurantName'].toString().contains(restau)){
//         restaurant.add(restaurantMenu);
//       }
//   }
//     print("Restaurant length: ${restaurant.length}");
//     sinkApi.add(restaurant);
//     return restaurant;

// }




  @override
  void dispose() {
      streamApi.close();
  }

}