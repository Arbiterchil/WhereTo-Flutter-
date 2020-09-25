import 'dart:convert';
import 'package:WhereTo/A1_NewSingleBottomNav/bottom_nav.dart';
import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/Admin/admin_tabswitch.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Auth/auth_pref.dart';
import 'package:WhereTo/styletext.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeDash extends StatefulWidget {
  @override
  _AdminHomeDashState createState() => _AdminHomeDashState();
}

class _AdminHomeDashState extends State<AdminHomeDash> {


  String currentPageAdmin = "DashBoard";
  var getterThis;
  List<String> _adminPages = ["DashBoard","Add_Restaurant","Add_Rider"];
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
 
    super.initState();
     postuserId();
    getShared();
    // this.configSignal();
  }
   configSignal() async {
      if(!mounted) return;
     await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    // await OneSignal.shared.init('f5091806-1654-435d-8799-0cbd5fc49280');
    await OneSignal.shared.getPermissionSubscriptionState();
    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});      
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification){
    });                           
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
   OSPermissionSubscriptionState status = await OneSignal.shared.getPermissionSubscriptionState();
    String playerId = status.subscriptionStatus.userId;
    getterThis = playerId;
    var data =
    {
      "userId" : userData['id'].toString(),
      "playerId" : getterThis
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
        return isFirstRouteInCurrentTab ? 
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => 
          DialogForAll(
        widgets: SpinKitDoubleBounce(color: wheretoDark,size: 80,),
        labelHeader: "Do you want to exit app?",
        message: "Please double check for the Remits of Riders before Exiting",
        buttTitle1: "Yes",
        buttTitle2: "No",
        yesFunc: () =>authShared.logRemoveAll(context),
        noFunc: () => Navigator.pop(context),
        showorNot1: true,
        showorNot2: true,
      ),)
      : false;
      },
          child: Stack(
          children: <Widget>[
            
            _buildOffstageNavigator("DashBoard"),
            _buildOffstageNavigator("Add_Restaurant"),
            _buildOffstageNavigator("Add_Rider"),
          ],
        ),
        
      ),
      
       bottomNavigationBar: BottomNavBar(
         selectedIndex: selectedindex,
          backColor: Colors.white,
          containHieght: 60,
          itemCorner: 40,
          items: 
          [
             BottomBarItems(
              icon: Icon(EvaIcons.personDone), 
              title: Text("Admin"),
              activeColor: Colors.indigo,
              inActiveColor: wheretoDark
              ),
              BottomBarItems(
              icon: Icon(EvaIcons.folderAdd), 
              title: Text("Restaurant"),
              activeColor: pureblue,
               inActiveColor: wheretoDark
              ),
              BottomBarItems(
              icon: Icon(EvaIcons.fileAdd), 
              title: Text("Rider"),
              activeColor: Colors.deepOrange,
               inActiveColor: wheretoDark
              )
          ],
          onItemSelected:(index) { selectAdmintab(_adminPages[index], index); },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: 
      //    pureblue,
      //   backgroundColor:
      //   Colors.white,
      //   unselectedItemColor: 
      //   // Color(0xFF176DB5),
      //   Color(0xFF0C375B),
      //   currentIndex: selectedindex,
      //   onTap: (int index) { selectAdmintab(_adminPages[index], index); },
      //   items: [
      //         BottomNavigationBarItem(
      //         icon: new Icon(Icons.dashboard),
      //         title: new Text('Dashboard'),
      //       ),
      //      BottomNavigationBarItem(
      //         icon: new Icon(Icons.add_to_queue),
      //         title: new Text('Add Restaurant'),
      //       ),
      //       BottomNavigationBarItem(
      //         icon: new Icon(Icons.motorcycle),
      //         title: new Text('Add Rider'),
      //       ),
      //   ],
      //   type: BottomNavigationBarType.fixed,
      //   ),   

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