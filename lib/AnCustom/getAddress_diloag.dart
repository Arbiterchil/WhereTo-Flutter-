import 'dart:ui';

import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class DialoggetterAddress extends StatefulWidget {
  
   final  Function ontap;

  const DialoggetterAddress({Key key, this.ontap}) : super(key: key);
   
  @override
  _DialoggetterAddressState createState() => _DialoggetterAddressState();
}

class _DialoggetterAddressState extends State<DialoggetterAddress> {

 

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
        elevation: 0,
        backgroundColor: pureblue,
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: Padding(padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              Text("Get Address Automatically?",
              maxLines: 2,
              style: TextStyle(
                fontFamily: 'Gilroy-light',
                fontSize: 16,
                color: pureblue
              ),
              ),
              SizedBox(height: 120,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                    color: pureblue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.my_location,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text("Get Address",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy-light',
                          fontSize: 12
                        ),
                        )
                      ],
                    ),
                  ),
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