

import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class Customgettransac extends StatefulWidget {
  final Function onTap;
  final String   name;
  final String   address;
  final String   image;
  final String   transacId;
  final String   restaurantName;
  final String   deliveryAddress;

  const Customgettransac({Key key, this.onTap, this.name, this.address, this.image, this.transacId, this.restaurantName, this.deliveryAddress}) : super(key: key);
  @override
  _CustomgettransacState createState() => _CustomgettransacState();
}

class _CustomgettransacState extends State<Customgettransac> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child:  Container(
             height: 150,
             width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
               color: pureblue,
               borderRadius: BorderRadius.all(Radius.circular(20)),
             ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Container(
                   height: 100,
                   width: 100,
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     image: DecorationImage(
                       image: AssetImage(widget.image) )
                   ),
                 
                 ),
                 Container(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     textDirection: TextDirection.ltr,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                      Text(widget.name,
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                  fontFamily: 'Gilroy-ExtraBold'
                                                ),
                                                  ),
                                                  SizedBox(height: 7.0,),
                                                  Text(widget.restaurantName,
                                                  style: TextStyle(
                                                  color: Color(0xFFF2F2F2),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 11.0,
                                                  fontFamily: 'Gilroy-light'
                                                ),
                                                  ),
                                                   SizedBox(height: 3.0,),
                                                  SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                   
                                                      child: Text(widget.address,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                      color: Color(0xFFF2F2F2),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 11.0,
                                                      fontFamily: 'Gilroy-light'
                                                ),
                                                      ),
                                                  
                                                  ),
                                                  SizedBox(height: 3.0,),
                                                   SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                 
                                                      child: Text('To: '+widget.deliveryAddress,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                      color: Color(0xFFF2F2F2),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 11.0,
                                                      fontFamily: 'Gilroy-light'
                                                ),
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