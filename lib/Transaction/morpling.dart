
import 'package:WhereTo/Transaction/sorties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MorfButton  extends StatelessWidget {
  final IconData icon;
  final bool down;
  final Function ontap;
  MorfButton({this.icon, this.down, this.ontap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: down ? morphInvert:morph ,
      child: GestureDetector(
        child: Icon(icon, color: down ?fCD: fCL,),
        onTap: this.ontap,
      ),
      
    );
  }
}

