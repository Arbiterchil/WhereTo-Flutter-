import '../bloc.Navigation_bloc/navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../sidebar/sideBarHome.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
            child: Stack(
              children: <Widget>[
                BlocBuilder<NavigationBloc,NavigationStates>(
                  builder: (context, navigationState){
                    return navigationState as Widget;
                  },
                ),
                SideBarHome(),
              ],
            ),
          ),
         
        ],
      ),
    );
  }

}

