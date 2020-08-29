import 'dart:ui';

import 'package:WhereTo/Admin/updateAdmin/menu_update.dart';
import 'package:WhereTo/Admin/updateAdmin/restu_update.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class ChooseEditto extends StatefulWidget {

       final int menuId;
       final int restaurantId;

  const ChooseEditto({Key key, this.menuId, this.restaurantId}) : super(key: key);

 

  @override
  _ChooseEdittoState createState() => _ChooseEdittoState();
}

class _ChooseEdittoState extends State<ChooseEditto> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
      child: Dialog(
         shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
        child: Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){

            Navigator.push(  
            context,
            new MaterialPageRoute(
            builder: (context) => MenuUpdateNewTwo(
              menuId: widget.menuId,
              restaurantId: widget.restaurantId,
            )));

                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: pureblue
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: Center(
                      child: Text("Edit Menu",
                      style: TextStyle(
                        color: pureblue,
                        fontSize: 18,
                        fontFamily: 'Gilroy-light'
                      ),                     
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                 GestureDetector(
                  onTap: (){

                      Navigator.push(  
            context,
            new MaterialPageRoute(
            builder: (context) => RestaurantUpdateNewTwo(
              restaurantId: widget.restaurantId,
            )));
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: pureblue
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    child: Center(
                      child: Text("Edit Restaurant",
                      style: TextStyle(
                        color: pureblue,
                        fontSize: 18,
                        fontFamily: 'Gilroy-light'
                      ),                     
                      ),
                    ),
                  ),
                ),

              ],
            ),
        ),

      ),
      
    );
  }
}