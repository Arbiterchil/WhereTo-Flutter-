import 'dart:convert';
import 'package:WhereTo/Rider/Tab_navi.dart';
import 'package:WhereTo/Rider/rider_dash.dart';
import 'package:WhereTo/Rider_viewTransac/view_Transac.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:WhereTo/AnCustom/dialogHelp.dart';
import 'package:WhereTo/Rider_viewTransac/rider_viewtransac.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../designbuttons.dart';
import '../styletext.dart';

class RiderProfile extends StatefulWidget {
 
  @override
  _RiderProfileState createState() => _RiderProfileState();
}

class _RiderProfileState extends State<RiderProfile> {
 

    String _currentPage = "Profile";
  
   List<String> pageKeys = ["Profile","Transaction"];
   Map<String,GlobalKey<NavigatorState>> _navigatorKeys =
    {
     "Profile":GlobalKey<NavigatorState>(),
     "Transaction":GlobalKey<NavigatorState>()
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
      // onWillPop: () async
      //     { return await Dialog_Helper.exit(context);},
      onWillPop: () async {
        
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
            
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Profile") {
            _selectTab("Profile", 1);
            
            return false;
            
          }
          
        }
        // let system handle back button if we're on the first route
        
        return isFirstRouteInCurrentTab ? Dialog_Helper.exit(context) : false ;
      },
          child: Stack(
          children: <Widget>[
            _buildOffstageNavigator("Profile"),
            _buildOffstageNavigator("Transaction"),
          ],
        ),
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: 
        Color(0xFF398AE5),
        // Colors.white,
        // unselectedItemColor: Colors.grey,
        backgroundColor:
        Color(0xFFF2F2F2),
        //  Color(0xFF398AE5),
        currentIndex: _selectedIndex,
        onTap: (int index) { _selectTab(pageKeys[index], index); },
        items: [
       
           BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('DashBoard'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.view_list),
              title: new Text('Transactions'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.inbox),
              title: new Text('Inbox'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: new Text('Edit'),
            ),
        ],
        type: BottomNavigationBarType.fixed,
        ),   

    );
  }
    Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}


