
import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/LoginBloc/loginBloc.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserExit extends StatefulWidget {
  @override
  _UserExitState createState() => _UserExitState();
}

class _UserExitState extends State<UserExit> {

var userData;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user');
      // checkbool = localStorage.getBool('check'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  }

  @override
  Widget build(BuildContext context) {
   return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: builddo(context),
    );
  }
  builddo(BuildContext context) =>Container(

    height: 297,
    decoration: BoxDecoration(
      gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset('asset/img/logo.png',height: 100,width: 100,),
                )),
              SizedBox(height:24.0 ,),
              Text("Do you want To Log Out?",
              style: TextStyle(
                color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            fontFamily: 'OpenSans'
              ),),
               SizedBox(height:16.0 ,),
              Text("Please Check Your Items Before Leaving and Thank You for Using WhereTo Mobile App.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.0,
                            fontFamily: 'OpenSans'
              ),),
              SizedBox(height:25.0 ,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text ( "No", style :TextStyle(
                color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.0,
                            fontFamily: 'OpenSans'
              ),),),
              SizedBox(width: 20.0,),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                onPressed: () async{
                  // var res = await ApiCall().getData('/logout');
                  //           var body = json.decode(res.body);
                              
                               SharedPreferences localStorage = await SharedPreferences.getInstance();
                               localStorage.remove('user');
                               localStorage.remove('token');
                               localStorage.remove('type');
                               localStorage.remove('menuplustrans');
                              //  print(body);
                                Navigator.pushAndRemoveUntil(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => LoginPage()),ModalRoute.withName('/'));
                              // exit(0);
                              // print(body);
                            
                },
                
                child: Text ( "Yes", style :TextStyle(
                color: Color(0xFF398AE5),
                            fontWeight: FontWeight.w700,
                            fontSize: 12.0,
                            fontFamily: 'OpenSans'
              ),),),
              Container(
                height: 20.0,
              ),
                ],
              ),
        ],
      ),
    
  );
}