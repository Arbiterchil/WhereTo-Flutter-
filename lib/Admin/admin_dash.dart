import 'package:WhereTo/AnCustom/admin_help.dart';
import 'package:WhereTo/modules/gobal_call.dart';
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
        child: Container(
          height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           decoration: BoxDecoration(
                      // color: Color(0xFF398AE5),
                      gradient: LinearGradient(
                              stops: [0.1,2],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
                    ),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          //  boxShadow: [
                          //        BoxShadow(
                          //          color: Color(0xfff2f2f2),
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
                            color: Colors.white,
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
                                color:  Color(0xFF0C375B),
                                fontFamily: 'Gilroy-light',
                                fontSize: 16,
                              ),),
                              SizedBox(height: 10,),
                              Text("6",
                              style: TextStyle(
                                color:  Color(0xFF0C375B),
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
                            color: Colors.white,
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
                                color:  Color(0xFF0C375B),
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
                            color: Colors.white,
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
                                color:Color(0xFF0C375B),
                                fontFamily: 'Gilroy-light',
                                fontSize: 16,
                              ),),
                              SizedBox(height: 10,),
                              Text("6",
                              style: TextStyle(
                                color:  Colors.green,
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
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
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
        ),
       onWillPop:() async => Admin_out.exit(context)),
    );
  }
}