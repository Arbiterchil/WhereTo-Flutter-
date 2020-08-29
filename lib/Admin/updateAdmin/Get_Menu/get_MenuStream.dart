import 'package:WhereTo/Admin/updateAdmin/Get_Menu/get_menuResponse.dart';
import 'package:WhereTo/Admin/updateAdmin/get_ApiBoth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class GetMenuStream {

  final ApiMR apiMR = ApiMR();
  final BehaviorSubject<MenuGetResponse> _behaviorSubjectuserz = BehaviorSubject<MenuGetResponse>();

  getMenubyId(int id) async{
 MenuGetResponse menuGetResponse= await apiMR.getMenuusedID(id);
  _behaviorSubjectuserz.sink.add(menuGetResponse);
  }

  void drainStream() {_behaviorSubjectuserz.value = null;}
  @mustCallSuper
  void disopse() async{
    await _behaviorSubjectuserz.drain();
    _behaviorSubjectuserz.close();
  } 

  BehaviorSubject<MenuGetResponse> get subject => _behaviorSubjectuserz;
}
final getMenubyIds = GetMenuStream();