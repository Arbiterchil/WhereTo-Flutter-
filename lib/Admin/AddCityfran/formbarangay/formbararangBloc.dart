
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/Validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class FormAddbaran extends Object with Validators{

  final baranname = BehaviorSubject<String>();
  final charage = BehaviorSubject<String>();

  Stream<String> get barangayNamein => baranname.stream.transform(validTextinput);
  Stream<String> get charges => charage.stream;
  Function(String) get changebaran => baranname.sink.add;
  Function(String) get changecharge => charage.sink.add;
  Stream<bool> get subs => Rx.combineLatest2(barangayNamein, charges, (a, b) => true);


  saveinputedBaranagy(int id) async{
    final baran = baranname.value;
    final charge = charage.value;

    var data = {
      'cityId': id,
      'cityName':baran,
      'charge' :charge
    };
   var response = await ApiCall().addRestaurant(data,'/addBarangayCharge');
   print(response.body);
  }


  dispose(){
    baranname.close();
    charage.close();
  }


} 

final formB = FormAddbaran();