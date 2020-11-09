import 'package:WhereTo/Rider_ViewMenuTransac/EditMenuRider/editBloc.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerStream.dart';
import 'package:flutter/material.dart';

class AppState extends InheritedWidget{
  
  final AppStateData  data;

  AppState({
    Key key,
    @required this.data,
    @required Widget child
    }):assert(data != null),
    assert(child != null),
    super(key: key,child: child)
    ;
  @override
  bool updateShouldNotify(_)=> false;
    
    static AppStateData of(BuildContext context)=>
    (context.dependOnInheritedWidgetOfExactType<AppState>()).data;}
class AppStateData{

  final EditMenuBloc editMenuBloc;

  AppStateData({
    @required this.editMenuBloc})
    : assert(editMenuBloc !=null)
    ;



} 