
import 'package:WhereTo/CityLocal/cityprovider.dart';
import 'package:WhereTo/CityLocal/cityresponse.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class CityStream{

  final Cityprovider cityprovider = new Cityprovider();
  final BehaviorSubject<CityResponses> _behaviorSubject = BehaviorSubject<CityResponses>();

  getCity() async{
    CityResponses cityResponses = await cityprovider.getListCity();
    _behaviorSubject.sink.add(cityResponses);
  }

  void drainStream(){_behaviorSubject.value=null;}

  @mustCallSuper
  void dispose() async{
    await _behaviorSubject.drain();
    await _behaviorSubject.close();
  }
  BehaviorSubject<CityResponses> get subject => _behaviorSubject; 

}

final cityStream = CityStream();