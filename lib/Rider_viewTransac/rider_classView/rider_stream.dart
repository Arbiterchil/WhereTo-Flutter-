
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_api.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_reponse.dart';
import 'package:rxdart/rxdart.dart';

class RiderStream {


  final RiderApi _api = RiderApi();
  final BehaviorSubject<RiderResponse> _subject = BehaviorSubject<RiderResponse>();



 

  

  getView() async{
    RiderResponse riderresponse = await _api.getViewTransac();
    _subject.sink.add(riderresponse);
  }

  dispose(){
    _subject.close();
  }
  BehaviorSubject<RiderResponse> get subject => _subject;

}

final streamRider  = RiderStream();