import 'dart:convert';
import 'dart:io';
import 'package:WhereTo/Rider/rider_sendRem.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class DialogCustomMade extends StatefulWidget {
  @override
  _DialogCustomMadeState createState() => _DialogCustomMadeState();
}

class _DialogCustomMadeState extends State<DialogCustomMade> {
 
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
              Text("Before Leaving Please Remit First. And Have A Good Day ",
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
                  //  var offline = await ApiCall().getOffline('/goOffline/${userData['id']}');

                  //                             var bod = json.decode(offline.body);
                  //                             print(bod); 
                  //              SharedPreferences localStorage = await SharedPreferences.getInstance();
                  //              localStorage.remove('user');
                  //              localStorage.remove('token');
                  //              localStorage.remove('menuplustrans');
                  //              var res = await ApiCall().getData('/logout');
                  //           var body = json.decode(res.body);
                  //          print(body);
                  //             //  print(body);
                  //               Navigator.pushAndRemoveUntil(
                  //             context,
                  //             new MaterialPageRoute(
                  //                 builder: (context) => LoginPage()),ModalRoute.withName('/'));
                              // exit(0);
                              // print(body);
                                      Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => RiderRemit(idFromLog : userData['id'].toString())));
                            
                },
                
                child: Text ( "OK", style :TextStyle(
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