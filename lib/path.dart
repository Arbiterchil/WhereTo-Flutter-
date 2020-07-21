import 'dart:convert';

import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/modules/profile.dart';
import 'package:WhereTo/modules/signup_page.dart';
import 'package:WhereTo/startpage/start_inputpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/homepage.dart';

class PathWay extends StatefulWidget {
  final String getStringthis;

  const PathWay({Key key, this.getStringthis}) : super(key: key);
  @override
  _PathWayState createState() => _PathWayState();
}


class _PathWayState extends State<PathWay> {
  bool _isLoggedIn = false;
  var userData;
   @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }
   void _checkIfLoggedIn() async{
      
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      if( token!= null){
         setState(() {
            _isLoggedIn = true;
         });  
      }
   }

   timeStamp(){
      String  admin = "0";
      String  customer = '1';
      String  rider = "2";
      String  value = widget.getStringthis.toString();
      if(admin.contains(value)){
        return LoginPage();
      }else  if(customer.contains(value)){
        return  _isLoggedIn  ? Profile() :  LoginPage();
      }else if(rider.contains(value)){
        return _isLoggedIn  ? SignupPage() :  LoginPage();
      }

   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: timeStamp(),
      //  _isLoggedIn  ? Profile() :  LoginPage(),
    );
  }
}