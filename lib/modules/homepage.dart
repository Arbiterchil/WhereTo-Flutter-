import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editProfileScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ////////////// 1st card///////////
                Card(
                  elevation: 4.0,
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 40, bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ////////////  first name ////////////
                        Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.account_circle,
                                        color: Color(0xFFFF835F),
                                      ),
                                    ),
                                    Text(
                                    'Address',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 17.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text(
                                   userData!= null ? '${userData['address']}' : '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                   
                        Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.mail,
                                        color: Color(0xFFFF835F),
                                      ),
                                    ),
                                    Text(
                                      'Name',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 17.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text(
                                   userData!= null ? '${userData['name']}' : '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    
                        Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.phone,
                                        color: Color(0xFFFF835F),
                                      ),
                                    ),
                                    Text(
                                      'Contact Number',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 17.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text(
                                    userData!= null ? '${userData['contactNumber']}' : '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 10, right: 10),
                            child: Text(
                              'Edit',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: Color(0xFFFF835F),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Edit()));
                          },
                        ),
                      ),

                      
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 10, right: 10),
                            child: Text(
                              'Logout',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: Color(0xFFFF835F),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                          onPressed: logout
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void logout() async{
    
       SharedPreferences localStorage = await SharedPreferences.getInstance();
         localStorage.remove('user');
         localStorage.remove('token');
          Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => LoginPage()));
  }


}