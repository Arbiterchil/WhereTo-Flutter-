import 'dart:convert';

import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_views.dart';
import 'package:WhereTo/Rider_viewTransac/view_Transac.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../designbuttons.dart';



class RiderTransaction extends StatefulWidget {

   final String number;

  const RiderTransaction({Key key, this.number}) : super(key: key);




  @override
  _RiderTransactionState createState() => _RiderTransactionState();
}

  

  


class _RiderTransactionState extends State<RiderTransaction> {

  var constants;

  @override
  void initState() {
    // notifmeNow();
    super.initState();
  }


//     void notifmeNow() async{

//  var status = await OneSignal.shared.getPermissionSubscriptionState();
//          String url = 'https://onesignal.com/api/v1/notifications';
//     var playerId = status.subscriptionStatus.userId;

//     var numb = "3";
//     var contents = {
//       "include_player_ids": [playerId],
//       "include_segments": ["Users Notif"],
//       "excluded_segments": [],
//       "contents": {"en": "This is a a Fucking test"},
//       "data": {"id": numb},
//       "headings": {"en": "Erchil Testings"},
//       "filter": [
//         {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
//       ],
//       "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
//     };
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
//     };
//     var repo =
//         await http.post(url, headers: headers, body: json.encode(contents));

//       print(repo.body);


//     }

  // Future<List<RiderViewClass>> getTransac() async {

        

  //       final response = await ApiCall().viewTransac('/getTransactionDetails/${widget.number}');
  //       List<RiderViewClass> riderme = [];
        
  //       var body = json.decode(response.body);
  //       for (var body in body){
  //           RiderViewClass riderViewClass = RiderViewClass
  //         (
  //           id: body["id"],
  //           name: body["name"],
  //           restaurantName: body["restaurantName"],
  //           address: body["address"],
  //           deliveryAddress: body["deliveryAddress"],);

  //           riderme.add(riderViewClass);
  //       }
  //       print(riderme.length);
  //       return riderme;
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