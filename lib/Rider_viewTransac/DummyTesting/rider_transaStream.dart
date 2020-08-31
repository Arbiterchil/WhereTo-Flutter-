
import 'package:WhereTo/Rider_viewTransac/DummyTesting/rider_transApi.dart';
import 'package:WhereTo/Rider_viewTransac/DummyTesting/rider_transResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class ViewRestuarantNewTRansac{

 final ViewNewTransacApi  _api = ViewNewTransacApi();
  final BehaviorSubject<RiderNewtransaCResponse> _subject = BehaviorSubject<RiderNewtransaCResponse>();

  getViewtransOrder() async{
    RiderNewtransaCResponse riderresponse = await _api.getOrderTransac();
    _subject.sink.add(riderresponse);
  }

  void drainStream(){_subject.value = null;}
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<RiderNewtransaCResponse> get subject => _subject;
  
}

final riderNewTransac = ViewRestuarantNewTRansac();