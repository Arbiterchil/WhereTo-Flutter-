import 'dart:convert';

import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_views.dart';
import 'package:WhereTo/Rider_viewTransac/view_Transac.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../designbuttons.dart';

class RiderTransaction extends StatefulWidget {

   final String number;

  const RiderTransaction({Key key, this.number}) : super(key: key);

  @override
  _RiderTransactionState createState() => _RiderTransactionState();
}
class _RiderTransactionState extends State<RiderTransaction> {

  List<String> constants;

  @override
  void initState() {
    super.initState();
    // shared();
    // _getUseID();
  }

  // void shared() async{
    
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   localStorage.setStringList('userID', widget.number ); 

  // }

//   void _getUseID() async{

//   SharedPreferences local = await SharedPreferences.getInstance();
//   var stringId = local.getStringList('userID');
//   setState(() {
//     constants = stringId;
//   });

// }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFF398AE5),
    body: WillPopScope(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                     Container(
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: <Widget>[
                                    Align(
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
                                        onTap: ()  {
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                                return RiderProfile();
                                              }));
                                    },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: DesignButton(
                                        height: 55,
                                        width: 55,
                                        color: Color(0xFF398AE5),
                                        offblackBlue: Offset(-4, -4),
                                        offsetBlue: Offset(4, 4),
                                        blurlevel: 4.0,
                                        icon: Icons.refresh,
                                        iconSize: 30.0,
                                        onTap: (){
                                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                          //       return SearchDepo();
                                          //     }));
                                           
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                          return RiderTransaction();
                                          }));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                     SizedBox(height: 40.0,),
                     
                    RiderViewing(),
                    // _viewRider(),
                  ],
                ),
              ),
            ),
         
        ),
      ),
      onWillPop: () async => false),
    );
  }

  // Widget _viewRider(){
  //       return Container(
  //         child: FutureBuilder(
  //           future: getTransac(),
  //           builder: (BuildContext context , AsyncSnapshot snapshot){
  //                     if(snapshot.data == null){
  //                 return Container(
  //                   child: Center(
  //                     child: Text("No Transaction Yet...",
  //                     style: TextStyle(
  //             color: Colors.white,
  //             fontFamily: 'OpenSans',
  //             fontSize:  16.0,
  //             fontWeight: FontWeight.normal
  //           ),),    
  //                   ),
  //                 );
  //               }else{

  //                       return SingleChildScrollView(
  //           physics: AlwaysScrollableScrollPhysics(),
  //           child: Container(
  //             height: MediaQuery.of(context).size.height,
  //             width: MediaQuery.of(context).size.width,
  //             child: ListView.builder(
  //               itemCount: snapshot.data.length,
  //               itemBuilder: (context,index){
  //                  return Column(
  //                    children: <Widget>[
  //                     ViewTransacRider(
  //                       image: "asset/img/app.jpg",
  //                       transacId: snapshot.data[index].id.toString(),
  //                       name: snapshot.data[index].name,
  //                       address: snapshot.data[index].address,
  //                       deliveryAddress: snapshot.data[index].deliveryAddress,
  //                       restaurantName: snapshot.data[index].restaurantName,
  //                       onTap: (){
                          
  //                       },
  //                     ),
  //                    ],
  //                  );
  //               },
  //               ),
  //           ),
  //         );



  //               }
  //           },
  //         ),
  //       );


  // }

}