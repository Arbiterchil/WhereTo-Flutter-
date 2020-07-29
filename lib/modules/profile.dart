import 'dart:convert';
import 'package:WhereTo/AnCustom/alert_dialog.dart';
import 'package:WhereTo/AnCustom/dialogHelp.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../bloc.Navigation_bloc/navigation_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styletext.dart';

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
  @override
  void initState() {
    _getUserInfo();
    casting = false;
    // configSignal();
    super.initState();
    getLocation();

  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }
 getLocation() async{
    var location =Location();
    try{
      var userLocation =await location.getLocation();
      print("${userLocation.latitude},${userLocation.longitude}");
    } on Exception catch (e){
      print(e.toString());
    }
 }
  

  void configSignal() async {
    var data;
    await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      setState(() {
        //  constant = notification.payload.additionalData;
        data =notification.payload.additionalData;
        
      });
    });
    await OneSignal.shared.setSubscription(true);
    var tags = await OneSignal.shared.getTags();
    var sendtag = await OneSignal.shared.sendTags({'UR': 'TRUE'});
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    String url = 'https://onesignal.com/api/v1/notifications';
    var playerId = status.subscriptionStatus.userId;

    var numb = "4";
    var contents = {
      "include_player_ids": [playerId],
      "include_segments": ["Users Notif"],
      "excluded_segments": [],
      "contents": {"en": "This is a test."},
      "data": {"id": numb},
      "headings": {"en": "Erchil Testings"},
      "filter": [
        {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
      ],
      "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
    };
    var repo =
        await http.post(url, headers: headers, body: json.encode(contents));

    // await OneSignal.shared.deleteTags(["userID","2","transactionID","2"]);
    print(data.toString());
    print(tags);
    print(sendtag);
    print(playerId);
    print(repo.body);
  
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF398AE5),
      body: WillPopScope(
        onWillPop: () async {
          return await Dialog_Helper.exit(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: DesignButton(
                              height: 55,
                              width: 55,
                              color: Color(0xFF398AE5),
                              offblackBlue: Offset(-4, -4),
                              offsetBlue: Offset(4, 4),
                              blurlevel: 4.0,
                              icon: Icons.exit_to_app,
                              iconSize: 30.0,
                              onTap: () {
                                Dialog_Helper.exit(context);
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: DesignButton(
                              height: 55,
                              width: 55,
                              color: Color(0xFF398AE5),
                              offblackBlue: Offset(-4, -4),
                              offsetBlue: Offset(4, 4),
                              blurlevel: 4.0,
                              icon: Icons.search,
                              iconSize: 30.0,
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SearchDepo();
                                }));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Color(0xFF398AE5),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(-6, -6),
                              blurRadius: 6.0,
                              color: Colors.blue[500]),
                          BoxShadow(
                              offset: Offset(6, 6),
                              blurRadius: 6.0,
                              color: Colors.blue.shade700),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("asset/img/app.jpg"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      userData != null ? '${userData['name']}' : '',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 28.0,
                          fontFamily: 'OpenSans'),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    NCard(
                      active: false,
                      icon: Icons.my_location,
                      label: userData != null
                          ? '${userData['address']}'
                          : 'Fail get data.',
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    NCard(
                      active: false,
                      icon: Icons.phone_android,
                      label: userData != null
                          ? '${userData['contactNumber']}'
                          : 'Fail get data.',
                    ),
                    SizedBox(
                      height: 45.0,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            DesignButton(
                              height: 55,
                              width: 55,
                              color: Color(0xFF398AE5),
                              offblackBlue: Offset(-4, -4),
                              offsetBlue: Offset(4, 4),
                              blurlevel: 4.0,
                              icon: Icons.home,
                              iconSize: 30.0,
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Profile();
                                }));
                              },
                            ),
                            DesignButton(
                              height: 55,
                              width: 55,
                              color: Color(0xFF398AE5),
                              offblackBlue: Offset(-4, -4),
                              offsetBlue: Offset(4, 4),
                              blurlevel: 4.0,
                              icon: Icons.track_changes,
                              iconSize: 30.0,
                            ),
                            DesignButton(
                              height: 55,
                              width: 55,
                              color: Color(0xFF398AE5),
                              offblackBlue: Offset(-4, -4),
                              offsetBlue: Offset(4, 4),
                              blurlevel: 4.0,
                              icon: Icons.inbox,
                              iconSize: 30.0,
                            ),
                            DesignButton(
                              height: 55,
                              width: 55,
                              color: Color(0xFF398AE5),
                              offblackBlue: Offset(-4, -4),
                              offsetBlue: Offset(4, 4),
                              blurlevel: 4.0,
                              icon: Icons.account_box,
                              iconSize: 30.0,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
  const NCard({this.active, this.icon, this.onTap, this.label});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: eBox,
        child: Row(
          children: <Widget>[
            Icon(icon, color: Colors.white),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  label,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
