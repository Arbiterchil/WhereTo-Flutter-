


import 'dart:async';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/blocClassMenu.dart';

class BlocisFeatured{
StreamController<List<IsFeatured>> streamApi =StreamController.broadcast();
Sink<List<IsFeatured>> get sinkApi =>streamApi.sink;
Stream<List<IsFeatured>> get stream =>streamApi.stream;


Future<void>getIsFeatured() async{
  final response = await ApiCall().getData('/getAllMenu');
  final List<IsFeatured> transaction = isFeaturedFromJson(response.body);
  List<IsFeatured> filter =transaction.where((element) => element.isFeatured.toStringAsExponential().contains("1")).toList();
  sinkApi.add(filter);
}

void dispose() =>streamApi.close();
}