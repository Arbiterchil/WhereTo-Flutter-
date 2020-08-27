import 'dart:convert';
import 'dart:ffi';

import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/Rider_MonkeyBar/rider_bottom.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/view_MenuTransac.dart';
import 'package:WhereTo/Rider_viewTransac/DummyTesting/dummy_Card.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_views.dart';
import 'package:WhereTo/Rider_viewTransac/view_Transac.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../designbuttons.dart';



class RiderTransaction extends StatefulWidget {



  const RiderTransaction({Key key}) : super(key: key);
  @override
  _RiderTransactionState createState() => _RiderTransactionState();
}
class _RiderTransactionState extends State<RiderTransaction> {

  
var totalAll;
  var priceTotal = 0 ;
  var totals;
  bool getmessage = false;
  bool mine = false;
  var constant;
  var finalID;
  var playerId;
  var user_coor;
  var userRN;
  var idgetter;
 
  @override
  void initState() {
    mybackUp();
   
    super.initState();
  }
// void notifmeNow() async{
 
//   var status = await OneSignal.shared.getPermissionSubscriptionState();
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
//     // var repo =
//         await http.post(url, headers: headers, body: json.encode(contents));
//       // print(repo.body);    
//      }



// Future<List<RiderViewClass>> getTransac() async {
//   // print(idsComming);
//   //       for(int i = 0; i < idsComming.length; i++){
//   //         idsComeNow =idsComming[i];
          
//   //       }

//         final response = await ApiCall().viewTransac('/getTransactionDetails/$finalID');
//         // final response = await ApiCall().viewTransac('/getTransactionDetails/3');
//         List<RiderViewClass> riderme = [];
//         var body = json.decode(response.body);
//         for (var body in body){
//             RiderViewClass riderViewClass = RiderViewClass
//           (
//             id: body["id"],
//             name: body["name"],
//             restaurantName: body["restaurantName"],
//             address: body["address"],
//             deviceId: body["deviceId"],
//             riderId: body["riderId"],
//             deliveryAddress: body["deliveryAddress"],
//             status: body["status"],
//             deliveryCharge: body["deliveryCharge"]
//             );

//             riderme.add(riderViewClass);
//         }

//         return riderme;
        
//   }

mybackUp() {
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
                constant =notification.payload.additionalData; 
                setState(()  {
                  if(constant != null){
                     getThisShitOn(constant['transact_id']);  
                    print(constant['id'].toString());
                    print(constant['transact_id'].toString());
                    print(constant['player_id'].toString());
                    print(constant['user_coordinates'].toString());
                    print(constant['transac_id'].toString());
                    getmessage = true;
                    finalID = constant['transact_id'];
                    playerId = constant['player_id'].toString();
                    // user_coor = constant['user_coordinates'].toString();
                    // idsComming.add(finalID);
                                  
                  }else{
                    print("No Data");
                  }
                });          
    });
 }   
Map<String,String> alldata ={};  
List idsComming = [];

var idsComeNow;
 List inCommingtoSave = [];
void getThisShitOn(String id) async{
final response = await ApiCall().viewTransac('/getTransactionDetails/$id');
          List body = json.decode(response.body);
                  for(int i = 0 ; i < body.length; i++){
                    alldata =
                    {
               "id": body[i]['id'].toString(),
              "name":  body[i]['name'].toString(),
              "barangayName":  body[i]['barangayName'].toString(),
              "restaurantName":  body[i]['restaurantName'].toString(),
              "address": body[i]['address'].toString(),
              "deliveryAddress":  body[i]['deliveryAddress'].toString(),
              "created_at":  body[i]['created_at'].toString(),
              "deviceId":  body[i]['deviceId'].toString(),
              "riderId":  body[i]['riderId'].toString(),
              "status":  body[i]['status'].toString(),
              "deliveryCharge":  body[i]['deliveryCharge'].toString()
                    };
                   setState(() {
                      inCommingtoSave.add(alldata);
                   });
                  }

                  print(inCommingtoSave);
              

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFFF2F2F2),
    // Color(0xFF398AE5),
    body: WillPopScope(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                  SizedBox(height: 40.0,),
                   _viewRider(),
                  // RiderViewing()
                  ],
                ),
              ),
            ),
         
        ),
      ),
      onWillPop: () async => false),
    );
  }
  Widget _viewRider(){

      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: inCommingtoSave.length,
            itemBuilder: (context , index){

              return Column(
                       children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Customgettransac( image: "asset/img/logo.png",
                            transacId: inCommingtoSave[index]['id'],
                            name: inCommingtoSave[index]['name'],
                            address: inCommingtoSave[index]['address'],
                            deliveryAddress: inCommingtoSave[index]['deliveryAddress'],
                            restaurantName: inCommingtoSave[index]['restaurantName'],
                            onTap: () async {
                               
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                                    return ViewMenuOnTransac(
                                                      getID: inCommingtoSave[index]['id'],
                                                      deliverTo: inCommingtoSave[index]['deliveryAddress'],
                                                      restaurantName: inCommingtoSave[index]['restaurantName'],
                                                      deviceID: inCommingtoSave[index]['deviceId'],
                                                      riderID: inCommingtoSave[index]['riderId'],
                                                      deliveryCharge: inCommingtoSave[index]['deliveryCharge'],
                                                      nametran:  inCommingtoSave[index]['name'],
                                                      playerId: playerId.toString(),
                                                      user_coor : user_coor.toString());
                                                  }));

                            },),
                        ),
                       ],
                     );

            },
          ),


      );


        // return Container(
        //     child: FutureBuilder(
        //       future: getTransac(),
        //       builder: (BuildContext context , AsyncSnapshot snapshot){
        //                 if(snapshot.data == null){
        //             return Container(
        //               child: Center(
        //                 child: Text("No Transaction Yet...",
        //                 style: TextStyle(
        //         color: Colors.white,
        //         fontFamily: 'OpenSans',
        //         fontSize:  16.0,
        //         fontWeight: FontWeight.normal
        //       ),),    
        //               ),
        //             );
        //           }else{

        //                   return SingleChildScrollView(
        //       physics: AlwaysScrollableScrollPhysics(),
        //       child: Container(
        //         height: MediaQuery.of(context).size.height,
        //         width: MediaQuery.of(context).size.width,
        //         child: ListView.builder(
        //           itemCount: snapshot.data.length,
        //           itemBuilder: (context,index){
        //              return Column(
        //                children: <Widget>[

        //                 Customgettransac( image: "asset/img/app.jpg",
        //                   transacId: snapshot.data[index].id.toString(),
        //                   name: snapshot.data[index].name,
        //                   address: snapshot.data[index].address,
        //                   deliveryAddress: snapshot.data[index].deliveryAddress,
        //                   restaurantName: snapshot.data[index].restaurantName,
        //                   onTap: () async {
                             
        //                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        //                                           return ViewMenuOnTransac(
        //                                             getID: snapshot.data[index].id.toString(),
        //                                             // gotTotal: totals.toString(),
        //                                             deliverTo: snapshot.data[index].deliveryAddress.toString(),
        //                                             restaurantName: snapshot.data[index].restaurantName.toString(),
        //                                             deviceID: snapshot.data[index].deviceId.toString(),
        //                                             riderID: snapshot.data[index].riderId.toString(),
        //                                             deliveryCharge: snapshot.data[index].deliveryCharge.toString(),
        //                                             nametran:  snapshot.data[index].name,
        //                                             playerId: playerId.toString(),
        //                                             user_coor : user_coor.toString());
        //                                         }));

        //                   },),
        //                ],
        //              );
        //           },
        //           ),
        //       ),
        //     );



        //           }
        //       },
        //     ),
         
        // );


  }

}