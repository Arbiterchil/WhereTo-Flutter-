import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.bloc.dart';
import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.class.dart';
import 'package:WhereTo/styletext.dart';
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
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top:8,left: 30,right: 30,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<ReceiptClass>(
              stream: blocReceipt.receipt,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.transactionDetails.length > 0) {

                    return Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: snapshot.data.transactionDetails.length,
                        itemBuilder: (cons, index){         
                          if(snapshot.data.transactionDetails.length > 0){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 3.3,
                            spreadRadius: 3.3
                          )
                        ]
                      ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Restaurant Name: " ,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-light',
                                          color: wheretoDark,
                                        ),
                                      ),
                                      TextSpan(
                                        text: snapshot.data.transactionDetails[index].restaurantName,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          color: wheretoDark,
                                        ),
                                      ),
                                    ]
                                  )),
                              ),
                              ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 3.3,
                            spreadRadius: 3.3
                          )
                        ]
                      ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Delivery Charge: ",
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-light',
                                        color:wheretoDark,
                                      ),
                                    ),
                                    TextSpan(
                                      text: snapshot.data.transactionDetails[index].deliveryCharge.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-ExtraBold',
                                        color: wheretoDark,
                                      ),
                                    ),
                                  ]
                                )),
                              ),
                          ),
                        ],
                      );

                          }else{
                            return Container();
                          }
                        })
                    );
                  } else {
                     return Container();
                  }
                } else {
                     return Container();
                }
              },
            ),

                SizedBox(height: 18,),
                Stack(
                  children: [
                    StreamBuilder<ReceiptClass>(
              stream: blocReceipt.receipt,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.orders.length > 0) {

                    return Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 3.3,
                            spreadRadius: 3.3
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView.builder(
                            itemCount: snapshot.data.orders.length,
                          itemBuilder: (context,index){
                              if (snapshot.data.orders.length > 0) {
                                return Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Container(
                                            child: Text(snapshot.data.orders[index].menuName,
                                            style: TextStyle(
                                          color: wheretoDark,
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 12
                                            ),
                                            ),
                                          ),
                                          ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // border: Border.all(
                                              //   color: wheretoDark,
                                              //   width: 1,
                                              // )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("x ${snapshot.data.orders[index].quantity.toString()}",
                                              style: TextStyle(
                                          color: wheretoDark,
                                          fontFamily: 'Gilroy-ExtraBold',
                                          fontSize: 12
                                              ),
                                              ),
                                            ),
                                          ),
                                          ),
                                      ),
                                    ],
                                  ),
                                );
                              }else{
                                 return Container();
                              }
                        }),
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
                  ],
                ),
                SizedBox(height: 20,),
                StreamBuilder<ReceiptClass>(
              stream: blocReceipt.receipt,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.riderDetails.length > 0) {
                     return Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: snapshot.data.transactionDetails.length,
                        itemBuilder: (cons, index){         
                          if(snapshot.data.transactionDetails.length > 0){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 3.3,
                            spreadRadius: 3.3
                          )
                        ]
                      ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Rider Name: " ,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-light',
                                          color: wheretoDark,
                                        ),
                                      ),
                                      TextSpan(
                                        text:snapshot.data.riderDetails[index].name,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          color: wheretoDark,
                                        ),
                                      ),
                                    ]
                                  )),
                              ),
                              ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 3.3,
                            spreadRadius: 3.3
                          )
                        ]
                      ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,top: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Contact Number: ",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-light',
                                          color:wheretoDark,
                                        ),
                                      ),
                                      TextSpan(
                                        text: snapshot.data.riderDetails[index].contactNumber.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-ExtraBold',
                                          color: wheretoDark,
                                        ),
                                      ),
                                    ]
                                  )),
                              ),
                              ),
                          ),
                        ],
                      );

                          }else{
                            return SpinKitChasingDots(
                                          color: Colors.blue,);
                          }
                        })
                    );
                    
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
              ],
            ),
          ),
        ) ,
        );
  }

  Widget wigets(){
    ReceiptBloc blocReceipt = ReceiptBloc(this.transactID);
    return Padding(
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
    );
  }


}
