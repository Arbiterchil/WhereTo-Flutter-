import 'dart:convert';

import 'package:WhereTo/Admin/A_categ/a_apicateg.dart';
import 'package:WhereTo/Admin/A_categ/a_categ.dart';
import 'package:WhereTo/api/api.dart';

class CategoriesApimenu{

Future<CategoryResponseforMenu> getMenuCategory() async{

  try{

     var respon = await ApiCall().getCategory('/getCategories');
    return CategoryResponseforMenu.fromJson(json.decode(respon.body));
  }catch(stacktrace,error){
      print("Error Occurence. $error and $stacktrace" );
      return CategoryResponseforMenu.withError("$error");
  } 

}

}