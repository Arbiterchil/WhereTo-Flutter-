import 'dart:convert';

import 'package:WhereTo/Transaction/x_view.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyOrder/StatusStepper.dart';
import 'MyOrder/bloc.dart';
import 'MyOrder/getViewOrder.dart';

class MyNewViewOrder extends StatefulWidget {
  @override
  _MyNewViewOrderState createState() => _MyNewViewOrderState();
}

class _MyNewViewOrderState extends State<MyNewViewOrder> {
  var data;
  String transactID;
  String riderID;
  String status;
  String statusExist;
  int sunkist;
  bool isExist = false;
  BlocAll bloc;
  Future<void> getBloc(var id) async {
    await bloc.getMenuTransaction(id);
  }

  Future<void> disposeBloc() async {
    bloc.dispose();
  }

  final _navigatorKey = GlobalKey<NavigatorState>();
  var userData;
  var userID;
  bool isTrue = false;
  SharedPreferences localStorage;
  @override
  void initState() {
    getData();
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences value) {
      localStorage = value;
      var userJson = localStorage.getString('user');
      var user = json.decode(userJson);
      setState(() {
        userData = user;
        if (userData['id'] == null) {
          isTrue = false;
        } else {
          isTrue = true;
        }
        if (isTrue) {
          userID = userData['id'];
        } else {
          userID = "0";
        }
      });
    });
  }

  getData() async {
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      data = notification.payload.additionalData;
      setState(() {
        if (data != null) {
          print(data['transact_id'].toString());
          print(data['id'].toString());
          print(data['status'].toString());
          isExist = true;
          transactID = data['transact_id'].toString();
          riderID = data['id'].toString();
          status = data['status'].toString();
        } else {
          print("Error");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      bloc = BlocAll();
      getBloc(userID);
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(top: 40, left: 10, right: 10),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: GestureDetector(
          //       onTap: (){
          //         Navigator.pop(context);
          //         disposeBloc();
          //       },
          //       child: Container(
          //         height: 50,
          //         width: 50,
          //         decoration: BoxDecoration(
          //           color: Color(0xFF0C375B),
          //           shape: BoxShape.circle
          //         ),
          //         child: Center(
          //           child: Icon(
          //             Icons.arrow_back_ios,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     )
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: 55),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "My Orders",
                style: TextStyle(
                    fontSize: 36,
                    color: pureblue,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 70),
            child: xStreamAsshole(),
          ),
        ],
      ),
    );
  }

  Widget xStreamAsshole() {
    return StreamBuilder<List<ViewUserOrder>>(
      stream: bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            bool isFind =false;
            ProgressDialog _myOrder = ProgressDialog(context);
            _myOrder.style(
                message: "Canceling Order..",
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
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  if (snapshot.data.length > 0) {
                    if (transactID
                        .toString()
                        .contains(snapshot.data[index].id.toString())) {
                      sunkist = int.parse(status);
                    } else {
                      sunkist = int.parse(snapshot.data[index].status.toString());
                    }
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          XviewTransac(
                            image: "asset/img/app.jpg",
                            deliveryAddress:
                                snapshot.data[index].deliveryAddress,
                            address: snapshot.data[index].address,
                            restaurantName: snapshot.data[index].restaurantName,
                            status: sunkist == 0
                                ? snapshot.data[index].status.toString()
                                : sunkist.toString(),
                            onTapCancel: () {
                              if (snapshot.data[index].status ==0) {
                                showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return PlatformAlertDialog(
                                        title: Text(
                                          "Canceling Your Order will not be notified the Rider.",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontFamily: 'Gilroy-light'),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              Text(
                                                "Cancel Order?",
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontFamily: 'Gilroy-light'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          PlatformDialogAction(
                                              actionType: ActionType.Preferred,
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                    fontFamily: 'Gilroy-light'),
                                              ),
                                              onPressed: () async {
                                                List<dynamic> converted =[];
                                                Map<String, dynamic> temp;
                                                SharedPreferences local =
                                                await SharedPreferences.getInstance();
                                                var userjson = local.getString('user');
                                                var user = json.decode(userjson);
                                                _myOrder = ProgressDialog(context, type: ProgressDialogType.Normal,
                                                isDismissible: false);
                                                _myOrder.show();
                                                
                                                final response = await ApiCall().getData('/viewUserOrders/${user['id']}');
                                                final List<ViewUserOrder> transaction =viewUserOrderFromJson(response.body);
                                                int id;
                                                transaction.forEach((element) {
                                                id =element.id;
                                                temp ={
                                                  "id":id,
                                                  "status": element.status
                                                };
                                                converted.add(temp);
                                                });
                                                for(int z=0;z<converted.length;z++){
                                                  if(snapshot.data[index].id ==converted[z]['id']){
                                                    if(converted[z]['status'] <=0){
                                                      isFind =true;
                                                      break;
                                                    }else{
                                                      isFind =false;
                                                      break;
                                                    }
                                                  }
                                                }
                                                if(isFind){
                                                  var res = await ApiCall().postCancelOrder('/cancelOrder/${snapshot.data[index].id}');
                                                  if (res.statusCode == 200) {
                                                  var data =json.decode(res.body);
                                                    print(data);
                                                    print("Success");
                                                    _myOrder.hide();
                                                    setState(() {
                                                      snapshot.data.removeAt(index);
                                                    });
                                                    Navigator.of(context).pop();
                                                  }else{
                                                    _myOrder.hide();
                                                  }
                                              
                                                } else {
                                                  PlatformAlertDialog(
                                                    title: Text(
                                                      "The Order already accept by the Rider",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Gilroy-light'),
                                                    ),
                                                    actions: [
                                                      PlatformDialogAction(
                                                          actionType: ActionType
                                                              .Default,
                                                          child: Text(
                                                            "Okay",
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Gilroy-light'),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                    ],
                                                  );
                                                }
                                               
                                                
                                              }),
                                          PlatformDialogAction(
                                              actionType: ActionType.Default,
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                    fontFamily: 'Gilroy-light'),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              }),
                                        ],
                                      );
                                    });
                              } else {
                                return;
                              }
                            },
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context){
                              //   return StepperStatus(status: sunkist,);
                              // }));
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            );
          } else {
            return Container();
          }
        } else {
          return _load();
        }
      },
    );
  }

  Widget _load() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }
}
