
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuProvider.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuResponseTran.dart';
import 'package:rxdart/rxdart.dart';

class GetMenuStreamtran{
final ApiProverGetMenu _apiProverGetMenu = ApiProverGetMenu();
  final BehaviorSubject<GetMenuPertransactionResponse> _behvae = BehaviorSubject<GetMenuPertransactionResponse>();


  getMenuTransacDetails(int id) async{
    GetMenuPertransactionResponse response = await _apiProverGetMenu.madetranMenu(id);
    _behvae.sink.add(response);
  }


  void drainStreamDet()=> _behvae.value = null;
  dispose() async{
    await _behvae.close();
    _behvae.close();
  }
  BehaviorSubject<GetMenuPertransactionResponse> get subject => _behvae;

}
final getMenuStreamTransDet = GetMenuStreamtran();