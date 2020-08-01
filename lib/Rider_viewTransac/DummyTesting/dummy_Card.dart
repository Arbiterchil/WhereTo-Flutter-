import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class DontenNoMichi extends StatefulWidget {

  final String boldName;
  final String subtitle;
  final String description;

  const DontenNoMichi({Key key, this.boldName, this.subtitle, this.description}) : super(key: key);
  
  @override
  _DontenNoMichiState createState() => _DontenNoMichiState();
}

class _DontenNoMichiState extends State<DontenNoMichi> {
  @override
  Widget build(BuildContext context) {
     return  Container(
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(20),
           boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 5.5,
                               blurRadius: 5.5
                             ),
                           ],
         ),
         child: Column(
           children: <Widget>[
             Row(
                                     children: <Widget>[
                                    Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white,
                           
                                        width: 2.0,
                                      ),
                                      
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage("asset/img/app.jpg"),
                                      ),
                                        ),
                                    SizedBox(width: 5.0,),
                                    Flexible(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        
                                        children: <Widget>[
                                                Text(widget.boldName,
                                                style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                fontFamily: 'OpenSans'
                                              ),
                                                ),
                                                SizedBox(height: 2,),
                                                Text(widget.subtitle,
                                                style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 10.0,
                                                fontFamily: 'OpenSans'
                                              ),
                                                ),
                                               
                                              ],
                                            ),
                                      ),
                                    ),
                                  
                                      


                                     ],
                                   ),
            SizedBox(height: 5.0,),
            
             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20.0 ),
               child: Text(widget.description,
               maxLines: 4,
                  style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.normal,
                    fontSize: 12.0,
                     fontFamily: 'OpenSans'
                      ),
                       ),
             ),
              SizedBox(height: 15.0,),
             Padding(
                padding: const EdgeInsets.only(left: 20,right: 20.0 ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child:  Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(Icons.star,size: 15,color: Colors.amber,),
                                   Icon(Icons.star,size: 15,color: Colors.amber,),
                                    Icon(Icons.star,size: 15,color: Colors.amber,),
                                     Icon(Icons.star,size: 15,color: Colors.amber,),
                                      Icon(Icons.star,size: 15,color: Colors.grey,),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),

                 ),

                 
           ],
         ),
      
       );
  }
}