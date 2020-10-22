import 'package:WhereTo/Rider/RiderDetails/riderprovider.dart';
import 'package:WhereTo/Rider/RiderDetails/ridrDetailsresonse.dart';
import 'package:rxdart/rxdart.dart';

class RiderStreamDetails{

  final RiderProviderApi _riderProviderApi = RiderProviderApi();
  final BehaviorSubject<RiderDetailsResponse> _behvae = BehaviorSubject<RiderDetailsResponse>();


  getRiderTransacDetails(int id) async{
    RiderDetailsResponse response = await _riderProviderApi.madetran(id);
    _behvae.sink.add(response);
  }


  void drainStreamDet()=> _behvae.value = null;
  dispose() async{
    await _behvae.close();
    _behvae.close();
  }
  BehaviorSubject<RiderDetailsResponse> get subject => _behvae;

}

final  riderStreamDetails = RiderStreamDetails();