import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../styletext.dart';

class SimpleAppLoader extends StatefulWidget {
  @override
  _SimpleAppLoaderState createState() => _SimpleAppLoaderState();
}

class _SimpleAppLoaderState extends State<SimpleAppLoader> with TickerProviderStateMixin {
  
  var duration =  const Duration(seconds: 3);  

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

           child: Padding(
             padding: const EdgeInsets.only(right: 100,left:100),
             child: Container(
               height: 60,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.all(Radius.circular(10),)
               ),
                 child: Center(
                   child: SpinKitFadingCircle(
                     color: wheretoDark,
                     size: 40,
                    //  controller: AnimationController(vsync: this,
                    //  duration: duration,
                    //  ),
                 ),
               ),
               
             
         ),
           ),
      ),
    );
  }

   startTIme(){
    return Timer(duration, route);
  }

  route(){
    Navigator.pop(context);
  }

}