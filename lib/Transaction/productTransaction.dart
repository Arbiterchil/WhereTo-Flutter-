import 'dart:convert';

import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/A_loadingSimpe/simple_loading.dart';
import 'package:WhereTo/Transaction/Barangay/Barangay.class.dart';
import 'package:WhereTo/Transaction/MyOrder/ComputationFee.dart';
import 'package:WhereTo/Transaction/MyOrder/payOrder.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:WhereTo/google_maps/address.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/google_maps/deliveryCharge.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:location/location.dart';

import '../styletext.dart';

class TransactionList extends StatefulWidget {
  final String restaurantAddress;
  final String restauID;
  final double restoLat;
  final double restoLng;
  final double userLat;
  final double userLng;
  TransactionList(
      {this.restauID, this.restaurantAddress, this.restoLat, this.restoLng, this.userLat, this.userLng});
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  String lat;
  String long;
  List<dynamic> summary = [];
  String displaytotal;
  @override
  void initState() {
   
    super.initState();
    
  }

  

  void reminderShow() {
    showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) => DialogForAll(
        widgets: SpinKitRotatingCircle(
          color: wheretoDark,
          size: 80,
        ),
        labelHeader: "Reminder!",
        message: "To remove order just long press the menu you want to remove.",
        buttTitle1: "OK",
        buttTitle2: "",
        noFunc: null,
        yesFunc: () => Navigator.pop(context),
        showorNot1: true,
        showorNot2: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                splashColor: wheretoLight,
                color: pureblue,
                child: Center(
                  child: Text(
                    "Click this to show how to remove a menu.",
                    style: TextStyle(
                        fontFamily: 'Gilroy-light', color: Colors.white),
                  ),
                ),
                onPressed: () => reminderShow()),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFF0C375B), shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "My Cart",
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF0C375B),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Gilroy-light'),
                  ),
                ),
              ),
              Align(
                  // Navigator.pop(context);
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => BlocProvider.of<OrderBloc>(context)
                        .add(Computation.deleteAll()),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFF0C375B), shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 56),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: BlocConsumer<OrderBloc, List<TransactionOrders>>(
                      buildWhen: (List<TransactionOrders> previous,
                          List<TransactionOrders> current) {
                        return true;
                      },
                      listenWhen: (List<TransactionOrders> previous,
                          List<TransactionOrders> current) {
                        if (current.length > previous.length) {
                          return true;
                        }
                        return false;
                      },
                      builder: (context, snapshot) {
                        if (snapshot.length == 0) {
                          return Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Column(
                              children: [
                                Image.asset("asset/img/emptycart.png"),
                              ],
                            ),
                          ));
                        } else {
                          return Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 150),
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                                child: Container(
                                              height: 120,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF2F2F2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 4.4,
                                                      blurRadius: 4.4),
                                                ],
                                              ),
                                              child: InkWell(
                                                onLongPress: () {
                                                  BlocProvider.of<OrderBloc>(
                                                          context)
                                                      .add(Computation.delete(
                                                          index));
                                                },
                                                child: Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5,
                                                                bottom: 20,
                                                                left: 5),
                                                        child: Container(
                                                          height: 40,
                                                          width: 100,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: 20 / 4,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFF0C375B),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          30))),
                                                          child: Center(
                                                            child: Text(
                                                              "₱ " +
                                                                  snapshot[
                                                                          index]
                                                                      .price
                                                                      .toStringAsFixed(
                                                                          2),
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    1,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                          width: 120,
                                                          height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: ExtendedImage
                                                              .network(
                                                            snapshot[index]
                                                                .image,
                                                            height:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                            width: 120,
                                                            fit: BoxFit.fill,
                                                            cache: true,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 1.1),
                                                            shape:
                                                                BoxShape.circle,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        30.0)),
                                                          )),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10,
                                                                  left: 7),
                                                          child: Text(
                                                            snapshot[index]
                                                                .name,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF0C375B),
                                                              fontSize: 15,
                                                              letterSpacing: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8,
                                                                  left: 7),
                                                          child: Text(
                                                            snapshot[index]
                                                                .description,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF0C375B),
                                                              fontSize: 12,
                                                              letterSpacing: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 70,
                                                                left: 10),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Container(
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (snapshot[index].quantity >
                                                                            1) {
                                                                          setState(
                                                                              () {
                                                                            snapshot[index].quantity =
                                                                                snapshot[index].quantity - 1;
                                                                            print(' ${snapshot[index].id.toString()} ${snapshot[index].quantity.toString()}');
                                                                          });
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            30,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              Color(0xFF0C375B),
                                                                          size:
                                                                              25,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: 30,
                                                                      child: Center(
                                                                          child: Text(
                                                                        snapshot[index]
                                                                            .quantity
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Color(0xFF0C375B)),
                                                                      )),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          snapshot[index].quantity =
                                                                              snapshot[index].quantity + 1;
                                                                          print(
                                                                              ' ${snapshot[index].id.toString()} ${snapshot[index].quantity.toString()}');
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                5),
                                                                        width:
                                                                            30,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Color(0xFF0C375B),
                                                                          size:
                                                                              25,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            )),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Colors.white),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Stack(
                                            children: <Widget>[
                                              Card(
                                                elevation: 15.5,
                                                color: Color(0xFF0C375B),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Container(
                                                    height: 60,
                                                    width: double.infinity,
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        //  var distance = new Distance()
                                                        // final double km = distance.as(LengthUnit.Kilometer, LatLng(widget.restoLat, widget.restoLng), LatLng(postion.latitude,postion.longitude));
                                                        // double charge = 30.0;
                                                        // for (int c = 4; c <= km; c++) {
                                                        // if (c > 4) {
                                                        // charge += 5;
                                                        // } else {
                                                        // charge += 0;
                                                        // }
                                                        // }
                                                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>PayOrder(fee: charge,restauID:widget.restauID)));
                                                        // Location location = new Location();
                                                        // bool _serviceEnabled;
                                                        // PermissionStatus _permissionGranted;
                                                        // LocationData locationData;
                                                        // _serviceEnabled = await location.serviceEnabled();
                                                        // if (!_serviceEnabled) {
                                                        //   _serviceEnabled = await location.requestService();
                                                        //   if (!_serviceEnabled) {
                                                        //     return;
                                                        //   }
                                                        // }

                                                        // _permissionGranted = await location.hasPermission();
                                                        // if (_permissionGranted == PermissionStatus.denied) {
                                                        //   _permissionGranted = await location.requestPermission();
                                                        //   if (_permissionGranted != PermissionStatus.granted) {
                                                        //     return;
                                                        //   }
                                                        // }

                                                      //  locationData = await location.getLocation(); 
                                                      //  print("${locationData.latitude}, ${locationData.longitude}");
                                                      print(widget.userLat);
                                                      
                                                      },
                                                      child: Container(
                                                        height: 20,
                                                        width: 160,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF0C375B),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "View Place Orders ",
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'Gilroy-light'),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // Padding(
                                              //   padding: EdgeInsets.only(top: 13, left: 30),
                                              //   child: Container(
                                              //     child: Text(
                                              //       "View Place Orders ",
                                              //       style: TextStyle(
                                              //           fontSize: 25,
                                              //           fontWeight: FontWeight.w400,
                                              //           color: Colors.white,
                                              //           fontFamily: 'Gilroy-light'
                                              //           ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              // Align(
                              //   alignment: Alignment.bottomLeft,
                              //   child: Padding(
                              //     padding: EdgeInsets.only(bottom: 80),
                              //     child: Container(
                              //       height: 70,
                              //       child: Builder(builder: (context) {
                              //         return Stack(
                              //           children: [
                              //             Card(
                              //               elevation: 15.5,
                              //               color: Color(0xFF0C375B),
                              //               child: Padding(
                              //                 padding: EdgeInsets.all(5),
                              //                 child: Center(
                              //                     child: Padding(
                              //                   padding: EdgeInsets.all(5),
                              //                   child: ListTile(
                              //                     title: Column(
                              //                       crossAxisAlignment: CrossAxisAlignment.start,
                              //                       children: [
                              //                         Text(
                              //                       "Optional Delivery Address",
                              //                       style: TextStyle(
                              //                         fontFamily: "Gilroy-light",
                              //                         color: Colors.white,
                              //                       ),
                              //                     ),
                              //                      Text(
                              //                       "You can choose Optional Delivery Address",
                              //                       style: TextStyle(
                              //                         fontFamily: "Gilroy-light",
                              //                         color: Colors.white,
                              //                         fontSize: 10,
                              //                       ),
                              //                     ),
                              //                       ],
                              //                     ),
                              //                     trailing: IconButton(icon: Icon(Icons.edit, color: Colors.white), onPressed: (){
                              //                       Navigator.push(context, MaterialPageRoute(builder: (context){
                              //                         return AddressLine();
                              //                       }));
                              //                     }),
                              //                   ),
                              //                 )),
                              //               ),
                              //             ),
                              //           ],
                              //         );
                              //       }),
                              //     ),
                              //   ),
                              // ),
                            ],
                          );
                        }
                      },
                      listener: (BuildContext context, orderList) {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // sentNotif(String restoStreet) async {
  //   await OneSignal.shared.setLocationShared(true);
  //   await OneSignal.shared.promptLocationPermission();

  //   await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');

  //   OneSignal.shared
  //       .setInFocusDisplayType(OSNotificationDisplayType.notification);
  //   await OneSignal.shared.setSubscription(true);

  //   var tags = await OneSignal.shared.getTags();
  //   print(tags);
  //   await OneSignal.shared.deleteTags(["Penongs Quirante II", "TRUE"]);
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();
  //   String url = 'https://onesignal.com/api/v1/notifications';
  //   var playerId = status.subscriptionStatus.userId;

  //   await OneSignal.shared.sendTags({"$restoStreet": "TRUE"});
  //   var contents = {
  //     "include_player_ids": [playerId],
  //     "include_segments": ["Penongs Quirante II"],
  //     "excluded_segments": [],
  //     "contents": {"en": "New Order"},
  //     "headings": {"en": "Penongs Building Quirante II"},
  //     // "data":{"test":userData["name"]},
  //     "filter": [
  //       {
  //         "field": "tag",
  //         "key": "$restoStreet",
  //         "relation": "=",
  //         "value": "TRUE"
  //       },
  //     ],
  //     "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
  //   };
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
  //   };
  //   var repo =
  //       await http.post(url, headers: headers, body: json.encode(contents));
  //   print(repo.body);
  // }
}
