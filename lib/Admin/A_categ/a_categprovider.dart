import 'package:WhereTo/Admin/A_categ/a_apicateg.dart';
import 'package:WhereTo/Admin/A_categ/a_categApi.dart';

class CategProvider{

CategoriesApimenu _categoriesApimenu = CategoriesApimenu();
Future<CategoryResponseforMenu> getMenuJudhayawa(){
  return _categoriesApimenu.getMenuCategory();
}

}