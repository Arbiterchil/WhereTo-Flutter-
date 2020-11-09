
import 'dart:async';

import 'package:WhereTo/Rider_ViewMenuTransac/ETry/absclass.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/ETry/repo.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/ETry/state.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerResponse.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerTransaCtion.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:rxdart/rxdart.dart';

class Vice extends BlocVase{

 static Reposit _reposit = Reposit();
 PublishSubject<String> _que;
  


  Stream<ResponseMenuRider>get menuList => _que.stream
    .debounceTime(Duration(milliseconds: 300))
    .where((event) => event.isNotEmpty)
    .distinct()
    .transform(streamTransformer);

    final streamTransformer =StreamTransformer<String,ResponseMenuRider>.fromHandlers(
      handleData: (query,sink) async{
        // yield await getMenu(query);
        State state = await _reposit.dataget(query);
        if(state is SuccessState){
          sink.add(state.value);
        }else{
          sink.addError((state as ErrorState).msg);
        }
      }
    );

    

  init(){
    _que= PublishSubject<String>();
  }

   Function(String) get changeQ => _que.sink.add; 

  @override
  void dispose() {
    _que.close();
  }


}

final blocky = Vice();