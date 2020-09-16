


import 'package:WhereTo/Services/connectivity_service.dart';
import 'package:WhereTo/Services/connectivity_status.dart';
import 'package:WhereTo/Transaction/MyOrder/bloc.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';

import 'package:WhereTo/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'api_restaurant_bloc/orderblocdelegate.dart';
void main() {
  
  BlocSupervisor.delegate =OrderBlocDelegate();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}
final navigatorKey = GlobalKey<NavigatorState>();
class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _initOneSignal().then((value) => print('Ready To get Notif'));
  }

  Future<void> _initOneSignal() async{
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
   OSPermissionSubscriptionState state = await OneSignal.shared.getPermissionSubscriptionState();
    String userId = state.jsonRepresentation();
    print(userId);
    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
   await OneSignal.shared.sendTags({'UR': 'TRUE'});  
  OneSignal.shared.init('f5091806-1654-435d-8799-0cbd5fc49280',iOSSettings: {
  OSiOSSettings.autoPrompt: false,
  OSiOSSettings.promptBeforeOpeningPushUrl: false
  });
   OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification){
    });
  }
 
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:(BuildContext context){
            return OrderBloc();
          } 
        ),
      ],
      
      child: StreamProvider<ConnectivityStatus>(
        create: (context) =>ConnectivityService().controller.stream,
        child:MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SplashScreen(),
        ), 
          
        ),
    );
  }
}