

import 'package:WhereTo/Admin/updateAdmin/Get_Restaurant/get_RestaurantResponse.dart';
import 'package:WhereTo/Admin/updateAdmin/get_ApiBoth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Restaurantgetss {

  final ApiMR apiMR = ApiMR();
  final BehaviorSubject<RestaurantGetResponse> _behaviorSubjectuserz = BehaviorSubject<RestaurantGetResponse>();

  getrestubyId(int id) async{
 RestaurantGetResponse menuGetResponse= await apiMR.getRestaurantusedID(id);
  _behaviorSubjectuserz.sink.add(menuGetResponse);
  }

  void drainStream() {_behaviorSubjectuserz.value = null;}
@mustCallSuper
  void disopse() async{
    await _behaviorSubjectuserz.drain();
    _behaviorSubjectuserz.close();
  } 

  BehaviorSubject<RestaurantGetResponse> get subject => _behaviorSubjectuserz;
}
final getRestaubyIds = Restaurantgetss();