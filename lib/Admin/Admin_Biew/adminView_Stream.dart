

import 'package:WhereTo/Admin/Admin_Biew/AdminApiRes.dart';
import 'package:WhereTo/Admin/Admin_Biew/adminviewResonponse.dart';
import 'package:rxdart/rxdart.dart';

class AdminStreamViewer{

final AdminApiFromResponses  adminApiFromResponses = AdminApiFromResponses();
final BehaviorSubject<AdminViewResponses> _buns = BehaviorSubject<AdminViewResponses>();


getTransaCView() async{
  AdminViewResponses responses = await adminApiFromResponses.getTranssac();
  _buns.sink.add(responses);
} 

void drainStream(){_buns.value = null;}
void dispose() async{
  await _buns.drain();
  _buns.close();
}

BehaviorSubject<AdminViewResponses> get subject => _buns;

}

final adminviewStreamer = AdminStreamViewer();