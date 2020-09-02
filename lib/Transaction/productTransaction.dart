import 'dart:convert';

import 'package:WhereTo/Transaction/Barangay/Barangay.class.dart';
import 'package:WhereTo/Transaction/MyOrder/ComputationFee.dart';
import 'package:WhereTo/Transaction/MyOrder/payOrder.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TransactionList extends StatefulWidget {
  final String barangay;
  final String restauID;
  TransactionList({this.restauID, this.barangay});
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  String lat;
  String long;
  List<dynamic> summary = [];
  String displaytotal;
  @override
  void setState(fn) async {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ProgressDialog pr = ProgressDialog(context);
                      pr.style(
                          message: "Calculating Please Wait a Moment..",
                          borderRadius: 10.0,
                          backgroundColor: Colors.white,
                          progressWidget: CircularProgressIndicator(),
                          elevation: 10.0,
                          insetAnimCurve: Curves.easeInExpo,
                          progressTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Gilroy-light"));
                      return Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 50),
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
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                    padding: EdgeInsets.only(
                                                        top: 5,
                                                        bottom: 20,
                                                        left: 5),
                                                    child: Container(
                                                      height: 40,
                                                      width: 100,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 20 / 4,
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xFF0C375B),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                      child: Center(
                                                        child: Text(
                                                          "₱ " +
                                                              snapshot[index]
                                                                  .price
                                                                  .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                            color: Colors.white,
                                                            letterSpacing: 1,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 120,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20)),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "asset/img/noodles.jpg"),
                                                                fit: BoxFit
                                                                    .cover))),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10, left: 7),
                                                      child: Text(
                                                        snapshot[index].name,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF0C375B),
                                                          fontSize: 15,
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8, left: 7),
                                                      child: Text(
                                                        snapshot[index]
                                                            .description,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF0C375B),
                                                          fontSize: 12,
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 90, left: 170),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
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
                                                                  onTap: () {
                                                                    if (snapshot[index]
                                                                            .quantity >
                                                                        1) {
                                                                      setState(
                                                                          () {
                                                                        snapshot[index]
                                                                            .quantity = snapshot[index]
                                                                                .quantity -
                                                                            1;
                                                                        print(
                                                                            ' ${snapshot[index].id.toString()} ${snapshot[index].quantity.toString()}');
                                                                      });
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 30,
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 25,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 30,
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    snapshot[
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      snapshot[index]
                                                                              .quantity =
                                                                          snapshot[index].quantity +
                                                                              1;
                                                                      print(
                                                                          ' ${snapshot[index].id.toString()} ${snapshot[index].quantity.toString()}');
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            right:
                                                                                5),
                                                                    width: 30,
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 25,
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
                            alignment: Alignment.bottomRight,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    height: 55,
                                    width: double.infinity,
                                    child: GestureDetector(
                                      onTap: () async {
                                         pr = ProgressDialog(context,
                                         type: ProgressDialogType.Normal,
                                         isDismissible: false);
                                        pr.show();
                                       
                                        
                                        var fee = await ComputationFee().getFee(widget.barangay);
                                        if (snapshot.length == 0) {
                                          print("No Order");
                                          pr.hide();
                                        } else {
                                          pr.hide();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PayOrder(
                                                          fee: fee,
                                                          restauID: widget
                                                              .restauID)));
                                        }
                                        // SharedPreferences localStorage = await SharedPreferences.getInstance();
                                        // var userJson = localStorage.getString('user');
                                        // var user = json.decode(userJson);
                                        // print(fee);
                                        // print(widget.barangay);
                                        // print(user['barangayId']);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 190,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF0C375B),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "View Place Orders ",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontFamily: 'Gilroy-light'),
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
                      );
                    },
                    listener: (BuildContext context, orderList) {}),
              ),
            ),
          ],
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
