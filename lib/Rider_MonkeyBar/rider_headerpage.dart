import 'package:flutter/material.dart';

class GlobalHeader extends StatefulWidget {

  final String restaurantName;
  final String addressto;
  final String fee;
  final String total;
  final String name;

  const GlobalHeader({Key key, this.restaurantName, this.addressto, this.fee, this.total, this.name}) : super(key: key);

  @override
  _GlobalHeaderState createState() => _GlobalHeaderState();
}

class _GlobalHeaderState extends State<GlobalHeader> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
                      alignment: AlignmentDirectional.topCenter,
                      overflow: Overflow.visible,
                      children: <Widget>[                      
                        Container(
                          height: 230.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                              
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),

                        ),
                       Padding(
                         padding: const EdgeInsets.only(top: 5,left: 30,right: 30),
                         child: Container(
                               height: 220.0,
                               child: Column(
                                 children: <Widget>[
                                   Padding(
                                     padding: const EdgeInsets.only(top: 35.0),
                                     child: Row(
                                       children: <Widget>[
                                      Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white,
                                          //  Color(0xFF398AE5),
                                          width: 2.0,
                                        ),
                                        
                                        ),
                                        padding: EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage("asset/img/app.jpg"),
                                        ),
                                          ),
                                      SizedBox(width: 20.0,),
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          
                                          children: <Widget>[
                                                  Text(widget.name,
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  fontFamily: 'OpenSans'
                                                ),
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Text(widget.restaurantName,
                                                  style: TextStyle(
                                                  color: Colors.grey[300],
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12.0,
                                                  fontFamily: 'OpenSans'
                                                ),
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Text(widget.addressto,
                                                  style: TextStyle(
                                                  color: Colors.grey[300],
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12.0,
                                                  fontFamily: 'OpenSans'
                                                ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(widget.fee,
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  fontFamily: 'OpenSans'
                                                ),
                                                  ),
                                                ],
                                              ),
                                        ),
                                      ),
                                    
                                        


                                       ],
                                     ),
                                   ), 
                                   Padding(
                                      padding: const EdgeInsets.only(top: 15,left: 50,right: 50),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(width: 30.0,),
                                          RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    onPressed: (){
                     
                    },                
                    child: Text ( "BACK", style :TextStyle(
                    color: Color(0xFF0C375B),
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0,
                                fontFamily: 'OpenSans'
                  ),),),
                                        ],
                                      ),
                                     ), 
                                 ],
                               ),
                             ),
                       ),
                        Padding(padding: const EdgeInsets.only(top:210,left: 40,right: 40),
                        child: Container(
                         height: 70.0,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(10.0),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 5.5,
                               blurRadius: 5.5
                             ),
                           ],
                         ),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child:  Text("Total: "+widget.total,
                                              style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 25.0,
                                              fontFamily: 'OpenSans'
                                            ),
                                              ),),
                            ],
                          ),
                        ),
                        )
                      ],
                    );
  }
}