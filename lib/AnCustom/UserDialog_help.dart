
import 'package:WhereTo/AnCustom/LocationSet.dart';
import 'package:WhereTo/AnCustom/UserDialog_out.dart';
import 'package:flutter/material.dart';

class UserDialog_Help{

  static exit(context) => showDialog(context: context,builder: (context) => UserExit());
  static getLocation(context) =>showDialog(context: context, builder: (context) =>LocationSet());
}