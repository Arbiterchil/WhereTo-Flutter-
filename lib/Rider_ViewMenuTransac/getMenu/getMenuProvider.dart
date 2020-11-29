

import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuApiTran.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuResponseTran.dart';

class ApiProverGetMenu{
  ApiGetMenuTran apiGetMenuTran = ApiGetMenuTran();
  Future<GetMenuPertransactionResponse> madetranMenu(int id){
    return apiGetMenuTran.detailsMenu(id);
  }
  
}