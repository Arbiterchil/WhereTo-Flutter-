import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/Validators/validators.dart';
import 'package:rxdart/subjects.dart';

class EditSeaBaran extends Object with Validators{

  final seaban = BehaviorSubject<String>();

  Stream<String> get bans =>seaban.stream;
  Function(String) get chanban => seaban.sink.add;

  editbaran(int id) async{
    final fun = seaban.value;

    var data = {
      'id': id,
      'charge': fun
    };

    var reponse = await ApiCall().addRestaurant(data,'/updateBarangayCharge');
    print(reponse.body);
  }

  dispose(){
    seaban.close();
  }

}

final eitbaran = EditSeaBaran();