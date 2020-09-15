import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class ViewTransacRider extends StatefulWidget {

  final Function onTap;
  final String   name;
  final String   address;
  final String   image;
  final String   transacId;
  final String   restaurantName;
  final String   deliveryAddress;

  const ViewTransacRider({Key key,this.onTap, this.name, this.address,this.image, this.transacId, this.restaurantName,this.deliveryAddress}) : super(key: key);
  
  @override
  _ViewTransacRiderState createState() => _ViewTransacRiderState();
}

class _ViewTransacRiderState extends State<ViewTransacRider> {

 String data1 ="";
 String data2 = "";
  @override
  void initState() {

    super.initState();
    CoordinatesConverter().convert(widget.deliveryAddress).then((value) => setState(()=> data1 =value));
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
               height: 135,
               width: MediaQuery.of(context).size.width,
               decoration: transacBox,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                  Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage( image:
                       AssetImage(widget.image),
                      fit: BoxFit.cover,
                      ),
                 
                      )
                    ),
                SizedBox(width: 10.0,),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                    fontFamily: 'Gilroy-ExtraBold',
                      ),
                      ),
                      Divider(
                    height: 6.0,
                    thickness: 3,
                    color: Colors.white,
                    indent: 15.0,
                    endIndent: 15.0,
                      ),
                      SizedBox(height: 10.0,),
                      Text(widget.restaurantName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                    fontFamily: 'Gilroy-light',),),
                    SizedBox(height: 7.0,),
                     Text(widget.address,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                    fontFamily: 'Gilroy-light',),),
                    SizedBox(height: 7.0,),
                    Flexible(
                      child: Container(
                        child: Text(data1,
                        overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.normal,
                        fontFamily: 'Gilroy-light',),),
                      ),
                    ),

                    ],
                  ),
                ),
              ],
            ),
          ),     
        ),
      ),
    );
  }
}