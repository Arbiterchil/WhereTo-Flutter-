import 'dart:convert';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../bloc.Navigation_bloc/navigation_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget with NavigationStates{
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
    configSignal();
  }
  
void configSignal() async {
      await OneSignal.shared.init('61147e88-b566-4802-a161-74d552fc58f2');
      OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
      OneSignal.shared.setNotificationReceivedHandler(( OSNotification notification) {

        // setState(() {
        //   cons = notification.jsonRepresentation().replaceAll('\\n', '\n');        });



       });

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
      body: Container(
            child: Stack(
                children: <Widget>[ 
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: <Widget>[
                            // Container(
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(
                            //       colors: [
                            //         Colors.white,
                            //          Colors.white,
                            //       ],                        
                            //     ),
                            //   ),
                            // ),
                              Padding(
                          padding: EdgeInsets.only(top: 80.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                  width: 200.0,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xFF262AAA),
                                      width: 2.0,
                                      ),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                   backgroundImage: AssetImage('asset/img/app.jpg'),

                                  ),
                                ),
                                ],
                              ),
                              SizedBox(height: 10.0,),
                               Text(userData!= null ? '${userData['name']}' : '',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                          color: Colors.black
                        ),),
                         Text("Welcome, Have a Nice Day!",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black54
                        ),),
                            ],
                          ),
                        ),
                              SizedBox(height: 40.0,),
                               Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context){
                        //   return  Point_Reward();
                        // }));
                      },
                      child: Text("Points | Rewards",style:
                       TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 22.0,),
                    ),
                              ),
                  ],
                ),
              ),
               SizedBox(height: 20.0,),
                             Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(left: 30.0, right: 30.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 40, bottom: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
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
                                                Icons.location_city,
                                                color: Color(0xFF262AAA),
                                              ),
                                            ),
                                            Text(
                                            'Address',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
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
                                                Icons.phone,
                                                color: Color(0xFF262AAA),
                                              ),
                                            ),
                                            Text(
                                              'Contact Number',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:  Colors.black,
                                                fontSize: 17.0,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
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
                         SizedBox(height: 10.0,),
                        ],
                        ),
                      ),
                    ),
                ],
            ),
            
      ),
    );
  }

}