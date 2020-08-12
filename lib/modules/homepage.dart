import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/modules/Tab_naviUser.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
    String _currentPage = "SearchRestaurant";
  
   List<String> pageKeys = ["SearchRestaurant","UserProfile"];
   Map<String,GlobalKey<NavigatorState>> _navigatorKeys =
    {
     "SearchRestaurant":GlobalKey<NavigatorState>(),
     "UserProfile":GlobalKey<NavigatorState>()
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
  void initState() {
    // configSignal();
    super.initState();
  }

void configSignal() async {
     await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');

    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});                            
}

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: WillPopScope(
      onWillPop: () async {
        
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
            
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "SearchRestaurant") {
            _selectTab("SearchRestaurant", 1);
            
            return false;
            
          }
          
        }
        
        return isFirstRouteInCurrentTab ? UserDialog_Help.exit(context) : false ;
      // return isFirstRouteInCurrentTab;
      },
          child: Stack(
          children: <Widget>[
            
            _buildOffstageNavigator("UserProfile"),
            _buildOffstageNavigator("SearchRestaurant"),
          ],
        ),
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: 
        // Color(0xFF398AE5),
        Colors.white,
        // unselectedItemColor: Colors.grey,
        backgroundColor:
        Color(0xFF0C375B), 
        // Color(0xFFF2F2F2)
        //  Color(0xFF398AE5),
        unselectedItemColor: 
        Color(0xFF176DB5),
        currentIndex: _selectedIndex,
        onTap: (int index) { _selectTab(pageKeys[index], index); },
        items: [
              BottomNavigationBarItem(
              icon: new Icon(Icons.view_list),
              title: new Text('Search'),
            ),
           BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.inbox),
              title: new Text('History'),
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
      child: TabUserNav(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}