import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class XviewTransac extends StatefulWidget {
  final String image;
  final String deliveryAddress;
  final String address;
  final String restaurantName;
  final String status;
  final Function onTap;
  final Function onTapCancel;
  final Widget elapse;
  const XviewTransac(
      {Key key,
      this.image,
      this.deliveryAddress,
      this.address,
      this.restaurantName,
      this.status,
      this.onTap,
      this.onTapCancel,
      this.elapse})
      : super(key: key);

  @override
  _XviewTransacState createState() => _XviewTransacState();
}

class _XviewTransacState extends State<XviewTransac> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: pureblue,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, spreadRadius: 5.5, blurRadius: 5.5),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Container(
                      height: 95,
                      width: 95,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(widget.image),
                          )),
                    ),
                    Padding(padding: EdgeInsets.only(top: 4),
                    child: GestureDetector(
                      onTap: widget.onTapCancel,
                      child: Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: 'Gilroy-light'),
                        ),
                      ),
                    ),
                    )
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          widget.restaurantName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              letterSpacing: 1,
                              fontFamily: 'Gilroy-ExtraBold'),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Flexible(
                        child: Text(
                          widget.address,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              letterSpacing: 1,
                              fontFamily: 'Gilroy-light'),
                        ),
                      ),

                      Flexible(
                        child: Text(
                          widget.deliveryAddress,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                              letterSpacing: 1,
                              fontFamily: 'Gilroy-light'),
                        ),
                      ),

                      Text(
                        widget.status == "2"
                            ? "Under Buying Process"
                            : widget.status == "3"
                                ? "Under Delivery Process"
                                : widget.status == "4"
                                    ? "Rider Delivered the Order"
                                    : widget.status == "1"
                                        ? "Rider Accept the Order"
                                        : "Not Yet Accepted",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: widget.status == "2"
                                ? Colors.greenAccent
                                : widget.status == "3"
                                    ? Colors.orange
                                    : widget.status == "4"
                                        ? Colors.lightGreen
                                        : widget.status == "1"
                                            ? Colors.amber
                                            : Colors.orange,
                            fontWeight: FontWeight.normal,
                            fontSize: 15.0,
                            fontFamily: 'Gilroy-light'),
                      ),
                      // SizedBox(height: 8,),
                      //     widget.elapse,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // child: Stack(
        //   children: <Widget>[
        //     Align(
        //       alignment: Alignment.topRight,
        //       child: Container(
        //         height: 60,
        //         width: 100,
        //         decoration: BoxDecoration(
        //           color: Color(0xFF176DB5),
        //           borderRadius: BorderRadius.only(
        //             topRight: Radius.circular(20),
        //             bottomRight: Radius.circular(90),
        //             bottomLeft: Radius.circular(90))
        //         ),
        //         child: Center(
        //           child: Container(
        //             height: 50,
        //             width: 50,
        //             decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               image: DecorationImage(
        //                 image: AssetImage(widget.image))
        //             ),
        //           )
        //         ),
        //       ),
        //     ),
        //     Align(
        //       alignment: Alignment.topLeft,
        //       child: Container(
        //         height: 150,
        //         width: 140,
        //         decoration: BoxDecoration(
        //           color:  Color(0xFF0C375B),
        //           borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(20),
        //             bottomLeft: Radius.circular(20),
        //             topRight: Radius.circular(50),
        //           ),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.only(left: 15,top: 10,
        //           ),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               Text(widget.restaurantName,
        //               style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 14.0,
        //             letterSpacing: 1,
        //             fontFamily: 'Gilroy-ExtraBold'
        //           ),
        //               ),
        //               SizedBox(height: 8,),
        //               Text(widget.address,
        //               style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 13.0,
        //             letterSpacing: 1,
        //             fontFamily: 'Gilroy-light'
        //           ),
        //               ),
        //               SizedBox(height: 8,),
        //               Text(widget.deliveryAddress,
        //               style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 13.0,
        //             letterSpacing: 1,
        //             fontFamily: 'Gilroy-light'
        //           ),
        //               ),
        //               SizedBox(height: 8,),
        //               Text(
        //             widget.status =="2" ? "Under Buying Process" :widget.status =="3" ? "Under Delivery Process":widget.status =="4" ?"Rider Delivered the Order": widget.status =="1" ? "Rider Accept the Order": "Not Yet Accepted",
        //             overflow: TextOverflow.ellipsis,
        //             style: TextStyle(
        //                 color: widget.status =="2" ? Colors.white :widget.status =="3" ? Colors.orange: widget.status =="4" ?Colors.lightGreen:widget.status =="1" ?Colors.amber:Colors.red,
        //                 fontWeight: FontWeight.normal,
        //                 fontSize: 10.0,
        //                 fontFamily: 'Gilroy-light'),
        //           ),

        //             ],
        //           ),
        //           ),
        //       )
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
