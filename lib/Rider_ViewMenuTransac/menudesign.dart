import 'package:WhereTo/styletext.dart';
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
       width: 180.0,
       decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          
          stops: [0.2,4],
           colors: 
           [
           Color(0xFF0C375B),
           Color(0xFF176DB5)
           ],
           begin: Alignment.bottomRight,
           end: Alignment.topLeft),

       ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  // color: Color(0xFF398AE5),
                  // // Color(0xFF398AE5),
                  // // Colors.white,
                  // shape: BoxShape.rectangle,
                 
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("asset/img/logo.png"),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 6.0,
                  thickness: 2,
                  color: Colors.white,
                  indent: 10.0,
                  endIndent: 10.0,
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          Text(
                            widget.menuname,
                            style: TextStyle(
                              color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.0,
                          fontFamily: 'OpenSans')
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                            widget.description,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.0,
                          fontFamily: 'OpenSans')
                            ),
                          SizedBox(height: 10.0,),
                          Text("Price : "+
                            widget.price,
                            style: TextStyle(
                              color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.0,
                          fontFamily: 'OpenSans')
                            ),
                            SizedBox(height: 10.0,),
                          Text("Quantity : "+
                            widget.quantity,
                            style: TextStyle(
                              color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.0,
                          fontFamily: 'OpenSans')
                            ),


                        ],
                      ),
                  ),
                  
              ],
          
          ),     
    );
  }
}