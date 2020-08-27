


import 'package:WhereTo/Services/connectivity_service.dart';
import 'package:WhereTo/Services/connectivity_status.dart';
import 'package:WhereTo/Transaction/MyOrder/bloc.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';

import 'package:WhereTo/splash_screen/splash_screen.dart';
import 'package:dropdown_banner/dropdown_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


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
  // bool _isLoggedIn = false;

  @override
  void initState() {
    // _checkIfLoggedIn();
    super.initState();
  }

  // void _checkIfLoggedIn() async{
  //     // check if token is there
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     var token = localStorage.getString('token');
  //     if(token!= null){
  //        setState(() {
  //           _isLoggedIn = true;
  //        });
  //     }
  // }

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