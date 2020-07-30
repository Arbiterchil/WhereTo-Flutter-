import 'dart:async';
import 'dart:convert';


import 'package:WhereTo/MenuRestaurant/restaurant_menu_list.dart';
import 'package:WhereTo/Transaction/MyOrder/bloc.provider.dart';
import 'package:WhereTo/api/api.dart';


class Blocrestaurant implements BlocBase{

StreamController<List<RestaurantMenu>> streamApi =StreamController.broadcast();
Sink<List<RestaurantMenu>> get sinkApi =>streamApi.sink;
Stream<List<RestaurantMenu>> get stream =>streamApi.stream;








  @override
  void dispose() {
      // streamApi.close();
  }

}