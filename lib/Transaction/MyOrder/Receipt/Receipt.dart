
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Receipt.bloc.dart';

class Receipt extends StatelessWidget {
  final String id;
  Receipt({this.id});
  final ReceiptBloc receiptBloc = ReceiptBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            StreamBuilder(
              stream: receiptBloc.receiptView,
              builder: (context, AsyncSnapshot snapshot) {
                List<Receipt> rec =snapshot.data;
                if (snapshot == null) {
                  return SpinKitFadingCircle(
                    color: Colors.blue,
                  );
                } else {
                  return ListView.builder(
                    itemCount: rec.length?? 0,
                    itemBuilder: (context, index) {
                     
                      if (snapshot.data.length > 0) {
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
                            children: [
                              Text("")
                            ],
                          ),
                        );
                      }else{
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
