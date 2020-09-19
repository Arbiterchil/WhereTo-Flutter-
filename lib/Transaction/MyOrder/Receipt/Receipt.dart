import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.bloc.dart';
import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReceiptWidget extends StatefulWidget {
  @override
  _ReceiptWidgetState createState() => _ReceiptWidgetState();
}

class _ReceiptWidgetState extends State<ReceiptWidget> {
  var blocReceipt = ReceiptBloc();

  Future<void> getData() async {
    await blocReceipt.getReceiptOrders();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getData();
    });
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: StreamBuilder<ReceiptClass>(
          stream: blocReceipt.receipt,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.orders.length >0){
                return ListView.builder(
                itemCount: snapshot.data.orders.length,
                itemBuilder: (context, index) {
                  if (snapshot.data.orders.length >0) {
                     return Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: Offset(
                                  0,
                                  3,
                                ))
                          ]),
                      child: Stack(
                        children: [Text("${snapshot.data.orders[index].menuName}")],
                      ),
                    );
                  } else {
                    return SpinKitChasingDots(color: Colors.black,);
                  }
                },
              );
              }else{
                return SpinKitChasingDots(color: Colors.black,);
              }
            }else{
              return SpinKitChasingDots(color: Colors.black,);
            }
          },
        ));
  }
}
