import 'package:WhereTo/BarangaylocalList/barangay_api.dart';
import 'package:WhereTo/BarangaylocalList/barangay_provider.dart';
import 'package:WhereTo/BarangaylocalList/barangay_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BarangayStream{

final BarangayProvider _barangayProvider = BarangayProvider();
final BehaviorSubject<BaranggayRespone> _behaviorSubject = BehaviorSubject<BaranggayRespone>();


getBarangayListFormDb() async{
  BaranggayRespone baranggayRespone = await _barangayProvider.getBaararangSaifon();
  _behaviorSubject.sink.add(baranggayRespone);
}

void drainStreamData(){_behaviorSubject.value = null;}

@mustCallSuper
void dispose() async{
  await _behaviorSubject.drain();
  _behaviorSubject.close();
}
BehaviorSubject<BaranggayRespone> get subject => _behaviorSubject;

}
final bararangStream = BarangayStream();