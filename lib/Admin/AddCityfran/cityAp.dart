import 'package:WhereTo/Admin/AddCityfran/cityframe.dart';
import 'package:WhereTo/CityLocal/cityclass.dart';
import 'package:WhereTo/api/api.dart';
import 'package:rxdart/rxdart.dart';

class Citysearch{

  PublishSubject<List<CityAdmin>> pubs = PublishSubject();
  Stream<List<CityAdmin>> get sinkthem => pubs.stream;


  Future getCitySearch(String val) async{
    final finder = await ApiCall().getRestarant("/getCity");
    List<CityAdmin> sea = cityAdminFromJson(finder.body);
    var filter = sea.where((element) => 
    element.cityName.contains(val) ||
    element.cityName.toUpperCase().contains(val) ||
    element.cityName.toLowerCase().contains(val)
    ).toList();
    pubs.sink.add(filter);
  }


  dispose(){
    pubs.close();
  }
}

final filtcity = Citysearch();