
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class NewRestaurantBox extends StatefulWidget {

  final Function onTap;
  final String restaurantName;
  final String address;
  final double address1;
  final String image;

  const NewRestaurantBox({Key key, this.onTap, this.restaurantName, this.address, this.address1, this.image}) : super(key: key);

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
          height: 260,
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                   Container(
                    height: 160,
              width: 160,
                    decoration: BoxDecoration(
                       image: DecorationImage(
              image: NetworkImage(widget.image),
              fit: BoxFit.cover
              ),
                       borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 2.2,
                               blurRadius: 2.2
                             ),
                           ],
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
                ],
              ),
              SizedBox(height: 12,),
              Container(
                width: 140,
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Flexible(
                              child: Container(
                                child: Text(widget.restaurantName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color:wheretoDark,
                                        fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            fontFamily: 'Brandon_Grotesque' 
                                ),),
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            FutureBuilder(
                              future: CoordinatesConverter()
                              .getAddressByLocation(widget.address),
                              builder: (cons,snaps){
                                if(snaps.data ==null){
                                  return Container();
                                }else{
                                  return  Flexible(
                              child: Container(
                                child: Text(snaps.data,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color:wheretoDark,
                                        fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                            fontFamily: 'Brandon_Grotesque_light' 
                                ),),
                              ),
                            );
                                }
                            }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}