import 'package:flutter/material.dart';



class RestaurantFront extends StatefulWidget {

  final Function onTap;
  final String image;
  final String restaurantName;
  final String restaurantAddress;
  final String openAndclose;
  final String closeOn;

  const RestaurantFront({Key key, this.onTap, this.image, this.restaurantName, this.restaurantAddress, this.openAndclose, this.closeOn}) : super(key: key); 

  @override
  _RestaurantFrontState createState() => _RestaurantFrontState();
}

class _RestaurantFrontState extends State<RestaurantFront> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(left:30.0,right: 30.0,top: 20.0,),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xFF398AE5),
            // Color(0xfff7f7f7),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 130,
                decoration: BoxDecoration(
                  // color: Colors.white,
                    shape: BoxShape.rectangle,

                    image: DecorationImage(image: 
                    AssetImage(widget.image),
                    fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
              ),
              Container(
                height: 70.0,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(widget.restaurantName,
                        style: TextStyle(
                          color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              fontFamily: 'OpenSans'
                        ),),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(widget.restaurantAddress,
                        style: TextStyle(
                          color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                        ),),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(widget.openAndclose,
                        style: TextStyle(
                          color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}