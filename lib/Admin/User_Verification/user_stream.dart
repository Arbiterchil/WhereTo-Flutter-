
import 'package:WhereTo/Admin/User_Verification/user_api.dart';
import 'package:WhereTo/Admin/User_Verification/user_getterres.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UserStream {

  final UserApi _userapi = UserApi();
  final BehaviorSubject<UserVerified> _behaviorSubjectuser = BehaviorSubject<UserVerified>();


  getViewUnverified() async{
 UserVerified userVerified= await _userapi.getUserUnVerified();
  _behaviorSubjectuser.sink.add(userVerified);
  }

  void drainStream(){_behaviorSubjectuser.value = null;}
  @mustCallSuper
  void dispose() async{
    await _behaviorSubjectuser.drain();
    _behaviorSubjectuser.close();
  }
  BehaviorSubject<UserVerified> get subject => _behaviorSubjectuser;


}

final userVerifying = UserStream();