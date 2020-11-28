import 'package:WhereTo/Admin/AddCityfran/formEditbaran/formAp.dart';
import 'package:WhereTo/modules/Validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class BaranBloc extends Object with Validators{

  final baran = BehaviorSubject<String>();

  Stream<String> get bararangSaika => baran.stream.transform(validTextinput);
  Function(String) get changeSaika => baran.sink.add;


  searchforBaran() async{
    final word = baran.value;
    searTbaran..searchBaran(word);
  }

  dispose(){
    baran?.close();
  }

}

final baranbloc = BaranBloc();