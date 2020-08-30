import 'dart:convert';

import 'package:WhereTo/Admin/admin_tabswitch.dart';
import 'package:WhereTo/AnCustom/admin_help.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeDash extends StatefulWidget {
  @override
  _AdminHomeDashState createState() => _AdminHomeDashState();
}

class _AdminHomeDashState extends State<AdminHomeDash> {


  String currentPageAdmin = "DashBoard";

  List<String> _adminPages = ['DashBoard','Add_Restaurant','Add_Rider'];
  Map<String,GlobalKey<NavigatorState>> _navAdminState = 
   {
     "DashBoard" : GlobalKey<NavigatorState>(),
     "Add_Restaurant" : GlobalKey<NavigatorState>(),
    "Add_Rider": GlobalKey<NavigatorState>()

   };
   int selectedindex = 0;
   var userData;
   void selectAdmintab(String tabadinitem, int index){
     if(tabadinitem == currentPageAdmin ){
      _navAdminState[tabadinitem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPageAdmin = _adminPages[index];
        selectedindex = index;
      });
    }
   }

  @override
  void initState() {
    this.postuserId();
    this.getShared();
    super.initState();
    this.configSignal();
  }
  void configSignal() async {
     await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');
    await OneSignal.shared.getPermissionSubscriptionState();
    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});                            
}
  void getShared() async {

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user');
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  

 }
  void postuserId() async {
   var status = await OneSignal.shared.getPermissionSubscriptionState();
    var playerId = status.subscriptionStatus.userId;
    var data =
    {
      "userId" : userData['id'].toString(),
      "playerId" : playerId
    };
    var responses = await ApiCall().playerIdSave(data,'/assignPlayerId');
    print(responses.body);
}

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navAdminState[currentPageAdmin].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (currentPageAdmin != "DashBoard") {
            selectAdmintab("DashBoard", 1);
            return false;
          }
        }
        return isFirstRouteInCurrentTab ? Admin_out.exit(context) : false ;
      },
          child: Stack(
          children: <Widget>[
            
            _buildOffstageNavigator("DashBoard"),
            _buildOffstageNavigator("Add_Restaurant"),
            _buildOffstageNavigator("Add_Rider"),
          ],
        ),
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: 
         pureblue,
        backgroundColor:
        Colors.white,
        unselectedItemColor: 
        // Color(0xFF176DB5),
        Color(0xFF0C375B),
        currentIndex: selectedindex,
        onTap: (int index) { selectAdmintab(_adminPages[index], index); },
        items: [
              BottomNavigationBarItem(
              icon: new Icon(Icons.dashboard),
              title: new Text('Dashboard'),
            ),
           BottomNavigationBarItem(
              icon: new Icon(Icons.add_to_queue),
              title: new Text('Add Restaurant'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.motorcycle),
              title: new Text('Add Rider'),
            ),
        ],
        type: BottomNavigationBarType.fixed,
        ),   

    );
  }
    Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPageAdmin != tabItem,
      child: TabSwitchAdmin(
        navigatorKey: _navAdminState[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}