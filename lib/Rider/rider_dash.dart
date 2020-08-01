import 'dart:convert';

import 'package:WhereTo/AnCustom/dialogHelp.dart';
import 'package:WhereTo/Rider_viewTransac/DummyTesting/dummy_Card.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiderDash extends StatefulWidget {
  @override
  _RiderDashState createState() => _RiderDashState();
}

class _RiderDashState extends State<RiderDash> {
var userData;
 bool online = true;
  String coma = "'";
  var checkbool;
  @override
  void initState() {
    _getUserInfo();
    configSignal();
    // toOnline(online);
    super.initState();
  }


void _getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user');
      checkbool = localStorage.getBool('check'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  }

// void logOutto() async{
// SharedPreferences localStorage = await SharedPreferences.getInstance();

//   var offline = await ApiCall().getOffline('goOffline/${userData['id']}');

//   var bod = json.decode(offline.body);
//   print(bod);
//   var res = await ApiCall().getData('/logout');
//                             var body = json.decode(res.body);
                           
                               
//                                localStorage.remove('user');
//                                localStorage.remove('token');
//                                print(body);
//                               //   Navigator.pushReplacement(
//                               // context,
//                               // new MaterialPageRoute(
//                               //     builder: (context) => LoginPage()));
//                               exit(0);
//                               print(body);
// }

void toOnline(bool e) async{


    setState(() {

      if(checkbool!=null){
        if(checkbool){
      if(e){
        online = e;                      
        }else{
        online = e;
        // logOutto(); 
      }
        }
      }

      

      
    });

}

void configSignal() async {
     await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');

    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});


    // if(constant == null){
    //     print('No Received.');
    // } else{
    // print(constant);

    // for(var  i = 0; i<constant.length ; i++){
    //   print(constant[i]);
    // } 
    
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var object = localStorage.setStringList('userid', constant ?? []);
    // print(object);
    
    
    // makeit.add(constant['userID'].toString());
    //                                 print(makeit);

    //                                 SharedPreferences localStorage = await SharedPreferences.getInstance();
    //                                 localStorage.setStringList('userID', makeit);  
}

  // Color(0xFFF2F2F2)
  // #0C375B
  // #176DB5
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFF2F2F2) ,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      overflow: Overflow.visible,
                      children: <Widget>[                      
                        Container(
                          height: 230.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                              
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,right: 15.0),
                          child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 66,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF176DB5),
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF176DB5) ,
                                            blurRadius: 6,
                                            offset: Offset(-6, -6),

                                          ),
                                          BoxShadow(
                                            color:Color(0xFF0C375B),
                                            blurRadius: 6,
                                            offset: Offset(6, 6),
                                          ),
                                        ],
                                      ),
                                      child: Switch(
                                        value: online,
                                        activeColor: Colors.lightGreen,
                                        // onChanged: ((bool e)=>toOnline(e)),
                                        onChanged: (bool value) async {
                                         
                                              online = !value;
                                                 
                                                Dialog_Helper.exit(context); 
                                           
                                         },
                                      ),
                                       
                                    )
                                  ),
                        ),
                       Padding(
                         padding: const EdgeInsets.only(top: 5,left: 30,right: 30),
                         child: Container(
                               height: 220.0,
                               child: Column(
                                 children: <Widget>[
                                   Padding(
                                     padding: const EdgeInsets.only(top: 35.0),
                                     child: Row(
                                       children: <Widget>[
                                      Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white,
                                          //  Color(0xFF398AE5),
                                          width: 2.0,
                                        ),
                                        
                                        ),
                                        padding: EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage("asset/img/app.jpg"),
                                        ),
                                          ),
                                      SizedBox(width: 20.0,),
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          
                                          children: <Widget>[
                                                  Text(userData!= null ? '${userData['name']}' :  'Fail get data.',
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  fontFamily: 'OpenSans'
                                                ),
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Text(userData!= null ? '${userData['email']}' :  'Fail get data.',
                                                  style: TextStyle(
                                                  color: Colors.grey[300],
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 10.0,
                                                  fontFamily: 'OpenSans'
                                                ),
                                                  ),
                                                 NCard(
                                                      active: false,
                                 icon: Icons.phone_android,
                                 label: userData!= null ? '${userData['contactNumber']}' :  'Fail get data.',
                                                    ),
                                                    NCard(
                                                      active: false,
                                 icon: Icons.my_location,
                                 label: userData!= null ? '${userData['address']}' :  'Fail get data.',
                                                    ),
                                                
                                                ],
                                              ),
                                        ),
                                      ),
                                    
                                        


                                       ],
                                     ),
                                   ),
                                   
                                   Padding(
                                      padding: const EdgeInsets.only(top: 15,left: 50,right: 50),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("00",
                                              style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              fontFamily: 'OpenSans'
                                            ),
                                              ),
                                              SizedBox(height: 2.0,),
                                              Text('Tax',
                                              style: TextStyle(
                                              color: Colors.grey[300],
                                              fontWeight: FontWeight.normal,
                                              fontSize: 11.0,
                                              fontFamily: 'OpenSans'
                                            ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 30.0,),
                                          RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    onPressed: (){},                
                    child: Text ( "EDIT PROFILE", style :TextStyle(
                    color: Color(0xFF0C375B),
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0,
                                fontFamily: 'OpenSans'
                  ),),),
                                        ],
                                      ),
                                     ), 
                                 ],
                               ),
                             ),
                       ),
                        Padding(padding: const EdgeInsets.only(top:210,left: 40,right: 40),
                        child: Container(
                         height: 70.0,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(10.0),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 5.5,
                               blurRadius: 5.5
                             ),
                           ],
                         ),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child:  Text("Star Rate:",
                                              style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 8.0,
                                              fontFamily: 'OpenSans'
                                            ),
                                              ),),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.star,size: 25,color: Colors.amber,),
                                     Icon(Icons.star,size: 25,color: Colors.amber,),
                                      Icon(Icons.star,size: 25,color: Colors.amber,),
                                       Icon(Icons.star,size: 25,color: Colors.amber,),
                                        Icon(Icons.star,size: 25,color: Colors.grey,),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        )
                      ],
                    ),

                    
                      SizedBox(height: 15.0,),
                     Padding(
                       padding: const EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
                       child: Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width,
                            child: DontenNoMichi(
                              boldName: "Erchil Amad",
                              subtitle: "Nice Job Sir.",
                              description: "$coma Maayu na Driver kay polite nya with time jud cya ning abut og ganahan ko sa design kay nindut.$coma",
                            ),
                          ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
                       child: Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width,
                            child: DontenNoMichi(
                              boldName: "Jayce Mico Dignadice",
                              subtitle: "Good Job Sir.",
                              description: "$coma On Time very good.$coma",
                            ),
                          ),
                     ),
                             
                ],
              ),
            ),
        ),
      ),
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
        height: 30.0,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        // decoration: eBox,
        child: Row(
          children: <Widget>[
            Icon(icon,color: Colors.white,size: 15.0,),
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
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        fontFamily: 'OpenSans'
                      ),),
                    ),
                  ),
             ),
           
            
          ],
        ),
      ),
    );
  }
}