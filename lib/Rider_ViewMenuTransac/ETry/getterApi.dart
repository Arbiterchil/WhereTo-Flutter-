

import 'dart:convert';

import 'package:WhereTo/Rider_ViewMenuTransac/ETry/state.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerResponse.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerRestaurant.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerTransaCtion.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';

class DataProvider{

  static final DataProvider _dataProvider = DataProvider._pref();
  DataProvider._pref(); 
  factory DataProvider()=> _dataProvider;


  Future<State> getMenuByName(String query) async{
    
    var idSearchcity = UserGetPref().restaurntIdEdit;
   
       var response = await ApiCall().getRestarant('/getMenuPerRestaurant/$idSearchcity');

       if(response.statusCode == 200){
        var vin = getMenuPerRestaurantFromJson(response.body.toString());

    var vex = vin.where((element) => element.menuName.toLowerCase().contains(query)
    || element.menuName.toUpperCase().contains(query)).toList();
      
      return State<ResponseMenuRider>.success(ResponseMenuRider.fromJson(vex));
       }else{
 return State<String>.error(response.statusCode.toString());
       }
    
   
  }

}