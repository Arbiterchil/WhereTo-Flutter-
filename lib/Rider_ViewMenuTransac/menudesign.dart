import 'package:flutter/material.dart';

class MenuDesign extends StatefulWidget {

  final String menuname;  
  final String description;
  final String price;
  final String quantity;

  const MenuDesign({Key key, this.menuname, this.description, this.price, this.quantity}) : super(key: key);
  @override
  _MenuDesignState createState() => _MenuDesignState();
}

class _MenuDesignState extends State<MenuDesign> {



  @override
  Widget build(BuildContext context) {
    return Container(
       height: 180.0,
       width: 120.0,
       decoration: BoxDecoration(
               shape: BoxShape.rectangle,
               color: Color(0xfff7f7f7),
               borderRadius: BorderRadius.all(Radius.circular(20)),
             ),
          child: Column(
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  color: Colors.amber[300],
                  // Color(0xFF398AE5),
                  // Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.restaurant_menu,color: Colors.white,),),
                ),

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          Text(
                            widget.menuname,
                            style: TextStyle(
                              color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.0,
                          fontFamily: 'OpenSans')
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                            widget.description,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.0,
                          fontFamily: 'OpenSans')
                            ),
                          SizedBox(height: 10.0,),
                          Text("Price : "+
                            widget.price,
                            style: TextStyle(
                              color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.0,
                          fontFamily: 'OpenSans')
                            ),
                            SizedBox(height: 10.0,),
                          Text("Quantity : "+
                            widget.quantity,
                            style: TextStyle(
                              color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.0,
                          fontFamily: 'OpenSans')
                            ),


                        ],
                      ),
                  ),
                  )
              ],
          
          ),     
    );
  }
}