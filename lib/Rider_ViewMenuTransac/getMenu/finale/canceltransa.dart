
import 'dart:convert';

import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/finale/notifsending.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CancelDemonDays{

  cancelOrder(BuildContext context,int id,String message, String device) async{
    UserGetPref().remove();
    notifyingSend..notifySend(device, message);
    var reponse = await ApiCall().cancelOrder('/cancelOrder/$id');
    var body = json.decode(reponse.body);
    print(body);
    Navigator.pushReplacement(context, 
    new MaterialPageRoute(builder: (context) =>
    RiderProfile()));
  }

}
final demonDay = CancelDemonDays();