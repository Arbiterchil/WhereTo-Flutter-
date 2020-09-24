
import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/Admin/navbottom_admin.dart';
import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/modules/A_RiderLog/rider_logPen.dart';
import 'package:WhereTo/modules/Awalkthrough/walk_t.dart';
import 'package:WhereTo/modules/homepage.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/modules/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../styletext.dart';

class AuthSharedBloc{

  String tokes="";
  String vartype = "";
  String walkth = "";
  bool isLogged = false;
  bool shown = false;
  
Future saveDataAccount(String token,String type,String lat ,String long) async{
 SharedPreferences localStorage = await SharedPreferences.getInstance();
            localStorage.setString("token", token);
            localStorage.setString("trial",'trialShow');
            localStorage.setString("type", type );
            localStorage.setDouble("latitude", double.parse(lat));
            localStorage.setDouble("longitude", double.parse(long));
}

void removeAuthPref() async{
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  localStorage.remove('user');
  localStorage.remove('token');
  localStorage.remove('menuplustrans');
}

void logRemoveAll() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('user');
  prefs.remove('token');
  prefs.remove('type');
  prefs.remove('latitude');
  prefs.remove('longitude');
}

void getThos() async{
  SharedPreferences localStorage = await SharedPreferences.getInstance();
   var token = localStorage.getString('token');
   var type = localStorage.getString('type');
   var totoyBibo = localStorage.getString('trial');
   if(token != null){
    tokes = token;
    isLogged = true;
   vartype = type;
   }else if(totoyBibo != null){
      shown = true;
      walkth = totoyBibo;
   }
     
}
  userTypeScreen(BuildContext context,int type){
    if(type == 0){
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_)
      => HomePage()));
    }else if(type == 1){
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_)
      => RiderProfile()));
    }else if(type == 2){
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_)
      => AdminHomeDash()));
    }else{
          showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitDoubleBounce(color: wheretoDark,size: 80,),
        labelHeader: "No User Found?",
        message: "Try to Sign Up for New Account.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () =>Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
      
      );
    }
  }

  openSessionPages() {
   String  customer = "0";
      String  rider = "1";
      String  admin = "2";
      if(isLogged == true){
         if(customer.contains(vartype)){
       return isLogged ? HomePage() : LoginPage();
     }else if(admin.contains(vartype)){
       return isLogged ? AdminHomeDash() : LoginPage();
     }else if(rider.contains(vartype)){
       return isLogged ? RiderProfile() : LoginPage();
     }
      }else{
       return shown ? LoginPage() : WalkThroughPage() ;
     }
}

}

final authShared = AuthSharedBloc();