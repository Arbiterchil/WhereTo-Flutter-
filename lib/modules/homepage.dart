import 'dart:convert';

import 'package:WhereTo/A1_NewSingleBottomNav/bottom_nav.dart';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/AnCustom/send_helpID.dart';
import 'package:WhereTo/AnCustom/send_validId.dart';
import 'package:WhereTo/Rider/Tab_navi.dart';
import 'package:WhereTo/Transaction/newView_MyOrder.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/modules/Tab_naviUser.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/modules/profile.dart';
import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import 'package:WhereTo/styletext.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
    String _currentPage = "SearchRestaurant";
    String meesages = "You have Violated the Terms and Condition that your Valid Id is not acceptable.";
 String data;
 var checkbool;
 var idmine;
 var gethis;
 bool lace =false;
   List<String> pageKeys = ["SearchRestaurant","MyOrders","UserProfile"];
   Map<String,GlobalKey<NavigatorState>> _navigatorKeys =
    {
     "SearchRestaurant":GlobalKey<NavigatorState>(),
     "MyOrders":GlobalKey<NavigatorState>(),
     "UserProfile":GlobalKey<NavigatorState>(),
   };
 int _selectedIndex = 0;
 void _selectTab(String tabItem, int index) {
    if(tabItem == _currentPage ){
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }
  var userData;
  String image;

  @override
  
  void initState() {
     getShared();
// getThis();
    super.initState();
    _onsSignal();
        //  configSignal();
    postuserId();
    
    
  }
  var datapasser;
var userLat;
  var userLng ;
  getThis() async{
    userLat =await ID().getLat();
  userLng =await ID().getLng();     
   setState(() {
      print(" okMother $userLat  $userLng");
   });
  }


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
 void getShared() async {

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user');
      checkbool = localStorage.getBool('check'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  

 }
 
//  configSignal(){

          
// }

void postuserId() async {
   OSPermissionSubscriptionState status = await OneSignal.shared.getPermissionSubscriptionState();
    String playerId = status.subscriptionStatus.userId;
    var data =
    {
      "userId" : userData['id'].toString(),
      "playerId" : playerId
    };   
    
    var responses = await ApiCall().playerIdSave(data,'/assignPlayerId');
    print(responses.body);
    gethis = userData['id'].toString();
    var response = await ApiCall().getCheckUser('/getUserVerification/$gethis');
   var body = json.decode(response.body);

   print(body['imagePath']);
    image = body['imagePath'];
   if(body['imagePath'] == null){
     print("Fuck This");
    sendsValidId(userData['id'].toString());
   }else{
     print("getBack");
   }
}
void sendsValidId(String message){
showDialog(context: context,
barrierDismissible: false,
builder: (context) => ValidIds(id: message,));


}
  final List<Widget> _child = 
  [
    SearchDepo(),
    MyNewViewOrder(),
    Profile(),
  ];


void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabUserNav(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  final List<Widget> _childs= 
  [
     SearchDepo(),
     MyNewViewOrder(),
     Profile()
  ];

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
      //  onWillPop: () async {
        
      //   final isFirstRouteInCurrentTab =
      //       !await _navigatorKeys[_currentPage].currentState.maybePop();
            
      //   if (isFirstRouteInCurrentTab) {
      //     if (_currentPage != "SearchRestaurant") {
      //       _selectTab("SearchRestaurant", 1);
            
      //       return false;
            
      //     }
          
      //   }
      //    return isFirstRouteInCurrentTab ?  UserDialog_Help.exit(context) : false ;
      //  },
      //  child: Stack(
      //     children: <Widget>[ 
      //       _buildOffstageNavigator("SearchRestaurant"),
      //       _buildOffstageNavigator("MyOrders"),
      //       _buildOffstageNavigator("UserProfile"),
      //     ],
      //   ),

      child: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[..._childs],
      ),
      ),
      bottomNavigationBar: BottomNavBar(
      
        selectedIndex: _selectedIndex,
          backColor: Colors.white,
          containHieght: 60,
          itemCorner: 40,
          items: [
            BottomBarItems(
              icon: Icon(EvaIcons.heart), 
              title: Text("Home"),
              activeColor: Colors.indigo,
              inActiveColor: wheretoDark
              ),
              BottomBarItems(
              icon: Icon(EvaIcons.list), 
              title: Text("My Order"),
              activeColor: pureblue,
               inActiveColor: wheretoDark
              ),
              BottomBarItems(
              icon: Icon(EvaIcons.person), 
              title: Text("Pofile"),
              activeColor: Colors.deepOrange,
               inActiveColor: wheretoDark
              )
          ],
            showElavation: true,
          onItemSelected: onTabTapped),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: 
      //   pureblue,
      //   backgroundColor:
      //   Colors.white, 
      //   unselectedItemColor: 
      //   Color(0xFF0C375B),

      //   currentIndex: _selectedIndex,
      //   onTap: onTabTapped,
      //   // currentIndex: _selectedIndex,
      //   // onTap: (int index) { _selectTab(pageKeys[index], index); },
      //   items: [
      //         BottomNavigationBarItem(
      //         icon: new Icon(Icons.view_list),
      //         title: new Text('Search'),
      //       ), 
      //       BottomNavigationBarItem(
      //         icon: new Icon(Icons.list),
      //         title: new Text('My Orders'),
      //       ),
      //       BottomNavigationBarItem(
      //         icon: new Icon(Icons.home),
      //         title: new Text('Home'),
      //       ),
      //   ],
      //   type: BottomNavigationBarType.fixed,
      //   ),   

    );
  }

}