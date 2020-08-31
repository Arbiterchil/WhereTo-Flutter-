import 'package:WhereTo/Admin/Rider_viewRemit/view_remit.dart';
import 'package:WhereTo/Admin/Rider_viewRemit/view_responseRem.dart';
import 'package:WhereTo/Admin/User_Verification/user_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class RemitStream{

  final UserApi userApi = UserApi();
  final BehaviorSubject<RemitResponse> behaviorSubject = BehaviorSubject<RemitResponse>();

  getViewRemits() async{
    RemitResponse remitResponse = await userApi.getRemitImages();
    behaviorSubject.sink.add(remitResponse);

  }

   void drainStream() {behaviorSubject.value = null;}
  @mustCallSuper
  void disopse() async{
    await behaviorSubject.drain();
    behaviorSubject.close();
  } 

  BehaviorSubject<RemitResponse> get subject => behaviorSubject;

}

final remittanceStream = RemitStream();