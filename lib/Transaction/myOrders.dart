import 'dart:async';
import 'dart:convert';

import 'package:WhereTo/Transaction/MyOrder/StatusStepper.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/Transaction/MyOrder/userOrder.dart';
import 'package:WhereTo/Transaction/x_view.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:WhereTo/main.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

import 'MyOrder/bloc.dart';

class MyOrder extends StatefulWidget {
  final String id;
  MyOrder({@required this.id});
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  var data;
  String transactID;
  String riderID;
  String status;
  String statusExist;
  String sunkist;
  bool isExist = false;
  BlocAll bloc;
final _navigatorKey = GlobalKey<NavigatorState>();
  String sec;
  Future<void> getBloc(var id) async {
    await bloc.getMenuTransaction(id);
  }

  Future<void> disposeBloc() async {
    bloc.dispose();
  }

  @override
  void initState() {
    getData();

    super.initState();
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
      getBloc(widget.id.toString());
    });
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
            ),
            Padding(
              padding: EdgeInsets.only(top: 55),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "My Orders",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF0C375B),
                      fontFamily: 'Gilroy-light',
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
                      sunkist = status;
                    } else {
                      sunkist = snapshot.data[index].status.toString();
                    }
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          XviewTransac(
                            image: "asset/img/doneprocess.png",
                            deliveryAddress: /*"snapshot.data[index].deliveryAddress*/ "",
                            address: snapshot.data[index].address,
                            restaurantName: snapshot.data[index].restaurantName,
                            status: sunkist == "0"
                                ? snapshot.data[index].status.toString()
                                : sunkist,
                            onTapCancel: () {
                              if (sunkist == "0" ||snapshot.data[index].status.toString().contains("0")) {
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
                                              decoration: TextDecoration.none,
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
                                              decoration: TextDecoration.none,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              fontFamily: 'Gilroy-light'),
                                            ), 
                                            onPressed: ()async{
                                              if(snapshot.data[index].status.toString().contains("0")){
                                                var res = await ApiCall().postCancelOrder('/cancelOrder/${snapshot.data[index].id}');
                                                if (res.statusCode == 200) {
                                                var data = json.decode(res.body);
                                                print(data);
                                                print("Success");
                                                setState(() {
                                                snapshot.data.removeAt(index);
                                                });
                                                Navigator.of(context).pop();
                                            }
                                              }else{
                                              PlatformAlertDialog(
                                              title: Text(
                                            "The Order already accept by the Rider",
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontFamily: 'Gilroy-light'),
                                        ),
                                        
                                        actions: [
                                         
                                            PlatformDialogAction(
                                            actionType: ActionType.Default,
                                            child: Text(
                                          "Okay",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontFamily: 'Gilroy-light'),
                                            ), 
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            }
                                            ),
                                        ],
                                      );
                                              }
                                            }
                                            ),
                                            PlatformDialogAction(
                                            actionType: ActionType.Default,
                                            child: Text(
                                          "No",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              fontFamily: 'Gilroy-light'),
                                            ), 
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            }
                                            ),
                                        ],
                                      );
                                    });
                              } else {}
                            },
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context){
                              //   return StepperStatus(status: sunkist);
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
