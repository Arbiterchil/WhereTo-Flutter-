import 'dart:convert';

import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/finale/viewLast.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../../../styletext.dart';

class AcceptTransac{

  var riderId = UserGetPref().getUserDataJson['id'];
  int menuExist = UserGetPref().idMenuplusP;

  pumpingAcc(BuildContext context,int id,String restaurant,String deviceId,String address
  ,String name,String contact,
  int idRes
  ) async{
    print('$id $restaurant $deviceId');

    if(menuExist == null){
      var data={
      "transactionId" : id,
      "riderId" :  riderId
    };
    var response = await ApiCall().assignRiders(data, '/assignRider');
    var body = json.decode(response.body);
    if(body == true){
      UserGetPref().riderMenuTrans(id);
      UserGetPref().riderRestaurantId(idRes);
      print(data);
      notif(deviceId);
      Navigator.pushReplacement(context, 
      new MaterialPageRoute(builder: (_)=> ViewLastStepper(
        getId: id,
        deviceId: deviceId ,
        restuName: restaurant,
        address: address,
        name: name,
        contact: contact,
        ))
      );
    }else{
      print("GG Boi Wala");
      Navigator.pop(context);
      showDialog(
      barrierDismissible: true,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitCubeGrid(color: wheretoDark,size: 80,),
        labelHeader: "Sorry",
        message: "The Order is Already Been Accepted",
        buttTitle1: "OK",
        buttTitle2: "NO",
        noFunc: null,
        yesFunc: ()=>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),);
    }
    }else{
      Navigator.pop(context);
       showDialog(
      barrierDismissible: true,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitCubeGrid(color: wheretoDark,size: 80,),
        labelHeader: "You Have Still Pending Order",
        message: "Please Complete the Previous Order.",
        buttTitle1: "OK",
        buttTitle2: "NO",
        noFunc: null,
        yesFunc: ()=>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),);
    }


    
  }

  notif(String device) async{
     String url = 'https://onesignal.com/api/v1/notifications';
        var contents = {
          "include_player_ids": ['$device'],
          "include_segments": ["Users Notif"],
          "excluded_segments": [],
          "large_icon": "https://res.cloudinary.com/amadpogi/image/upload/v1600008167/logo_nh4bpx.png",
          "big_picture":"https://res.cloudinary.com/amadpogi/image/upload/v1599185567/banner-01_sxhg1m.png",
          "contents": {"en": "Your Order is Accepted and Proceeding to Buy."},
          "headings": {"en": "WhereTo Rider"},
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
            print(repo.body);

  }




}

final acceptIt = AcceptTransac();