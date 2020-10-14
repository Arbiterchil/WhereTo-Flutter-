

import 'package:WhereTo/Admin/trialSearch/filteringMenu.dart';
import 'package:rxdart/rxdart.dart';
class FutureGetter{

PublishSubject<List<FilteringMenuTrial>> _pub = PublishSubject();


dispose(){

  _pub?.close();

}

}