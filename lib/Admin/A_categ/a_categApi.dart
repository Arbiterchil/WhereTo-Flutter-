import 'dart:convert';

import 'package:WhereTo/Admin/A_categ/a_apicateg.dart';
import 'package:WhereTo/Admin/A_categ/a_categ.dart';
import 'package:WhereTo/api/api.dart';

class CategoriesApimenu{

Future<CategoryResponseforMenu> getMenuCategory() async{

  try{

     var respon = await ApiCall().getCategory('/getCategories');
    var bararang = json.decode(respon.body);
    List<Categories> categs = List();
    for(var json in bararang){
      Categories categories = Categories(
        id: json['id'],
        categoryName :json['categoryName']
      );
      categs.add(categories);
    }
    return CategoryResponseforMenu.fromJson(categs);
  }catch(stacktrace,error){
      print("Error Occurence. $error and $stacktrace" );
      return CategoryResponseforMenu.withError("$error");
  } 

}

}