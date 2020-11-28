import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/Validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class AddCity extends Object with Validators{

final addcity = BehaviorSubject<String>();

Stream<String> get adc => addcity.stream.transform(validTextinput);
Function(String) get  changeAdc => addcity.sink.add;


saveCity() async{
  final cityadd = addcity.value;

  var data = {
    "cityName": cityadd
  };

  var response = await ApiCall().addRestaurant(data,'/addCityFranchise');
  print(response.body);

}

dispose(){
  addcity?.close();
}

}
final cityAdminAdd = AddCity();