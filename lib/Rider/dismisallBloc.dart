import 'dart:convert';

import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Auth/auth_pref.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../styletext.dart';
class CheckReenter{

String namedRider = UserGetPref().getUserDataJson['name'];
String contact = UserGetPref().getUserDataJson['contactNumber'];
String passwords = UserGetPref().getSavePass;
String idRider = UserGetPref().getUserDataJson['id'].toString();
List allresult = [];
var ok = DateFormat('MMMM,dd,yyyy hh:mm:ss a').format(DateTime.now());
  logOutormal(BuildContext context) async{
  
  var data = {
    "contactNumber": contact,
    "password": passwords
  };
   var response = await ApiCall().postData(data,'/login');
    var resultBody = json.decode(response.body);
     if(resultBody['success'] == true){
        sendNotifForAdmin();
        sendImageDummyHeart();
        authShared..logRemoveAll(context);
       
     }else if(resultBody['remitPending'] == true){
       sendNotifForAdmin();
        sendImageDummyHeart();
        authShared..logRemoveAll(context);
     }
  }

  sendImageDummyHeart() async{
    var response = await ApiCall().getRiderRemit('/getRiderRemit/$idRider');
  var bods = json.decode(response.body)['id'];
   print(bods);
  var data=
  {
    "remitId":bods,
    "imagePath": "https://res.cloudinary.com/amadpogi/image/upload/v1600008181/heartIcon_v6dwag.jpg"
  };
  await ApiCall().postRemitRider(data,'/riderRemit');
  await ApiCall().getOffline('/goOffline/$idRider');
  }


  sendNotifForAdmin() async{
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
      "contents": {"en": "$namedRider Use Normal Log out. $ok"},
      "data": 
        {
        "force": "penalty"
        },
      "headings": {"en": "Rider Remit Notice:"},
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

final checkReenter = CheckReenter();