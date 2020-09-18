import 'dart:async';
import 'dart:ui';

import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../styletext.dart';

class ForOrderLoading extends StatefulWidget {
  @override
  _ForOrderLoadingState createState() => _ForOrderLoadingState();
}

class _ForOrderLoadingState extends State<ForOrderLoading> {

    var duration =  const Duration(seconds: 4);  


     startTIme(){
    return Timer(duration, route);
  }

  route(){
  //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SearchDepo()));
  Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    startTIme();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 7,sigmaY: 7),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
        elevation: 0,
         backgroundColor: Colors.transparent,

           child:  Container(
               height: 80,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.all(Radius.circular(10),)
               ),
                 child: Center(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         SpinKitFadingCircle(
                             color: wheretoDark,
                             size: 40,
                            //  controller: AnimationController(vsync: this,
                            //  duration: duration,
                            //  ),
                
                         ),
                         SizedBox(width: 10),
           Text("Notifying The Riders about you're Order.",
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                       fontFamily: 'Gilroy-light',
                       fontSize: 9,
                       fontWeight: FontWeight.bold
                   
                   ),
                 )
                       ],
                     ),
                   ),
             
               
             
         
           ),
      ),
    );
  }
}