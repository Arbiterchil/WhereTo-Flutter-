import 'dart:convert';

import 'package:WhereTo/A_loadingSimpe/for_Order.dart';
import 'package:WhereTo/Transaction/MyOrder/DialogOrder.dart';
import 'package:WhereTo/Transaction/newView_MyOrder.dart';
import 'package:WhereTo/google_maps/address.dart';
import 'package:WhereTo/Transaction/getDeviceID/getDeviceID.class.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/modules/homepage.dart';
import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PayOrder extends StatefulWidget {
  final double fee;
  final String restauID;
  final double userLat;
  final double userLng;
  PayOrder({this.fee, this.restauID, this.userLat, this.userLng});
  @override
  _PayOrderState createState() => _PayOrderState();
}

class _PayOrderState extends State<PayOrder> {
  var userData;
  var address;
  var newAddress;
  var add;
  double lat;
  double lng;
  double passtotal;
  TextEditingController delivery = new TextEditingController();
  var newcoordinates;
  @override
  void initState() {
    super.initState();
   
  }

 

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              'Checkout',
              softWrap: true,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Gilroy-light',
                  fontSize: 20),
            )),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1, left: 13, right: 13),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: BlocConsumer<OrderBloc, List<TransactionOrders>>(
                    builder: (context, snapshot) {
                      return Builder(builder: (context) {
                        Map<String, dynamic> string;
                        Map<String, int> converted1 = {};
                        List<dynamic> order1 = [];
                        List<dynamic> result1 = [];
                        var name;
                        var quantity;
                        snapshot.forEach((element) {
                          name = element.name;
                          quantity = element.quantity;

                          string = {"name": '$name', "quantity": '$quantity'};

                          order1.add(string);
                        });
                        for (int z = 0; z < order1.length; z++) {
                          var item = order1[z];
                          if (converted1.containsKey(item['name'])) {
                            converted1[item['name']] +=
                                int.parse(item['quantity']);
                          } else {
                            converted1[item['name']] =
                                int.parse(item['quantity']);
                          }
                        }
                        converted1.forEach((key, value) {
                          result1.add({"name": key, "quantity": value});
                        });

                        double total = 0;

                        for (int z = 0; z < snapshot.length; z++) {
                          total += snapshot[z].price * snapshot[z].quantity;
                        }
                        double totalOrder =
                            widget.fee + double.parse(total.toString());
                        passtotal = widget.fee + double.parse(total.toString());
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15,top: 10),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text("Order Summary: ",
                                    style: TextStyle(
                                      color: wheretoDark,
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 20
                                    ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Builder(
                                  builder: (context) {
                                    return Container(
                                     
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: result1.length,
                                          itemBuilder: (cont, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Colors.grey[300],
                                                          spreadRadius: 2.2,
                                                          blurRadius: 2.2)
                                                    ]),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 20,
                                                        ),
                                                        child: Text(
                                                          "${result1[index]['name']}",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Gilroy-ExtraBold",
                                                            color: wheretoDark,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 20,
                                                        ),
                                                        child: Text(
                                                          "‎x${result1[index]['quantity']}",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Gilroy-ExtraBold",
                                                            color: wheretoDark,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 240),
                                child: Container(
                                  height: 170,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300],
                                            spreadRadius: 2.2,
                                            blurRadius: 2.2)
                                      ]),
                                  child: Builder(builder: (context) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Payment Details",
                                          style: TextStyle(
                                              fontFamily: "Gilroy-ExtraBold",
                                              color: wheretoDark,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 11,
                                        ),
                                        Container(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 20,
                                                  ),
                                                  child: Text(
                                                    "Subtotal",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Gilroy-ExtraBold",
                                                      color: wheretoDark,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 20,
                                                  ),
                                                  child: Text(
                                                    "‎${total.toStringAsFixed(2)}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Gilroy-ExtraBold",
                                                      color: wheretoDark,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 20,
                                                  ),
                                                  child: Text(
                                                    "Delivery Fee",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Gilroy-ExtraBold",
                                                      color: wheretoDark,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 20,
                                                  ),
                                                  child: Text(
                                                    "‎${widget.fee}",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Gilroy-ExtraBold",
                                                      color: wheretoDark,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              
                                            ],
                                          ),
                                        ),
                                        
                                      ],
                                    );
                                  }),
                                ),
                              ),
                             
                             Container(
                               margin: EdgeInsets.only(bottom: 50),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      decoration: eBoxDecorationStyle,
                                      height: 50.0,
                                      child: TextFormField(
                                                cursorColor: pureblue,
                                                keyboardType: TextInputType.text,
                                                keyboardAppearance: Brightness.dark,
                                                textInputAction: TextInputAction.done,
                                                controller: delivery,
                                                validator: (val) {


                                                },
                                                style: TextStyle(
                                                  color: pureblue,
                                                  fontFamily: 'Gilroy-light',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.only(top: 14.0),
                                                  prefixIcon: Icon(
                                                    Icons.my_location,
                                                    color: pureblue,
                                                  ),
                                                  hintText: 'Complete and Exact Delivery Address',
                                                  hintStyle: eHintStyle,
                                                ),
                                              ),
                                            ),
                                              
                             
                            ],
                          ),
                        );
                      });
                    },
                    listener: (BuildContext context, orderList) {},
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(7, 0),
                    blurRadius: 4.4,
                    spreadRadius: 4.4)
              ],
            ),
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: BlocConsumer<OrderBloc, List<TransactionOrders>>(
              builder: (context, snapshot) {
                return Builder(builder: (con) {
                  Map<String, dynamic> string;
                  Map<String, int> converted1 = {};
                  List<dynamic> order1 = [];
                  List<dynamic> result1 = [];
                  var name;
                  var quantity;
                  snapshot.forEach((element) {
                    name = element.name;
                    quantity = element.quantity;

                    string = {"name": '$name', "quantity": '$quantity'};

                    order1.add(string);
                  });
                  for (int z = 0; z < order1.length; z++) {
                    var item = order1[z];
                    if (converted1.containsKey(item['name'])) {
                      converted1[item['name']] += int.parse(item['quantity']);
                    } else {
                      converted1[item['name']] = int.parse(item['quantity']);
                    }
                  }
                  converted1.forEach((key, value) {
                    result1.add({"name": key, "quantity": value});
                  });

                  double total = 0;
                  for (int z = 0; z < snapshot.length; z++) {
                    total += snapshot[z].price * snapshot[z].quantity;
                  }
                  double totalOrder =
                      widget.fee + double.parse(total.toString());
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Total: ",
                              style: TextStyle(
                                  color: wheretoDark,
                                  fontSize: 16,
                                  fontFamily: 'Gilroy-ExtraBold')),
                          TextSpan(
                              text: "${totalOrder.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: wheretoDark,
                                  fontSize: 16,
                                  fontFamily: 'Gilroy-light')),
                        ])),
                        Container(
                          height: 40,
                          width: 130,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [wheretoDark, pureblue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [
                                    0.3,
                                    1,
                                  ])),
                          child: RaisedButton(
                            color: Colors.transparent,
                            onPressed: () async {
                            if(delivery.text.isEmpty){
                              DialogOrder().getDialog(
                                    context,
                                    "Empty Fields",
                                    "Delivery Address Is a Must",
                                    Icons.error,
                                    Color(0xFFFF3345));
                            }else{
                              ProgressDialog orders = ProgressDialog(context);
                              orders.style(
                                  message:
                                      "Notifying The Riders about the Order..",
                                  borderRadius: 10.0,
                                  backgroundColor: Colors.white,
                                  progressWidget:
                                      SpinKitDoubleBounce(color: Colors.blue),
                                  elevation: 10.0,
                                  insetAnimCurve: Curves.easeInExpo,
                                  progressTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "Gilroy-light"));
                              orders = ProgressDialog(context,
                                  type: ProgressDialogType.Normal,
                                  isDismissible: false);
                              orders.show();
                              var id;
                              var quantity;
                              var transactID;
                              Map<String, dynamic> string;
                              Map<String, dynamic> post;
                              Map<String, int> converted = {};
                              List<dynamic> order = [];
                              List<dynamic> result = [];
                              SharedPreferences localStorage =
                                  await SharedPreferences.getInstance();
                              var userJson = localStorage.getString('user');
                              var user = json.decode(userJson);
                              address =
                                  "${localStorage.getString("unit_number")}, ${localStorage.getString("house_number")}, ${localStorage.getString("building")}, ${localStorage.getString("street_name")}";
                              snapshot.forEach((element) async {
                                setState(() {
                                  id = element.id;
                                  quantity = element.quantity;

                                  string = {
                                    'menuId': '$id',
                                    'quantity': '$quantity',
                                  };
                                  order.add(string);
                                });
                              });
                              for (int z = 0; z < order.length; z++) {
                                var item = order[z];
                                if (converted.containsKey(item['menuId'])) {
                                  converted[item['menuId']] +=
                                      int.parse(item['quantity']);
                                } else {
                                  converted[item['menuId']] =
                                      int.parse(item['quantity']);
                                }
                              }
                              converted.forEach((key, value) {
                                result.add({"menuId": key, "quantity": value});
                              });

                              print(result);
                              setState(() {
                                post = {
                                  'userId': user['id'],
                                  'restaurantId': this.widget.restauID,
                                  'order': result,
                                  "deliveryAddress":delivery.text,
                                  "deliveryCharge": "${widget.fee}",
                                  "barangayId": user['barangayId'],
                                };
                                print(post);
                              });

                             
                                var res = await ApiCall().postOrder(post, '/putOrder');
                                var data = json.decode(res.body);
                                  setState(() {
                                    transactID = data;
                                  });
                                  print(data);
                                  print("Success");
                                  orders.hide();
                                  DialogOrder().getDialog(
                                      context,
                                      "Order Succesfully Placed",
                                      "Order Success",
                                      Icons.check,
                                      Colors.black);
                                  BlocProvider.of<OrderBloc>(context)
                                      .add(Computation.deleteAll());
                                  Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=> HomePage()),ModalRoute.withName('/'));
                                   final response =
                                    await ApiCall().getData('/getAllPlayerId');
                                List<GetPlayerId> search =
                                    getPlayerIdFromJson(response.body);
                                List<dynamic> player = [];
                                search.forEach((element) {
                                  player.add(element.deviceId);
                                  print(element.deviceId);
                                });
                                await OneSignal.shared.setLocationShared(true);
                                await OneSignal.shared
                                    .promptLocationPermission();
                                await OneSignal.shared.init(
                                    'f5091806-1654-435d-8799-0cbd5fc49280');
                                OneSignal.shared.setInFocusDisplayType(
                                    OSNotificationDisplayType.notification);
                                OneSignal.shared.setNotificationReceivedHandler(
                                    (OSNotification notification) {});

                                await OneSignal.shared.setSubscription(true);
                                await OneSignal.shared.getTags();
                                var status = await OneSignal.shared
                                    .getPermissionSubscriptionState();

                                String url =
                                    'https://onesignal.com/api/v1/notifications';
                                var playerId = status.subscriptionStatus.userId;
                                var contents = {
                                  "include_player_ids": player,
                                  "include_segments": ["All"],
                                  "excluded_segments": [],
                                  "contents": {"en": "A new Order!"},
                                  "data": {
                                    "id": user['id'].toString(),
                                    "player_id": playerId.toString(),
                                    "transact_id": transactID.toString(),
                                    "user_coordinates":
                                        "${0},${0}"
                                  },
                                  "headings": {"en": "New Order"},
                                  "filter": [
                                    {
                                      "field": "tag",
                                      "key": "UR",
                                      "relation": "=",
                                      "value": "TRUE"
                                    },
                                  ],
                                  "app_id":
                                      "f5091806-1654-435d-8799-0cbd5fc49280"
                                };
                                Map<String, String> headers = {
                                  'Content-Type': 'application/json',
                                  'authorization':
                                      'Basic MGM5OTlmNzgtYzdlMi00NjUyLWFlOGEtZDYxZDM5YTUwNjll'
                                };

                                await http.post(url,
                                    headers: headers,
                                    body: json.encode(contents));
                                print(playerId);
                            }    
                              
                                
                               
                               
                              
                              
                            },
                            child: Center(
                              child: Text("Place Order",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              },
              listener: (BuildContext context, orderList) {},
            ),
          ),
        ),
      ),
    );
  }
}
