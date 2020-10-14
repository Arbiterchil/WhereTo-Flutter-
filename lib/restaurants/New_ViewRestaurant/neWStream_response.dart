
import 'package:WhereTo/restaurants/New_ViewRestaurant/NewRestaurant_Provider.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/newRetaurant_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class NewRestaurantStream {

 final NewRestaurantprovider newRes = NewRestaurantprovider();
  final BehaviorSubject<NewRestaurantResponse> _subject = BehaviorSubject<NewRestaurantResponse>();

  getFeaturedViewRestaurant(String cityId) async{
    NewRestaurantResponse riderresponse = await newRes.getNewFeaturing(cityId);
    _subject.sink.add(riderresponse);
  }

  void drainStream(){_subject.value = null;}
  @mustCallSuper
  void dispose() async{
    
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<NewRestaurantResponse> get subject => _subject;

}

final streamRestaurantsFeatured  = NewRestaurantStream();