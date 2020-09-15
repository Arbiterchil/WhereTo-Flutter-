import 'package:WhereTo/Admin/A_Rider_Remain/rider_remainApi.dart';
import 'package:WhereTo/Admin/A_Rider_Remain/rider_remainResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class RemainStream {

 final RemainApi _api = RemainApi();
  final BehaviorSubject<RemainResponse> _subject = BehaviorSubject<RemainResponse>();

  getRemianData() async{
    RemainResponse response = await _api.getRemaintran();
    _subject.sink.add(response);
  }

  void drainStream(){_subject.value = null;}
  @mustCallSuper
  void dispose() async{
    
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<RemainResponse> get subject => _subject;

}

final remainStream  = RemainStream();