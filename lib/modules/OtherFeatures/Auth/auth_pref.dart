
import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/Admin/navbottom_admin.dart';
import 'package:WhereTo/Rider/adCityRider.dart';
import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/modules/A_RiderLog/rider_logPen.dart';
import 'package:WhereTo/modules/Awalkthrough/walk_t.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/modules/categoryCAB/cab.dart';
import 'package:WhereTo/modules/homepage.dart';
import 'package:WhereTo/modules/locationIden.dart';
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
  String paginguser = UserGetPref().userGetPage;
  bool isLogged = false;
  bool shown = false;

Future forUsersOnly(String cityId, String barangayId, String deliveryAddress) async{
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString("paging", doneChanging);
      localStorage.setString("city", cityId);
      localStorage.setString("baranggay", barangayId);
      localStorage.setString("delAdd", deliveryAddress);
      
  }  

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

void removeIt() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('AdminRes');
    localStorage.remove('restuname');
}

void logRemoveAll(context) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('riderSend');
  prefs.remove('user');
  prefs.remove('token');
  prefs.remove('type');
  prefs.remove('latitude');
  prefs.remove('longitude');
  prefs.remove('menuplustrans');
  prefs.remove('userTYPO');
  prefs.remove('cityRider');
  Navigator.pushAndRemoveUntil(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => LoginPage()),ModalRoute.withName('/'));
}

void getThos() async{
  SharedPreferences localStorage = await SharedPreferences.getInstance();
   var token = localStorage.getString('token');
   var type = localStorage.getString('type');
  //  var usershowpage = localStorage.getString('paging');
   var totoyBibo = localStorage.getString('trial');
   if(token != null){
    //  paginguser = usershowpage;
     isLogged = true;
   vartype = type;
    tokes = token;
   }else if(totoyBibo != null){
      shown = true;
      walkth = totoyBibo;
   }
     
}
  userTypeScreen(BuildContext context,int type){
    
    if(type == 0){
      // getThos();
      // if(paginguser.isNotEmpty){
      //   Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_)
      // => HomePage()));
      // }else{
      //   Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_)
      // => FirstPageForRegUser()));
      // }
      locateUserPage..plums(context);
    }else if(type == 1){
      addCityRider..plumming(context);
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
      String userpage = "page";
      if(isLogged == true){

         if(customer.contains(vartype)){

           if(paginguser !=null){
             if(userpage.contains(paginguser)){
                 return isLogged ? HomePage() : LoginPage();
             }else{
               return isLogged ? FirstPageForRegUser() : LoginPage();
             }
           }else{
             return isLogged ? FirstPageForRegUser() : LoginPage();
           }

       
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