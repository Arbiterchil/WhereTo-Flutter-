import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.bloc.dart';
import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReceiptWidget extends StatelessWidget {
  final String transactID;
  ReceiptWidget({this.transactID});
  @override
  Widget build(BuildContext context) {
    final ReceiptBloc blocReceipt = ReceiptBloc(this.transactID);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "User Receipt",
            softWrap: true,
            style: TextStyle(
                fontFamily: "Gilroy-light",
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
          StreamBuilder<ReceiptClass>(
          stream: blocReceipt.receipt,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.transactionDetails.length > 0) {
                   return ClipRect(
                        child: Container(
                          margin: EdgeInsets.all(10.5),
                          child: Banner(
                            color: Colors.blue,
                            message: "Details",
                            location: BannerLocation.topEnd,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 3 / 20,
                              width: double.infinity,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(15),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(
                                          0,
                                          2,
                                        ))
                                  ]),
                              child: ListView.builder(
                                itemCount: snapshot.data.transactionDetails.length,
                                itemBuilder: (context, index) {
                                  if (snapshot.data.transactionDetails.length > 0) {
                                    return Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Text("Restauran Name: ${snapshot.data.transactionDetails[index].restaurantName}"),
                                            Text("Delivery Charge: ${snapshot.data.transactionDetails[index].deliveryCharge}")
                                          ],
                                        )
                                      ],
                                    );
                                  } else {
                                    return SpinKitChasingDots(
                                      color: Colors.blue,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                );
              } else {
                return SpinKitChasingDots(
                  color: Colors.blue,
                );
              }
            } else {
              return SpinKitChasingDots(
                color: Colors.blue,
              );
            }
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 180),
            child: StreamBuilder<ReceiptClass>(
            stream: blocReceipt.receipt,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.orders.length > 0) {
                     return ClipRect(
                          child: Container(
                            margin: EdgeInsets.all(10.5),
                            child: Banner(
                              color: Colors.blue,
                              message: "Orders",
                              location: BannerLocation.topStart,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 3 / 20,
                                width: double.infinity,
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(15),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(
                                            0,
                                            2,
                                          ))
                                    ]),
                                child: ListView.builder(
                                  itemCount: snapshot.data.orders.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data.orders.length > 0) {
                                      return Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Text("Menu Name: ${snapshot.data.orders[index].menuName}"),
                                              Text("Quantity x${snapshot.data.orders[index].quantity}")
                                            ],
                                          )
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 380),
            child: StreamBuilder<ReceiptClass>(
            stream: blocReceipt.receipt,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.riderDetails.length > 0) {
                     return ClipRect(
                          child: Container(
                            margin: EdgeInsets.all(10.5),
                            child: Banner(
                              color: Colors.blue,
                              message: "Rider",
                              location: BannerLocation.bottomEnd,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 3 / 20,
                                width: double.infinity,
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(15),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(
                                            0,
                                            2,
                                          ))
                                    ]),
                                child: ListView.builder(
                                  itemCount: snapshot.data.riderDetails.length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.data.riderDetails.length > 0) {
                                      return Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Text("Rider Name: ${snapshot.data.riderDetails[index].name}"),
                                              Text("Contact Number: ${snapshot.data.riderDetails[index].contactNumber}")
                                            ],
                                          )
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          ),
        )
          ],
        )
        );
  }
}
