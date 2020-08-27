import 'dart:convert';

import 'package:WhereTo/Admin/Rider_viewRemit/view_RemitImages.dart';
import 'package:WhereTo/Admin/r_source.dart';
import 'package:WhereTo/Admin/view_allID.dart';
import 'package:WhereTo/AnCustom/admin_help.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
                          border: Border.all(
                            width: 1,
                            color: pureblue
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                            border: Border.all(
                            width: 1,
                            color: pureblue
                          ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Admins",
                              style: TextStyle(
                                color:  pureblue,
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
                             border: Border.all(
                            width: 1,
                            color: pureblue
                          ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Users",
                              style: TextStyle(
                                color:  pureblue,
                                fontFamily: 'Gilroy-light',
                                fontSize: 16,
                              ),),
                              SizedBox(height: 10,),
                              Text("10",
                              style: TextStyle(
                                color:  pureblue, 
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
                             border: Border.all(
                            width: 1,
                            color: pureblue
                          ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Riders",
                              style: TextStyle(
                                color:pureblue,
                                fontFamily: 'Gilroy-light',
                                fontSize: 16,
                              ),),
                              SizedBox(height: 10,),
                              Text("6",
                              style: TextStyle(
                                color:  Colors.deepOrange,
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 16,
                              ),),
                            ],
                          ),
                          ),
                          
                          ],
                        ),
                      
                      ),
                      SizedBox(height: 40,),
                    ButtonAdmins(
                      icon: Icons.verified_user,
                      namebutton: "Verify User Valid ID.",
                      ontap: () =>Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => ViewAllImageId())),
                    ),
                    SizedBox(height: 30,),
                    ButtonAdmins(
                      icon: Icons.check,
                      namebutton: "Approve Remittance.",
                      ontap: () => Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => RemitViewImagesAdmin())),
                    ),
                  SizedBox(height: 20,),
                  Padding(padding: const EdgeInsets.only(left: 30,right: 30),
                  child: Text("Note : ",
                  style: TextStyle(
                    color: pureblue,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 30
                  ),
                  ),
                  ),
                  SizedBox(height: 20,),
                  Padding(padding: const EdgeInsets.only(left: 30,right: 30),
                  child: RichText(text: TextSpan(
                    children: [

                      TextSpan(
                        text: "1. ",
                        style: TextStyle(
                          color: pureblue,
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 12
                        )
                      ),
                       TextSpan(
                        text: "Please Check Time to Time if there's a New User to Verify.",
                        style: TextStyle(
                          color: pureblue,
                          fontFamily: 'Gilroy-light',
                          fontSize: 12
                        )
                      ),

                    ]
                  ))
                  ),
                  SizedBox(height: 10,),
                   Padding(padding: const EdgeInsets.only(left: 30,right: 30),
                  child: RichText(text: TextSpan(
                    children: [

                      TextSpan(
                        text: "2. ",
                        style: TextStyle(
                          color: pureblue,
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 12
                        )
                      ),
                       TextSpan(
                        text: "Also Watch Over the Remittance View if the rider made a mistake.",
                        style: TextStyle(
                          color: pureblue,
                          fontFamily: 'Gilroy-light',
                          fontSize: 12
                        )
                      ),

                    ]
                  ))
                  ),
                  SizedBox(height: 10,),
                   Padding(padding: const EdgeInsets.only(left: 30,right: 30),
                  child: RichText(text: TextSpan(
                    children: [

                      TextSpan(
                        text: "3. ",
                        style: TextStyle(
                          color: pureblue,
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 12
                        )
                      ),
                       TextSpan(
                        text: "Don't Sleep on Working Hours",
                        style: TextStyle(
                          color: pureblue,
                          fontFamily: 'Gilroy-light',
                          fontSize: 12
                        )
                      ),

                    ]
                  ))
                  ),
                   SizedBox(height: 10,),
                   Padding(padding: const EdgeInsets.only(left: 30,right: 30),
                  child: RichText(text: TextSpan(
                    children: [

                      TextSpan(
                        text: "4. ",
                        style: TextStyle(
                          color: pureblue,
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 12
                        )
                      ),
                       TextSpan(
                        text: "If You have Problems to Report Just Contact our Owner.",
                        style: TextStyle(
                          color: pureblue,
                          fontFamily: 'Gilroy-light',
                          fontSize: 12
                        )
                      ),

                    ]
                  ))
                  ),





                ],
              ),
            ),
            ),
        
       onWillPop:() async => Admin_out.exit(context)),
    );
  }
}

class ButtonAdmins extends StatelessWidget{
  
  final Function ontap;
  final String namebutton;
  final IconData icon;

  const ButtonAdmins({Key key, this.ontap, this.namebutton, this.icon}) : super(key: key); 
  
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 40,
                color: pureblue,
              ),
              SizedBox(width: 15,),
              Text(namebutton,
              style: TextStyle(
                color: pureblue,
                fontSize: 14,
                fontFamily: 'Gilroy-light'
              ),
              )
            ],
          ),
        ),
      ),
    );

  }




}