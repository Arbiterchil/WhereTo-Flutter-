

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
               border: Border.all(
                 width: 1,
                 color: pureblue,
               ),
               borderRadius: BorderRadius.all(Radius.circular(20)),
             ),
             child: Stack(
               children: <Widget>[
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 20),
                     child: Container(
                       height: 100,
                       width: 100,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                           image: AssetImage(widget.image) )
                       ),
                     
                     ),
                   ),
                 ),
                 Align(
                   alignment: Alignment.centerRight,
                   child: Padding(
                     padding: const EdgeInsets.only(right: 20),
                     child: Container(
                        width: 190,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                          Text(widget.name,
                                                      style: TextStyle(
                                                      color: pureblue,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18.0,
                                                      fontFamily: 'Gilroy-ExtraBold'
                                                    ),
                                                      ),
                                                      SizedBox(height: 7.0,),
                                                      Text(widget.restaurantName,
                                                      style: TextStyle(
                                                      color: pureblue,
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 11.0,
                                                      fontFamily: 'Gilroy-light'
                                                    ),
                                                      ),
                                                       SizedBox(height: 3.0,),

                                                       Text(widget.address,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                          color:pureblue,
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 11.0,
                                                          fontFamily: 'Gilroy-light'
                                                    ),
                                                          ),
                                                      
                                                      
                                                      SizedBox(height: 3.0,), 
                                                      Flexible(
                                                            child: Container(
                                                              child: Text('To: '+widget.deliveryAddress,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                              color: pureblue,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 11.0,
                                                              fontFamily: 'Gilroy-light'
                                                    ),
                                                              ),
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
    );
  }
}