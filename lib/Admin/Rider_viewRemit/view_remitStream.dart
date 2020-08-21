import 'package:WhereTo/Admin/Rider_viewRemit/view_remit.dart';
import 'package:WhereTo/Admin/Rider_viewRemit/view_responseRem.dart';
import 'package:WhereTo/Admin/User_Verification/user_api.dart';
import 'package:rxdart/rxdart.dart';

class RemitStream{

  final UserApi userApi = UserApi();
  final BehaviorSubject<RemitResponse> behaviorSubject = BehaviorSubject<RemitResponse>();

  getViewRemits() async{
    RemitResponse remitResponse = await userApi.getRemitImages();
    behaviorSubject.sink.add(remitResponse);

  }
  BehaviorSubject<RemitResponse> get subject => behaviorSubject;

}

final remittanceStream = RemitStream();