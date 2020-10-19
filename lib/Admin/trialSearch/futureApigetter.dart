

import 'package:WhereTo/Admin/trialSearch/filteringMenu.dart';
import 'package:WhereTo/api/api.dart';
import 'package:rxdart/rxdart.dart';
class FutureGetter{

PublishSubject<List<FilteringMenuTrial>> _pub = PublishSubject();
Stream<List<FilteringMenuTrial>> get sinkstream => _pub.stream;

Future getMenuAll(String id,String term) async{
final fin = await ApiCall().getRestarant('/getAllMenu/$id');
List<FilteringMenuTrial> searching = filteringMenuTrialFromJson(fin.body);
var filterMenu = searching.where((element) => element.menuName.contains(term) || element.menuName.toLowerCase().contains(term) || element.menuName.toUpperCase().contains(term) ||
 element.restaurantName.contains(term) || element.restaurantName.toLowerCase().contains(term) || element.restaurantName.toUpperCase().contains(term) 
|| element.categoryName.contains(term) || element.categoryName.toLowerCase().contains(term) || element.categoryName.toUpperCase().contains(term)).toList();
_pub.sink.add(filterMenu);
}

void dispose(){
  _pub.close();
}

}

final futureTrial = FutureGetter();