

import 'package:WhereTo/Admin/A_categ/a_apicateg.dart';
import 'package:WhereTo/Admin/A_categ/a_categApi.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CategoryMenuIsStream{

 final CategoriesApimenu _categoriesApimenu = CategoriesApimenu();
 final BehaviorSubject<CategoryResponseforMenu> _beSubjecting = BehaviorSubject<CategoryResponseforMenu>();

  getMenuCategoryAll() async{
    CategoryResponseforMenu categoryResponseforMenu = 
    await _categoriesApimenu.getMenuCategory();
    _beSubjecting.sink.add(categoryResponseforMenu);
  }

  void drainStream(){_beSubjecting.value = null;}
  @mustCallSuper
  void dispose() async{
    await _beSubjecting.drain();
    _beSubjecting.close();    
  }
  BehaviorSubject<CategoryResponseforMenu> get subject => _beSubjecting;


}
final categorymenuStream = CategoryMenuIsStream();