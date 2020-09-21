import 'dart:convert';

import 'package:WhereTo/Transaction/MyOrder/DialogOrder.dart';
import 'package:WhereTo/Transaction/x_view.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyOrder/Receipt/Receipt.dart';
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
  var resto;
  var userAddress;
  final bloc = BlocAll();
  Future<void> getBloc() async {
    await bloc.getMenuTransaction();
  }

  Future<void> disposeBloc() async {
    bloc.dispose();
  }

  var userData;
  var userID;
  bool isTrue = false;
  SharedPreferences localStorage;
  @override
  void initState() {
    getData();

    super.initState();
    _onsSignal();
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

  String meesages =
      "You have Violated the Terms and Condition that your Valid Id is not acceptable.";
  String datass = "";
  _onsSignal() async {
    if (!mounted) return;
    await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.setSubscription(true);
    await OneSignal.shared.getTags();
    await OneSignal.shared.sendTags({'UR': 'TRUE'});
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      setState(() {
        datass = notification.payload.additionalData["force"].toString();
        print("$datass is you");
        // if(data != null){
        if (datass == "penalty") {
          _showDone(meesages.toString());
        } else {
          print("None");
        }
        // }
      });
    });
  }

  void _showDone(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 300.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('asset/img/penalty.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      message,
                      style: TextStyle(
                          color: Color(0xFF0C375B),
                          fontWeight: FontWeight.w700,
                          fontSize: 11.0,
                          fontFamily: 'Gilroy-light'),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Color(0xFF0C375B),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () async {
                          SharedPreferences localStorage =
                              await SharedPreferences.getInstance();
                          localStorage.remove('user');
                          localStorage.remove('token');
                          localStorage.remove('menuplustrans');
                          //  print(body);
                          Navigator.pushAndRemoveUntil(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              ModalRoute.withName('/'));
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getBloc();
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
      stream: bloc.sinkMyOrder,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            bool isFind = false;
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
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          FutureBuilder(
                          future: CoordinatesConverter().getCoordinates(snapshot, index),
                          builder: (context, datasnapshot) {
                              if (transactID.toString().contains(
                                  snapshot.data[index].id.toString())) {
                                sunkist = int.parse(status);
                              } else {
                                sunkist = int.parse(snapshot.data[index].status.toString());
                              }
                              return XviewTransac(
                                image: "asset/img/doneprocess.png",
                                deliveryAddress: "",
                                address: datasnapshot.data ==null ?"":datasnapshot.data,
                                restaurantName:snapshot.data[index].restaurantName,
                                status: sunkist == null
                                    ? snapshot.data[index].status.toString()
                                    : sunkist.toString(),
                                onTapCancel: () {
                                  if (snapshot.data[index].status == 0) {
                                    showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PlatformAlertDialog(
                                            title: Text(
                                              "Canceling Your Order will not be notified the Rider.",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'Gilroy-light'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              PlatformDialogAction(
                                                  actionType:
                                                      ActionType.Preferred,
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'Gilroy-light'),
                                                  ),
                                                  onPressed: () async {
                                                    List<dynamic> converted =
                                                        [];
                                                    Map<String, dynamic> temp;
                                                    SharedPreferences local =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    var userjson =
                                                        local.getString('user');
                                                    var user =
                                                        json.decode(userjson);
                                                    _myOrder = ProgressDialog(
                                                        context,
                                                        type: ProgressDialogType
                                                            .Normal,
                                                        isDismissible: false);
                                                    _myOrder.show();

                                                    final response =
                                                        await ApiCall().getData(
                                                            '/viewUserOrders/${user['id']}');
                                                    final List<ViewUserOrder>
                                                        transaction =
                                                        viewUserOrderFromJson(
                                                            response.body);
                                                    int id;
                                                    transaction
                                                        .forEach((element) {
                                                      id = element.id;
                                                      temp = {
                                                        "id": id,
                                                        "status": element.status
                                                      };
                                                      converted.add(temp);
                                                    });
                                                    for (int z = 0;
                                                        z < converted.length;
                                                        z++) {
                                                      if (snapshot
                                                              .data[index].id ==
                                                          converted[z]['id']) {
                                                        if (converted[z]
                                                                ['status'] <=
                                                            0) {
                                                          isFind = true;
                                                          break;
                                                        } else {
                                                          isFind = false;
                                                          break;
                                                        }
                                                      }
                                                    }
                                                    if (isFind) {
                                                      var res = await ApiCall()
                                                          .postCancelOrder(
                                                              '/cancelOrder/${snapshot.data[index].id}');
                                                      if (res.statusCode ==
                                                          200) {
                                                        var data = json
                                                            .decode(res.body);
                                                        print(data);
                                                        print("Success");
                                                        _myOrder.hide();
                                                        setState(() {
                                                          snapshot.data
                                                              .removeAt(index);
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      } else {
                                                        _myOrder.hide();
                                                      }
                                                    } else {
                                                      _myOrder.hide();
                                                      DialogOrder().getDialog(
                                                          context,
                                                          "This Order is already Under Process",
                                                          "Order Delayed",
                                                          Icons.warning,
                                                          Colors.red);
                                                    }
                                                  }),
                                              PlatformDialogAction(
                                                  actionType:
                                                      ActionType.Default,
                                                  child: Text(
                                                    "No",
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'Gilroy-light'),
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
                                  if(snapshot.data[index].status ==4){
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ReceiptWidget(
                                      transactID:
                                          snapshot.data[index].id.toString(),
                                    );
                                  }));
                                  }
                                },
                              );
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
            return Center(child: Image.asset("asset/img/emptycart.png"));
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
