import 'package:WhereTo/Rider_ViewMenuTransac/ETry/getterApi.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/ETry/state.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerResponse.dart';

class Reposit{


  static final Reposit _reposit = Reposit._prob();
  Reposit._prob();
  factory Reposit() =>_reposit;

  DataProvider dataProvider = DataProvider();

  Future<State> dataget(query)=> dataProvider.getMenuByName(query);
  
}