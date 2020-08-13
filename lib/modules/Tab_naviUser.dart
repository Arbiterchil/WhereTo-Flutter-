
import 'package:WhereTo/Transaction/myOrders.dart';
import 'package:WhereTo/Transaction/newView_MyOrder.dart';
import 'package:WhereTo/modules/profile.dart';
import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import 'package:flutter/material.dart';

class TabNaviUserRoutes{
  static const String root = '/';
  static const String detail = '/detail';
}


class TabUserNav extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
 

  TabUserNav({this.navigatorKey,this.tabItem});
  
  
  @override
  Widget build(BuildContext context) {
     Widget child ;
    
   if(tabItem == "SearchRestaurant")
      child = SearchDepo();
   else if(tabItem == "UserProfile")
      child = Profile();
    else if(tabItem == "MyOrders")
    child = MyNewViewOrder();

    
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