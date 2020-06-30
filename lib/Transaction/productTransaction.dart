import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<OrderBloc, List<TransactionOrders>>(buildWhen:
          (List<TransactionOrders> previous, List<TransactionOrders> current) {
        return true;
      }, listenWhen:
          (List<TransactionOrders> previous, List<TransactionOrders> current) {
        if (current.length > previous.length) {
          return true;
        }
        return false;
      }, builder: (context, snapshot) {
        return Stack(
          children: <Widget>[
           Padding(
             padding: EdgeInsets.only(bottom: 50),
             child:  ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: snapshot.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      children: <Widget>[
                        Card(
                          color: Colors.white70,
                          elevation: 15.6,
                          child: ListTile(
                            onLongPress: () {
                              BlocProvider.of<OrderBloc>(context)
                                  .add(Computation.delete(index));
                            },
                            title: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(snapshot[index].name),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(snapshot[index].description),
                                Text(
                                  "₱" + snapshot[index].price.toString(),
                                  style: GoogleFonts.roboto(
                                      color: Colors.blue,
                                      letterSpacing: 2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                width: 100,
                                child: Row(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        if (snapshot[index].quantity > 0) {
                                          setState(() {
                                            snapshot[index].quantity =
                                                snapshot[index].quantity - 1;
                                            print(
                                                ' ${snapshot[index].name.toString()} ${snapshot[index].quantity.toString()}');
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 30,
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.blue,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 30,
                                      child: Center(
                                          child: Text(
                                        snapshot[index].quantity.toString(),
                                        style: TextStyle(fontSize: 15),
                                      )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          snapshot[index].quantity =
                                              snapshot[index].quantity + 1;
                                          print(
                                              ' ${snapshot[index].name.toString()} ${snapshot[index].quantity.toString()}');
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        width: 30,
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.blue,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
             ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: ArgonButton(
                  height: 50,
                  roundLoadingShape: false,
                  width: MediaQuery.of(context).size.width * 1.5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Total: " ,
                        style: GoogleFonts.archivo(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left : 150),
                        child: Text(
                        "Checkout" ,
                        style: GoogleFonts.archivo(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      ),
                    ],
                  ),
                  loader: Text(
                    "Loading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  color: Colors.blue,
                  onTap: (startLoading, stopLoading, btnState) {
                    // BlocProvider.of<OrderBloc>(context)
                    // .add(Computation.deleteAll());
                  },
                ),
              ),
            ),
          ],
        );
      }, listener: (BuildContext context, orderList) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Order Added")),
        );
      }),
    );
  }
}
