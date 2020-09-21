import 'package:WhereTo/Admin/A_categ/a_categ.dart';

class CategoryResponseforMenu{

final List<Categories> categs;
final String error;

  CategoryResponseforMenu(this.categs, this.error);

  CategoryResponseforMenu.fromJson(List<dynamic> json)
  : categs= 
  json.cast<Map<String,dynamic>>().map((e) => new Categories.fromJson(e)).toList()
  ,error ="";
  CategoryResponseforMenu.withError(String error)
  : categs = List(),
  error= error;
}