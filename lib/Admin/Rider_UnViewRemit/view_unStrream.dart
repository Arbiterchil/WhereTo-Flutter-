
import 'package:WhereTo/Admin/Rider_UnViewRemit/view_unresponse.dart';
import 'package:WhereTo/Admin/User_Verification/user_api.dart';
import 'package:rxdart/rxdart.dart';

class UnRemitStream{



  final UserApi userApi = UserApi();
  final BehaviorSubject<UnRemitResponse> _behaviorSubjects =  BehaviorSubject<UnRemitResponse>();


  getUnViewRemit() async{
    UnRemitResponse unRemitResponse = await userApi.getUnRemitImages();
    _behaviorSubjects.sink.add(unRemitResponse);
  }
  BehaviorSubject<UnRemitResponse> get subject => _behaviorSubjects;
}
final unremitStream = UnRemitStream();