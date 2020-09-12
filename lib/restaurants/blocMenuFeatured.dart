


import 'dart:async';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/blocClassMenu.dart';
import 'package:rxdart/rxdart.dart';

class BlocisFeatured{

PublishSubject<List<IsFeatured>> _publishSubject =PublishSubject();
Stream<List<IsFeatured>> get sinkAllMenu =>_publishSubject.stream;

Future<void>getIsFeatured() async{
  final response = await ApiCall().getData('/getAllMenu');
  final List<IsFeatured> transaction = isFeaturedFromJson(response.body);
  List<IsFeatured> filter =transaction.where((element) => element.isFeatured.toString().contains("1")).toList();
  _publishSubject.sink.add(filter);
}

void dispose() =>_publishSubject.close();
}