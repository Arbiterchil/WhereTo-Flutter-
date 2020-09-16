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
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class PayOrder extends StatefulWidget {
  final double fee;
  final String restauID;
  PayOrder({this.fee, this.restauID});
  @override
  _PayOrderState createState() => _PayOrderState();
}
class _PayOrderState extends State<PayOrder> {
  var userData;
  var address;
  var newAddress;
  var add;
  var coordinates;
  var newcoordinates;
  @override
  void initState() {
    super.initState();
    getAddress();
    getNewAd();
    getCoordinates();
    getnewCoordinates();
  }


  getAddress() async{
  var address =await ID().getaddress();
  var converter =await CoordinatesConverter().convert(address);
  setState(() {
    userData =converter;
  });
}
  getNewAd() async{
    var newad =await ID().getnewAddress();
    setState(() {
      newAddress =newad;
    });
  }
  getCoordinates() async{
    var coordi =await ID().getCoordinates();
    setState(() {
      coordinates =coordi;
    });
  }
  getnewCoordinates() async{
    var newCoor =await ID().getnewCoordinates();
    setState(() {
      newcoordinates =newCoor;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
          child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40, left: 15),
                  child: Align(
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
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 13, right: 13),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: BlocConsumer<OrderBloc, List<TransactionOrders>>(
                      builder: (context, snapshot) {
                        // ProgressDialog orders= ProgressDialog(context);
                        // orders.style(
                        // message: "Notifying The Riders about the Order..",
                        // borderRadius: 10.0,
                        // backgroundColor: Colors.white,
                        // progressWidget: CircularProgressIndicator(),
                        // elevation: 10.0,
                        // insetAnimCurve: Curves.easeInExpo,
                        // progressTextStyle: TextStyle(
                        // color: Colors.black,
                        // fontSize: 10.0,
                        // fontWeight: FontWeight.w300,
                        // fontFamily: "Gilroy-light"));
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
                          double totalOrder = widget.fee +double.parse(total.toString());
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 80),
                                child: SingleChildScrollView(
                                  child: Builder(builder: (context) {
                                    return Stack(
                                      children: [
                                        Card(
                                          elevation: 15.5,
                                          color: Color(0xFF0C375B),
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 1),
                                            child: ListView.builder(
                                                physics: BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: result1.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    title: Text(
                                                      "${result1[index]['name']}",
                                                      style: TextStyle(
                                                        fontFamily: "Gilroy-light",
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    trailing: Text(
                                                      "‎x${result1[index]['quantity']}",
                                                      style: TextStyle(
                                                        fontFamily: "Gilroy-light",
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: SingleChildScrollView(
                                  child: Builder(builder: (context) {
                                    return Stack(
                                      children: [
                                        Card(
                                          elevation: 15.5,
                                          color: Color(0xFF0C375B),
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 1),
                                            child: Center(
                                                child: Padding(
                                              padding: EdgeInsets.only(bottom: 1),
                                              child: ListTile(
                                                title: Text(
                                                  "Subtotal",
                                                  style: TextStyle(
                                                    fontFamily: "Gilroy-light",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                trailing: Text(
                                                  "‎${total.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                    fontFamily: "Gilroy-light",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: SingleChildScrollView(
                                  child: Builder(builder: (context) {
                                    return Stack(
                                      children: [
                                        Card(
                                          elevation: 15.5,
                                          color: Color(0xFF0C375B),
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 1),
                                            child: Center(
                                                child: Padding(
                                              padding: EdgeInsets.only(bottom: 1),
                                              child: ListTile(
                                                title: Text(
                                                  "Delivery Fee",
                                                  style: TextStyle(
                                                    fontFamily: "Gilroy-light",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                trailing: Text(
                                                  "‎${widget.fee}",
                                                  style: TextStyle(
                                                    fontFamily: "Gilroy-light",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: SingleChildScrollView(
                                  child: Builder(builder: (context) {
                                    return Stack(
                                      children: [
                                        Card(
                                          elevation: 15.5,
                                          color: Color(0xFF0C375B),
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 1),
                                            child: Center(
                                                child: Padding(
                                              padding: EdgeInsets.only(bottom: 1),
                                              child: ListTile(
                                                title: Text(
                                                  "Total(incl. VAT)",
                                                  style: TextStyle(
                                                    fontFamily: "Gilroy-light",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                trailing: Text(
                                                  "‎${totalOrder.toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                    fontFamily: "Gilroy-light",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Container(
                                  child: Builder(builder: (context) {
                                    return Stack(
                                      fit: StackFit.passthrough,
                                      children: [
                                        Card(
                                          elevation: 15.5,
                                          color: Color(0xFF0C375B),
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Center(
                                                child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: ListTile(
                                                title: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                  "Delivery Address",
                                                  style: TextStyle(
                                                    fontFamily: "Gilroy-light",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  " ${newAddress.toString().contains("null")?userData:newAddress}",
                                                  style: TextStyle(
                                                    fontFamily: "Gilroy-light",
                                                    color: Colors.white,
                                                    fontSize: 12
                                                  ),
                                                ),
                                                  ],
                                                )
                                                    
                                                 
                                                  ),

                                            )),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              
                              Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Container(
                                          height: 55,
                                          width: double.infinity,
                                          child: GestureDetector(
                                            onTap: () async {
                                              
                                              // orders = ProgressDialog(context, type: ProgressDialogType.Normal,
                                              // isDismissible: false);
                                              // orders.show();

                                                showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (con)=>ForOrderLoading());

                                              var location = Location();
                                              var userLocation =
                                                  await location.getLocation();
                                              var id;
                                              var quantity;
                                              var transactID;
                                              Map<String, dynamic> string;
                                              Map<String, dynamic> post;
                                              Map<String, int> converted = {};
                                              List<dynamic> order = [];
                                              List<dynamic> result = [];
                                              String address;
                                              SharedPreferences localStorage =await SharedPreferences.getInstance();
                                              var userJson =localStorage.getString('user');
                                              var user = json.decode(userJson);
                                              address ="${localStorage.getString("unit_number")}, ${localStorage.getString("house_number")}, ${localStorage.getString("building")}, ${localStorage.getString("street_name")}";
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
                                                if (converted
                                                    .containsKey(item['menuId'])) {
                                                  converted[item['menuId']] +=
                                                      int.parse(item['quantity']);
                                                } else {
                                                  converted[item['menuId']] =
                                                      int.parse(item['quantity']);
                                                }
                                              }
                                              converted.forEach((key, value) {
                                                result.add({
                                                  "menuId": key,
                                                  "quantity": value
                                                });
                                              });

                                              print(result);
                                              setState(() {
                                                post = {
                                                  'userId': user['id'],
                                                  'restaurantId':
                                                      this.widget.restauID,
                                                  'order': result,
                                                  "deliveryAddress": "${newcoordinates.toString().contains("null")?coordinates:newcoordinates}",
                                                  "deliveryCharge": "${widget.fee}",
                                                  "barangayId": user['barangayId'],
                                                };
                                                // print(post);
                                              });

                                              try{
                                              var res = await ApiCall().postData(post, '/putOrder');
                                              if (res.statusCode == 200) {
                                                var data = json.decode(res.body);
                                                setState(() {
                                                  transactID = data;
        
                                                });
                                                print(data);
                                                print("Success");
                                                // orders.hide();
                                                  DialogOrder().getDialog(context, "Order Succesfully Placed", "Order Success", Icons.check, Colors.black);
                                                  BlocProvider.of<OrderBloc>(context).add(Computation.deleteAll());
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SearchDepo()));
                                              }else{
                                              // orders.hide();
                                               DialogOrder().getDialog(context, "Slow/No Internet Connection", "Order Failed", Icons.error, Color(0xFFFF3345));
                                              }
                                              final response = await ApiCall().getData('/getAllPlayerId');
                                              List<GetPlayerId> search =getPlayerIdFromJson(response.body);
                                              List<dynamic> player = [];
                                              search.forEach((element) {
                                                player.add(element.deviceId);
                                                print(element.deviceId);
                                              });
                                              await OneSignal.shared
                                                  .setLocationShared(true);
                                              await OneSignal.shared
                                                  .promptLocationPermission();
                                              await OneSignal.shared.init(
                                                  'f5091806-1654-435d-8799-0cbd5fc49280');
                                              OneSignal.shared.setInFocusDisplayType(
                                                  OSNotificationDisplayType
                                                      .notification);
                                              OneSignal.shared
                                                  .setNotificationReceivedHandler(
                                                      (OSNotification
                                                          notification) {});

                                              await OneSignal.shared
                                                  .setSubscription(true);
                                              await OneSignal.shared.getTags();
                                              var status = await OneSignal.shared
                                                  .getPermissionSubscriptionState();

                                              String url =
                                                  'https://onesignal.com/api/v1/notifications';
                                              var playerId =
                                                  status.subscriptionStatus.userId;
                                              var contents = {
                                                "include_player_ids": player,
                                                "include_segments": ["All"],
                                                "excluded_segments": [],
                                                "contents": {
                                                  "en": "A new Order!"
                                                },
                                                "data": {
                                                  "id": user['id'].toString(),
                                                  "player_id": playerId.toString(),
                                                  "transact_id":
                                                      transactID.toString(),
                                                  "user_coordinates":
                                                      "${userLocation.latitude},${userLocation.longitude}"
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
                                              }catch(e){
                                              //  orders.hide();
                                               DialogOrder().getDialog(context, "Slow/No Internet Connection", "Order Failed", Icons.error, Color(0xFFFF3345));
                                              }
                                              // print(tags);
                                              // print(repo);
                                            },
                                            child: Container(
                                              height: 60,
                                              width: 190,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF0C375B),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Place Order",
                                                  style: TextStyle(
                                                      decoration: TextDecoration.none,
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
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
