
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class NewRestaurantBox extends StatefulWidget {

  final Function onTap;
  final String restaurantName;
  final String address;
  final String image;

  const NewRestaurantBox({Key key, this.onTap, this.restaurantName, this.address, this.image}) : super(key: key);

  @override
  _NewRestaurantBoxState createState() => _NewRestaurantBoxState();
}

class _NewRestaurantBoxState extends State<NewRestaurantBox> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 195,
          width: 145,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(widget.image),
              fit: BoxFit.cover
              ),
               boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 3.3,
                               blurRadius: 3.3
                             ),
                           ],
          ),
          child: Stack(
            children: <Widget>[
               Container(
                height: 195,
          width: 145,
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20.0),
                   gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topRight,
                      colors: [
                       Colors.black.withOpacity(.5),
                        Colors.white.withOpacity(.0),

                      ],
                      stops: [0.3,2.5],
                      )
                      ,
                ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //   topRight: Radius.circular(50),
                    //   bottomLeft: Radius.circular(20),
                    //   bottomRight: Radius.circular(20),),
                    // color: pureblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            child: Text(widget.restaurantName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color:Colors.white,
                                    fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        fontFamily: 'Gilroy-ExtraBold' 
                            ),),
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        Flexible(
                          child: Container(
                            child: Text(widget.address,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color:Colors.white,
                                    fontWeight: FontWeight.normal,
                                        fontSize: 8.0,
                                        fontFamily: 'Gilroy-light' 
                            ),),
                          ),
                        ),
                      ],
                    ),
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