

import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerResponse.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerTransaCtion.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getmenuPerProvider.dart';
import 'package:rxdart/rxdart.dart';

class ResponseStreamRiderEdit{

  final ResponseProviderRider responseProviderRider = ResponseProviderRider();
final BehaviorSubject<ResponseMenuRider> _behvae
 = BehaviorSubject<ResponseMenuRider>();


  getMenuRiderOnly() async{
    ResponseMenuRider response = await responseProviderRider.getResposneRiderMenu();
    // final search = 
    _behvae.sink.add(response);
  }

 void drainStreamDet()=> _behvae.value = null;
  dispose() async{
    await _behvae.close();
    _behvae.close();
    
  }

  BehaviorSubject<ResponseMenuRider> get subject => _behvae;
}

final resposneEdit = ResponseStreamRiderEdit();