import 'dart:async';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/address.class.dart';
import 'package:rxdart/rxdart.dart';

import 'google-key.dart';

class AddressBloc{
  PublishSubject<List<Deliveryaddress>> publishSubject =PublishSubject();
  Stream<List<Deliveryaddress>> get sinkDeliver =>publishSubject.stream;
  
  Future<void> getDeliveryAddress() async{
    var id =await ID().getId();
    final response = await ApiCall().getRestarant('/getUserDeliveryAddress/$id');
    List<Deliveryaddress> delivery =deliveryaddressFromJson(response.body);
    publishSubject.sink.add(delivery);
  }



  dispose(){
    publishSubject.close();
  }

}