

import 'package:WhereTo/Transaction/Data/response.dart';
import 'package:WhereTo/Transaction/Data/stream.dart';
import 'package:WhereTo/Transaction/MyOrder/getMenuPerTransaction.class.dart';
import 'package:WhereTo/Transaction/MyOrder/getTransactionDetails.class.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'MyOrder/bloc.dart';
import 'MyOrder/bloc.provider.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  void setState(fn) {
  
    super.setState(fn);
    userStream..getdata();
  }
  @override
  Widget build(BuildContext context) {
    
   
    return Scaffold(
      backgroundColor: Color(0xFF398AE5),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
         Padding(padding: EdgeInsets.only(top: 40, left: 10, right: 10),
          child:  Align(
              alignment: Alignment.topLeft,
              child: DesignButton(
                height: 55,
                width: 55,
                color: Color(0xFF398AE5),
                offblackBlue: Offset(-4, -4),
                offsetBlue: Offset(4, 4),
                blurlevel: 4.0,
                icon: Icons.arrow_back,
                iconSize: 30.0,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ), 
         ),
         Padding(
              padding: EdgeInsets.only(top: 55),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "My Orders",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 55),
              child: StreamBuilder<Response>(
                stream: userStream.subject.stream,
                builder: (context, AsyncSnapshot<Response> snapshot){
                  List<MenuOrderTransaction> details =snapshot.data.getview;
                  if(details.length >0){
                    return ListView.builder(
                    itemCount:details.length,
                    itemBuilder: (context, index){
                      return Text("data: ${details[index].name}", style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,

                      ),);
                    }
                    );
                  }else{
                    return Container();
                  }
                }
                ),
              ),
            
        ],
      ),
    );
  }
}