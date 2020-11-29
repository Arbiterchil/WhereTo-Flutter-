
import 'package:WhereTo/Admin/AddCityfran/formEditbaran/baranClass.dart';
import 'package:WhereTo/api/api.dart';
import 'package:rxdart/rxdart.dart';
class SearchTextBaran{

PublishSubject<List<BaranClass>> barans = PublishSubject();
Stream<List<BaranClass>> get baransink => barans.stream;


Future searchBaran(String val) async{
  final sear = await ApiCall().getBararang('/getBarangayList');
  List<BaranClass> bara = baranClassFromJson(sear.body);
  var filter = bara.where((element) => 
  element.barangayName.contains(val) ||
  element.barangayName.toLowerCase().contains(val) ||
  element.barangayName.toUpperCase().contains(val)
  ).toList();
  barans.sink.add(filter);
}

dispose(){
  barans.close();
}

}

final searTbaran = SearchTextBaran();