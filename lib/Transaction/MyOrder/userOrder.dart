import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  final Function onTap;
  final String restaurantName;
  final String address;
  final String deliveryAddress;
  final String image;
  final String status;
  OrderCard({this.onTap, this.restaurantName, this.address, this.deliveryAddress, this.image, this.status});
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 180,
        width: MediaQuery.of(context).size.width -30,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 110.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90),
                  gradient: LinearGradient(
                      stops: [0.1, 1],
                      colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft),
                ),
              ),
            ),
            Positioned(
              top: 5.0,
              left: 20.0,
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.1, 1],
                      colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(13.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(widget.image),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.70, -1.120),
              child: Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("asset/img/logo.png")),
                ),
              ),
            ),
            Positioned(
              left: 113,
              top: 45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.restaurantName,
                    style: TextStyle(
                        color: Color(0xFFF2F2F2),
                        fontWeight: FontWeight.normal,
                        fontSize: 11.0,
                        fontFamily: 'OpenSans'),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.address,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xFFF2F2F2),
                          fontWeight: FontWeight.normal,
                          fontSize: 11.0,
                          fontFamily: 'OpenSans'),
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.status =="2" ? "Under Buying Process" :widget.status =="3" ? "Under Delivery Process":widget.status =="4" ?"Delivered": widget.status =="1" ? "Rider Accept the Order": "Not Accepted the Order Yet Please wait..",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        
                          color: widget.status =="2" ? Colors.brown :widget.status =="3" ? Colors.orange: widget.status =="4" ?Colors.lightGreen:widget.status =="1" ?Colors.amber:Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: 13.0,
                          fontFamily: 'OpenSans'),
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      'To: ' + widget.deliveryAddress,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xFFF2F2F2),
                          fontWeight: FontWeight.normal,
                          fontSize: 11.0,
                          fontFamily: 'OpenSans'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
