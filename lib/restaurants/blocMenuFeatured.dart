


import 'dart:async';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/restaurants/blocClassMenu.dart';
import 'package:rxdart/rxdart.dart';

class BlocisFeatured{

PublishSubject<List<IsFeatured>> _publishSubject =PublishSubject();
Stream<List<IsFeatured>> get sinkAllMenu =>_publishSubject.stream;

Future<void>getIsFeatured() async{
  final response = await ApiCall().getData('/getAllMenu');
  final List<IsFeatured> transaction = isFeaturedFromJson(response.body);
  String menuCoordinatesFromID;
  String coordinates;
  String userCoordinatesFromID;
  String userCoordinates;
  transaction.forEach((element) async{
    menuCoordinatesFromID ="${element.latitude},${element.longitude}";
    coordinates =await CoordinatesConverter().addressByCity(menuCoordinatesFromID);
    userCoordinatesFromID =await ID().getPosition();
    userCoordinates =await CoordinatesConverter().addressByCity(userCoordinatesFromID);
  });
  List<IsFeatured> filter =transaction.where((element) => element.isFeatured.toString().contains("1") && userCoordinates ==coordinates).toList();
  _publishSubject.sink.add(filter);
}

void dispose() =>_publishSubject.close();
}