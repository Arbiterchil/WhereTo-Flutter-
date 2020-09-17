
import 'dart:convert';

import 'package:WhereTo/google_maps/address.class.dart';
import 'package:WhereTo/google_maps/addressBloc.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/google_maps/googlemap_address.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddressLine extends StatefulWidget {
  @override
  _AddressLineState createState() => _AddressLineState();
}

class _AddressLineState extends State<AddressLine> {
   
    final addressBloc =AddressBloc();
    Future<void>getBloc() async {
    await addressBloc.getDeliveryAddress();
    }

    Future<void> disposeBloc() async {
    addressBloc.dispose();
    }

   
    
  var userData;
  var coordi;
  var userID;
  bool isTrue = false;
  SharedPreferences localStorage;
  
  @override
  void initState() {
    
    super.initState();
    
  }




  @override
  Widget build(BuildContext context) {
    setState(() {
      getBloc();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            disposeBloc();
            Navigator.pop(context);
          },
        ),
        actions: [
          Row(
            children: [
              Text("Add New", softWrap: true, style: TextStyle(
              fontFamily: "Gilroy-light",
              fontSize: 15,
          ),), 
              IconButton(
          icon: Icon(Icons.add, color: Colors.white,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MapAdress()));
          },
        ),
            ],
          )
        ],
        title: Text(
          'Edit Address',
          style: TextStyle(
              fontFamily: "Gildroy-light",
              fontSize: 20,
              fontWeight: FontWeight.w300),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: StreamBuilder<List<Deliveryaddress>>(
            stream: addressBloc.sinkDeliver,
            builder: (context, snapshot){
              if(snapshot.data ==null){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else{
                if(snapshot.data.length >0){
                  return Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                        return Padding(padding: EdgeInsets.all(20),
                        child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0,3,)
                            )
                          ]
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text("${snapshot.data[index].addressName}", softWrap: true, style: TextStyle(
                                fontFamily: "Gilroy-light",
                                fontSize: 18,
                                ),), 
                             trailing: IconButton(
                               icon: Icon(Icons.check), 
                               onPressed: ()async{
                               SharedPreferences localStorage =await SharedPreferences.getInstance();
                               localStorage.setString('newAddress', snapshot.data[index].addressName);
                               localStorage.setString('newCoordinates', "${snapshot.data[index].latitude},${snapshot.data[index].longitude}");
                                Navigator.pop(context);
                               }) 
                          ),
                        )
                      ),
                    );
                     
                      
                      }),
                  );
                }else{
                  return Container();
                }
              }
            },
          )
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0,3,)
                          )
                        ]
                      ),
                      child: Center(
                        child: ListTile(
                          title: Column(
                            children: [
                              Text("Use Current Address", softWrap: true, style: TextStyle(
                              fontFamily: "Gilroy-light",
                              fontSize: 18,
                              ),), 
                              Text("$userData", softWrap: true, style: TextStyle(
                              fontFamily: "Gilroy-light",
                              fontSize: 18,
                              ),), 
                            ],
                          ),
                           trailing: IconButton(
                             icon: Icon(Icons.check, color: Colors.green,), 
                             onPressed: ()async{
                               SharedPreferences localStorage =await SharedPreferences.getInstance();
                               localStorage.setString('newAddress', userData);
                               localStorage.setString('newCoordinates', coordi);
                               Navigator.pop(context);
                             }) 
                        ),
                      )
                    ),
            )
        ],
      )
    );
  }
}
