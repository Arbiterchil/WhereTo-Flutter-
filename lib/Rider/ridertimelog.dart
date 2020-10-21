import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:http/http.dart' as http;
class TimeLogRiderMessafe{


String getIdentify = UserGetPref().riderSend;
String namedRider = UserGetPref().getUserDataJson['name'];
List allresult = [];
dynamic currtime = DateFormat.jm().format(DateTime.now());
var ok = DateFormat('MMMM,dd,yyyy hh:mm:ss a').format(DateTime.now());
  riderCheckerTime(){
    if(getIdentify != null){
       print(ok);
    }else{
      UserGetPref().saveforRider("imHere");
      sendNotifForAdminss();
    }

  }
sendNotifForAdminss() async{
     var bods = await ApiCall().getAdminDevice('/getAllAdminDeviceId');
    List<dynamic> body = json.decode(bods.body);   
    for(int i = 0 ; i < body.length ;i++){
      allresult.add((body[i]['deviceId'].toString())); 
    }
    print(allresult);
     String url = 'https://onesignal.com/api/v1/notifications';
    var contents = {
      "include_player_ids": allresult,
      "include_segments": ["Users Notif"],
      "excluded_segments": [],
      "contents": {"en": "$namedRider is Present on this Day. Time and Date is $ok"},
      "headings": {"en": "Rider Log In"},
      "filter": [
        {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
      ],
      "app_id": "f5091806-1654-435d-8799-0cbd5fc49280"
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic MGM5OTlmNzgtYzdlMi00NjUyLWFlOGEtZDYxZDM5YTUwNjll'
    };
    var repo =
    await http.post(url, headers: headers, body: json.encode(contents));
    print(repo);
  }

}

final timelogRider = TimeLogRiderMessafe();