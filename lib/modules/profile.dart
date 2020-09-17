import 'dart:convert';
import 'dart:ui';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';

import 'package:WhereTo/modules/OtherFeatures/trans_port.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/restaurants/searchRestaurant.dart';
import 'package:WhereTo/styletext.dart';
import 'package:location/location.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class Profile extends StatefulWidget with NavigationStates{
//   @override
//   _Profile createState() => _Profile();
// }

class Profile extends StatefulWidget {
  

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  var userData;
  var constant;
  bool casting;
   
  String getRestaurant;
   bool  load = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController ownconpass = TextEditingController();

  TextEditingController ownpass = TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
   TextEditingController search = new TextEditingController();
  String getImage;
  String addre ="";
  @override
  void initState() {
    _getUserInfo();
    super.initState();
    _onsSignal();
    
  }

 String meesages = "You have Violated the Terms and Condition that your Valid Id is not acceptable.";
String data ="";
_onsSignal() async{
  if(!mounted) return;
    await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});  
     OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification){
        setState(() {
           data = notification.payload.additionalData["force"].toString();
           print("$data is you");
          // if(data != null){
            if(data == "penalty"){
               _showDone(meesages.toString());
            }else{
              print("None");
            }
          // }
        });
        
    });                     
  }

  void _showDone(String message){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
      return Dialog(
       
      elevation: 0,
      backgroundColor: Colors.transparent,
      child:Container(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('asset/img/penalty.png'),
                  ),
                ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(message,
                  style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 11.0,
                    fontFamily: 'Gilroy-light'
                  ),
                  
                  ),),
                  SizedBox(height: 25.0,),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[         
                RaisedButton(
                  color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () async {
                    
                      SharedPreferences localStorage = await SharedPreferences.getInstance();
                               localStorage.remove('user');
                               localStorage.remove('token');
                               localStorage.remove('menuplustrans');
                              //  print(body);
                                Navigator.pushAndRemoveUntil(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => LoginPage()),ModalRoute.withName('/'));
                      },   
                      
                  child: Text ( "OK",
                   style :TextStyle(
                  color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),),
                  ],
                ), 
              ],
          ),
        ),
      ),
    ); 
    },);
}
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    String shitka = localStorage.getDouble('latitude').toString();
    String nimalka = localStorage.getDouble('longitude').toString();
    var user = json.decode(userJson);
    setState(() {
      userData = user;
      addre = shitka+","+nimalka;
    });
  //     var response = await ApiCall().getCheckUser('/getUserVerification/${userData['id']}');
  //  var body = json.decode(response.body)['imagePath'];
  //   print(body);
  
    
    if(userData['imagePath'] != null){

      setState(() {
      getImage = userData['imagePath'];
      });

    }else{
        print("No Image");
    }
  }



  Widget imagesget(){

    if(getImage != null){
      return  Container(
                             height: 120,
                             width: 120,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               image: DecorationImage(
                                 image: NetworkImage(getImage),
                                 fit: BoxFit.cover),
                             ),
                           );
    }else{
      return  Container(
                             height: 120,
                             width: 120,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               image: DecorationImage(
                                 image: AssetImage('asset/img/logo.png'),
                                 fit: BoxFit.cover),
                             ),
                           );
    }

  }

  Widget imageBack(){

    if(getImage != null){
      return  Container(
                             height: 350,
                             width: MediaQuery.of(context).size.width,
                             decoration: BoxDecoration(
                               image: DecorationImage(
                                 image: NetworkImage(getImage),
                                 fit: BoxFit.cover),
                             ),
                             child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                             child: Container(
                               height: 350,
                               width: MediaQuery.of(context).size.width,
                               decoration: BoxDecoration(
                                 color: Colors.white.withOpacity(0.0)
                               ),
                             ),
                             ),
                           );
    }else{
      return  Container(
                             height: 120,
                             width: 120,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               image: DecorationImage(
                                 image: AssetImage('asset/img/logo.png'),
                                 fit: BoxFit.cover),
                             ),
                           );
    }

  }
  
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            imageBack(),
                        //     Container(
                        //   height: 330.0,
                        //   decoration: BoxDecoration(
                        //     // color: pureblue.withOpacity(.79),
                        //     // borderRadius: BorderRadius.only(
                        //     //   bottomRight: Radius.circular(290),
                        //     // ),

                        //   ),

                        // ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(padding: const EdgeInsets.only(left: 30,top: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: TextDirection.ltr,
                                children: <Widget>[
                                    imagesget(),
                                SizedBox(height: 10,),
                                Text(userData!= null ? '${userData['name']}':  'Fail get data.',
                                                  style: TextStyle(
                                                  color: pureblue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  fontFamily: 'Gilroy-ExtraBold'
                                                ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Text(userData!= null ? '${userData['email']}' :  'Fail get data.',
                                                  style: TextStyle(
                                                  color: pureblue,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20.0,
                                                  fontFamily: 'Gilroy-light'
                                                ),
                                                  ),
                                               SizedBox(height: 10,),
                              GestureDetector(

                                onTap: (){
                                    print(userData['id'].toString());
                                    showDialogFam(userData['id'].toString());


                                },
                                child: Container(
                                  height: 50,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: Center(
                                    child: Text("Change Password",
                                    style: TextStyle(
                                      color: pureblue,
                                      fontSize: 14,
                                      fontFamily: 'Gilroy-light'
                                    ),
                                    ),
                                  ),
                                ),

                              ),


                                ],
                              ),
                              ),
                            ),
                          
                          ],
                        ),
                           
                         
                                                  SizedBox(height: 40,),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left: 20,right: 20),
                                                   child: NCard(
                                                        active: false,
                                 icon: Icons.phone_android,
                                 label: userData!= null ? '${userData['contactNumber']}' :  'Fail get data.',
                                                      ),
                                                 ), 
                                                    SizedBox(height: 40,),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20,right: 20),
                                                      child: FutureBuilder(
                                                     future: CoordinatesConverter().convert(addre),
                                                     builder: (context,snaps){
                                                      if(snaps.data ==null){
                                                        return Container();
                                                      }else{
                                                         return    NCard(
                                                        active: false,
                                   icon: Icons.my_location,
                                   label: snaps.data != null ? '${snaps.data}' :  'Fail get data.',
                                                      );
                                                      }
                                                     }),
                                                    ),
                      SizedBox(height: 40,),
                      GestureDetector(
                            onTap: (){
                               UserDialog_Help.exit(context);
                            },
                            child: Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                color: pureblue,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Center(
                                child: Text('Logout X',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                                ),
                              ),
                            ),
                          ),              
                                             
                                      

                      ],
              
                ),
              ),
            ),
        
    
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

class NCard extends StatelessWidget {

  final bool active;
  final IconData icon;
  final String label;
  final Function onTap;
  const NCard({this.active,this.icon,this.onTap,this.label});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: onTap,
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   color: Color(0xFF0C375B),
        //   borderRadius: BorderRadius.all(Radius.circular(40))
        // ),
        // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        // decoration: eBox,
        decoration: eBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Icon(icon,color: pureblue,size: 15.0,),
              SizedBox(width: 7.0,),

               Flexible(
                 flex: 1,
                 child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Text(label,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: pureblue,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          fontFamily: 'Gilroy-light'
                        ),),
                      ),
                    ),
               ),
             
              
            ],
          ),
        ),
      ),
    );
  }

  

}
