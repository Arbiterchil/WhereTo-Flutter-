import 'package:flutter/material.dart';

class StaticviewsRestaurant extends StatefulWidget {

  final String image;
  final String restauratname;
  final String address;
  final String openOn;

  const StaticviewsRestaurant({Key key, this.image, this.restauratname, this.address, this.openOn}) : super(key: key);

  @override
  _StaticviewsRestaurantState createState() => _StaticviewsRestaurantState();
}

class _StaticviewsRestaurantState extends State<StaticviewsRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90.0,
              decoration: BoxDecoration(
                  color:  Color(0xFF0C375B),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90),
                    bottomRight: Radius.circular(30)),
                    
              ),
            ),
          ),
            Positioned(
            top: 9,
            child: Container(
              height: 100,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(80)),
                image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover)
              ),
            ),
          ),  
          Positioned(
            left: 125,
            top: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text ( widget.restauratname,
               style :TextStyle(
                    color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                fontFamily: 'Gilroy-ExtraBold'
                  ),),
                  SizedBox(height: 5.0,),
                  Text ( widget.address,
               style :TextStyle(
                    color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 9.0,
                                fontFamily: 'Gilroy-light'
                  ),),
                  SizedBox(height: 4.0,),
                  Text ( widget.openOn,
               style :TextStyle(
                    color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 6.0,
                                fontFamily: 'OpenSans'
                  ),),
              ],
            ),
            ),

        ],
      ),
    );
  }
}