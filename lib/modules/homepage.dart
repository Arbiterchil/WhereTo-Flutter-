import 'dart:convert';

import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/AnCustom/send_helpID.dart';
import 'package:WhereTo/AnCustom/send_validId.dart';
import 'package:WhereTo/Transaction/newView_MyOrder.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/Tab_naviUser.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/modules/profile.dart';
import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
    String _currentPage = "SearchRestaurant";
  
   List<String> pageKeys = ["SearchRestaurant","UserProfile","MyOrders"];
   Map<String,GlobalKey<NavigatorState>> _navigatorKeys =
    {
     "SearchRestaurant":GlobalKey<NavigatorState>(),
     "UserProfile":GlobalKey<NavigatorState>(),
     "MyOrders":GlobalKey<NavigatorState>(),
   };
 int _selectedIndex = 0;
  var userData;
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

  @override
  
  void initState() {
    this.getShared();
    this.configSignal();
    this.postuserId();
    super.initState();
    
  }
String meesages = "You have Violated the Terms and Condition that your Valid Id is not acceptable.";
 var data;
 var checkbool;
 var idmine;
 void getShared() async {

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user');
      checkbool = localStorage.getBool('check'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  

 }
void configSignal() async {
     await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');

    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification){
      data = notification.payload.additionalData;
      setState(() {
        //  constant = notification.payload.additionalData;
        
        setState(() {
          if(data != null){
            if(data["force"] == "penalty"){
              print(data['force'].toString());
                _showDone(meesages.toString());
            }
             
          }
        });
        
      });
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
    print(responses);
    // print(userData['id'].toString());
    var response = await ApiCall().getCheckUser('/getUserVerification/${userData['id']}');
   var body = json.decode(response.body);
   print(body['imagePath']);
   if(body['imagePath'] == null){
     print("Fuck This");
    //  UserDialog_Help.exit(context)
    // SendsValidId.showgetValid(context);
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



  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: _child[_selectedIndex],

      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: 
        Colors.white,
        backgroundColor:
        pureblue, 
        unselectedItemColor: 
        Color(0xFF0C375B),

        currentIndex: _selectedIndex,
        onTap: onTabTapped,
        // onTap: (int index) { _selectTab(pageKeys[index], index); },
        items: [
              BottomNavigationBarItem(
              icon: new Icon(Icons.view_list),
              title: new Text('Search'),
            ), 
            BottomNavigationBarItem(
              icon: new Icon(Icons.list),
              title: new Text('My Orders'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            // BottomNavigationBarItem(
            //   icon: new Icon(Icons.person),
            //   title: new Text('Edit'),
            // ),
        ],
        type: BottomNavigationBarType.fixed,
        ),   

    );
  }
void _showDone(String message){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
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
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: pureblue,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
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
                      
                  child: Text ( "OK", style :TextStyle(
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
void _showSenValid(){

}
}