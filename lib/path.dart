import 'dart:convert';

import 'package:WhereTo/Admin/navbottom_admin.dart';
import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/modules/profile.dart';
import 'package:WhereTo/modules/signup_page.dart';
import 'package:WhereTo/startpage/start_inputpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/Awalkthrough/walk_t.dart';
import 'modules/homepage.dart';

class PathWay extends StatefulWidget {
  final String getStringthis;

  const PathWay({Key key, this.getStringthis}) : super(key: key);
  @override
  _PathWayState createState() => _PathWayState();
}


class _PathWayState extends State<PathWay> {
  bool _isLoggedIn = false;
  bool _boobs = false;
  var userData;
   @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }
   void _checkIfLoggedIn() async{
      
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      var totoyBibo = localStorage.getString('trial');
      if( token!= null){
         setState(() {
            _isLoggedIn = true;
           
         });  
      }else if(totoyBibo!= null){
        setState(() {
            _boobs = true;
        });
      }
   }
   timeStamp(){
      String  customer = "0";
      String  rider = "1";
      String  admin = "2";
      String show = "trialShow";
      String  value = widget.getStringthis.toString();

             if(customer.contains(value)){
                return  _isLoggedIn  ? HomePage() :  LoginPage();
              }else if(admin.contains(value)){
                return  _isLoggedIn  ? AdminHomeDash() :  LoginPage();
              }else if(rider.contains(value)){
                return _isLoggedIn  ? RiderProfile() :  LoginPage();
              }else{
                return _boobs ?  LoginPage() : WalkThroughPage();
              }
      //    Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)
      // => WalkThroughPage()
      // ));  
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: timeStamp(),
      //  _isLoggedIn  ? Profile() :  LoginPage(),
    );
  }
}