import 'package:WhereTo/Admin/AddCityfran/cityAp.dart';
import 'package:WhereTo/modules/Validators/validators.dart';
import 'package:rxdart/rxdart.dart';
class CitySbloc extends Object with Validators{

final searchData = BehaviorSubject<String>();

Stream<String> get getsearch => searchData.stream.transform(validTextinput);
Stream<String> get subs => searchData.stream.transform(validTextinput);
Function(String) get changeSearch => searchData.sink.add;

searchIt() async{

  final naritaka = searchData.value;
  filtcity..getCitySearch(naritaka);

}  

dispose(){
  searchData.close();
}

}

final filtBloc = CitySbloc();