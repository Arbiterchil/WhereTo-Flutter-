


import 'package:WhereTo/Rider_ViewMenuTransac/EditMenuRider/MenuforEdit.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerTransaCtion.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerTransaction.dart';
import 'package:rxdart/rxdart.dart';

class EditMenuBloc{

  
  final _menuwithQty = BehaviorSubject<List<MenuForEdit>>.seeded([]);
  Stream<List<MenuForEdit>> get menuGetget => _menuwithQty.stream;

  update(List<MenuForEdit> event) => _menuwithQty.sink.add(event);

  dispose(){
    _menuwithQty.close();
  }

}