import 'package:WhereTo/A_loadingSimpe/locationchanges.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/modules/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocateUserPage{

String guyUser = UserGetPref().userGetPage;


  plums(BuildContext context){
    if(guyUser == null){
                            showDialog(
                            barrierDismissible: false,
                            context: (context),
                            builder: (context) =>
                            LocationChangeforUsers(),
                             );
    }else{
       Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_)
      => HomePage()));
    }

  }


}

final locateUserPage = LocateUserPage();