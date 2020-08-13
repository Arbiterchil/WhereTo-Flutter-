
import 'package:WhereTo/Admin/admin_addrestu.dart';
import 'package:WhereTo/Admin/admin_dash.dart';
import 'package:flutter/material.dart';

class TabSwitchAdmin extends StatelessWidget {

 final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  TabSwitchAdmin({this.navigatorKey,this.tabItem});

  @override
  Widget build(BuildContext context) {
    Widget child ;
    
   if(tabItem == "DashBoard")
      child = AdminDash();
   else if(tabItem == "Add_Restaurant")
      child = AdminAddRestaurant();
      
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child
        );
      },
    );
  }
}