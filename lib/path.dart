import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/startpage/start_inputpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/homepage.dart';

class PathWay extends StatefulWidget {
  @override
  _PathWayState createState() => _PathWayState();
}


class _PathWayState extends State<PathWay> {
  bool _isLoggedIn = false;
   @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }
   void _checkIfLoggedIn() async{
      
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      if(token!= null){
         setState(() {
            _isLoggedIn = true;
         });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoggedIn ? Home() :  LoginPage(),
    );
  }
}