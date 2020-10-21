


import 'dart:async';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/restaurants/blocClassMenu.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlocisFeatured{

PublishSubject<List<IsFeatured>> _publishSubject =PublishSubject();
Stream<List<IsFeatured>> get sinkAllMenu =>_publishSubject.stream;

Future<void>getIsFeatured() async{
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var fin = localStorage.getString('city');
  final response = await ApiCall().getData('/getAllMenu/$fin');
  final List<IsFeatured> transaction = isFeaturedFromJson(response.body);
  
  List<IsFeatured> filter =transaction.where((element) => element.isFeatured.toString().contains("1")).toList();
  _publishSubject.sink.add(filter);
}

void dispose() =>_publishSubject.close();
}