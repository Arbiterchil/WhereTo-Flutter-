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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
             height: 115,
             width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
               shape: BoxShape.rectangle,
               color: Color(0xfff7f7f7),
               borderRadius: BorderRadius.all(Radius.circular(20)),
             ),
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
                    Text("ID: "+widget.transacId+" - "+widget.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                  fontFamily: 'OpenSans',
                    ),),
                    SizedBox(height: 10.0,),
                    Text("Restaurant: "+widget.restaurantName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSans',),),
                  SizedBox(height: 7.0,),
                   Text("Address: "+widget.address,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSans',),),
                  SizedBox(height: 7.0,),
                  Text("To: "+widget.deliveryAddress,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSans',),),

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