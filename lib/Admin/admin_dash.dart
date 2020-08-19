import 'dart:convert';

import 'package:WhereTo/Admin/r_source.dart';
import 'package:WhereTo/Admin/view_allID.dart';
import 'package:WhereTo/AnCustom/admin_help.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class AdminDash extends StatefulWidget {
  @override
  _AdminDashState createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {

  final scaffoldKey = new GlobalKey<ScaffoldState>(); 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: Color(0xFFF7F7F7),
      // backgroundColor: Color(0xFF0C375B),
      body: WillPopScope(
        
          child: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: pureblue,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          //  boxShadow: [
                          //        BoxShadow(
                          //          color: Colors.grey[500],
                          //          spreadRadius: 3.3,
                          //          blurRadius: 3.3
                          //        ),
                          //      ],
                        ),
                        child:Center(
                          child: SharedPrefCallnameData(),
                        )
                      ),
                      ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          Container(
                            height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: pureblue,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //  boxShadow: [
                            //        BoxShadow(
                            //          color: Color(0xfff2f2f2),
                            //          spreadRadius: 3.3,
                            //          blurRadius: 3.3
                            //        ),
                            //      ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Admins",
                              style: TextStyle(
                                color:  Colors.white,
                                fontFamily: 'Gilroy-light',
                                fontSize: 16,
                              ),),
                              SizedBox(height: 10,),
                              Text("6",
                              style: TextStyle(
                                color:  Colors.amber,
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16,
                              ),),
                            ],
                          ),
                          ),

                          Container(
                            height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: pureblue,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //  boxShadow: [
                            //        BoxShadow(
                            //          color: Color(0xfff2f2f2),
                            //          spreadRadius: 3.3,
                            //          blurRadius: 3.3
                            //        ),
                            //      ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Users",
                              style: TextStyle(
                                color:  Colors.white,
                                fontFamily: 'Gilroy-light',
                                fontSize: 16,
                              ),),
                              SizedBox(height: 10,),
                              Text("10",
                              style: TextStyle(
                                color:  Colors.amber, 
                                // Color(0xFF0C375B),
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16,
                              ),),
                            ],
                          ),
                          ),

                          Container(
                            height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: pureblue,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //  boxShadow: [
                            //        BoxShadow(
                            //          color: Color(0xfff2f2f2),
                            //          spreadRadius: 3.3,
                            //          blurRadius: 3.3
                            //        ),
                            //      ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Riders",
                              style: TextStyle(
                                color:Colors.white,
                                fontFamily: 'Gilroy-light',
                                fontSize: 16,
                              ),),
                              SizedBox(height: 10,),
                              Text("6",
                              style: TextStyle(
                                color:  Colors.amber,
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16,
                              ),),
                            ],
                          ),
                          ),
                          
                          ],
                        ),
                      
                      ),
                      SizedBox(height: 10,),
                      Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => ViewAllImageId()));
                            },
                            child: Container(
                              height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: pureblue,
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.all(Radius.circular(10)),
                              //  boxShadow: [
                              //        BoxShadow(
                              //          color: Color(0xfff2f2f2),
                              //          spreadRadius: 3.3,
                              //          blurRadius: 3.3
                              //        ),
                              //      ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.white,
                              ),
                            )
                            ),
                          ),

                          
                          
                          ],
                        ),
                      
                      ),
                       Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: pureblue,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          //  boxShadow: [
                          //        BoxShadow(
                          //          color: Color(0xfff2f2f2),
                          //          spreadRadius: 3.3,
                          //          blurRadius: 3.3
                          //        ),
                          //      ],
                        ),
                     
                      ),
                      ),

                    

                ],
              ),
            ),
            ),
        
       onWillPop:() async => Admin_out.exit(context)),
    );
  }
}