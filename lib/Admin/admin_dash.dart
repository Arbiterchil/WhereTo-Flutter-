import 'dart:convert';
import 'dart:ui';

import 'package:WhereTo/Admin/Restaurant.dart';
import 'package:WhereTo/Admin/Rider_viewRemit/view_RemitImages.dart';
import 'package:WhereTo/Admin/r_source.dart';
import 'package:WhereTo/Admin/view_allID.dart';
import 'package:WhereTo/Admin/view_saleOurs/show_resultsRemitList.dart';
import 'package:WhereTo/AnCustom/admin_help.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/styletext.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDash extends StatefulWidget {
  @override
  _AdminDashState createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {

  final scaffoldKey = new GlobalKey<ScaffoldState>(); 

  var userData;
  bool  load = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController ownconpass = TextEditingController();

  TextEditingController ownpass = TextEditingController();
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
                              Text("?",
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
                              Text("?",
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
                              Text("?",
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
                      icon: EvaIcons.shield,
                      namebutton: "Verify User Valid ID.",
                      ontap: () =>Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => ViewAllImageId())),
                    ),
                    SizedBox(height: 30,),
                    ButtonAdmins(
                      icon: EvaIcons.checkmark,
                      namebutton: "Approve Remittance.",
                      ontap: () => Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => RemitViewImagesAdmin())),
                    ),
                     SizedBox(height: 30,),
                    ButtonAdmins(
                      icon: EvaIcons.list,
                      namebutton: "Remittance List.",
                      ontap: () => Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => ShowemitListResult())),
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
                   SizedBox(height: 40,),
                    Row(
                      children: [
                        Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: GestureDetector(

                                  onTap: (){
                                      print(userData['id'].toString());
                                      showDialogFam(userData['id'].toString());
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: pureblue,
                                      borderRadius: BorderRadius.all(Radius.circular(40)),
                                    ),
                                    child: Center(
                                      child: Text("Change Password",
                                      style: TextStyle(
                                        color:  Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Gilroy-light'
                                      ),
                                      ),
                                    ),
                                  ),

                                ),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: GestureDetector(

                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditRestaurant()));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      color: pureblue,
                                      borderRadius: BorderRadius.all(Radius.circular(40)),
                                    ),
                                    child: Center(
                                      child: Text("Edit Restaurants",
                                      style: TextStyle(
                                        color:  Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Gilroy-light'
                                      ),
                                      ),
                                    ),
                                  ),

                                ),
                    ),
                      ],
                    ),
                   SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: RaisedButton(
                  splashColor: Colors.amberAccent,
                 color: Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () =>Admin_out.exit(context),
                  child: Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0,
                          fontFamily: 'OpenSans'),
                  ),
                  ),
                    ),
                   SizedBox(height: 10,),
                ],
              ),
            ),
            ),
        
       onWillPop:() async => Admin_out.exit(context)),
    );
  }


  void showDialogFam(String id){

    showDialog(context: context,
    barrierDismissible: true,
    builder: (context){
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                       SizedBox(
                  height: 15.0,
            ),
            Text(
                  'New Password',
                  style: eLabelStyle,
            ),
            SizedBox(
                  height: 10.0,
            ),
            Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  decoration: eBoxDecorationStyle,
                  height: 50.0,
                  child: TextFormField(
                    cursorColor: pureblue,
                    controller: ownpass,
                    validator: (input) =>
                        ownpass.text.length < 8 ? 'Password to Short' : null,
                    obscureText: true,
                    style: TextStyle(
                      color: pureblue,
                      fontFamily: 'Gilroy-light',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: pureblue,
                      ),
                      hintText: '********',
                      hintStyle: eHintStyle,
                    ),
                  ),
            ),
           SizedBox(
                  height: 15.0,
            ),
            Text(
                  'Confirm Password',
                  style: eLabelStyle,
            ),
            SizedBox(
                  height: 10.0,
            ),
            Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  decoration: eBoxDecorationStyle,
                  height: 50.0,
                  child: TextFormField(
                    cursorColor: pureblue,
                    controller: ownconpass,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please Input Confirm Password";
                      }
                      if (val != ownpass.text) {
                        return "Password not Match";
                      }
                      return null;
                    },
                    obscureText: true,
                    style: TextStyle(
                      color: pureblue,
                      fontFamily: 'Gilroy-light',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: pureblue,
                      ),
                      hintText: '********',
                      hintStyle: eHintStyle,
                    ),
                  ),
            ),

            SizedBox(height: 20,),
            GestureDetector(
              onTap: () async{
                    setState(() {
                      load = true;
                    });

                    if(formkey.currentState.validate()) {
                        formkey.currentState.save();
                        var data = {
                    "userId": id,
                    "password": ownpass.text 
                  };
                  var respon = await ApiCall().changepasssword(data,'/changePassword');
                  print(respon.body);
                   Navigator.pop(context);
                  _showDistictWarning("Password Change");
                 
                    }else{
                      _showDistictWarning("Password Not Match");
                    }
                  

                  setState(() {
                    load = false;
                  });

              },
              child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: pureblue,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Center(
                    child: Text(load ? "..." : "Change Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Gilroy-light'
                    ),),
                  ),
              ),
            ),
                    ],
                  ),
                ),
              ),
            ),
        ),
      );
    }
    );

    }
 void _showDistictWarning(String meesage) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child:Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 150.0,
                ),
                Container(
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        stops: [0.2, 4],
                        colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 94.0,
                  child: Container(
                    height: 90,
                    width: 90,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(45),

                      // border: Border.all(
                      //   color: Colors.white,
                      //   style: BorderStyle.solid,
                      //   width: 2.0,
                      // ),
                      image: DecorationImage(
                        image: AssetImage("asset/img/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                meesage,
                style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    fontFamily: 'Gilroy-light'),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        fontFamily: 'OpenSans'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
        );
      },
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