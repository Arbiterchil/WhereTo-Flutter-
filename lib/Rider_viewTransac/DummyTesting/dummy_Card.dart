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
           color: pureblue,
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
             SizedBox(width: 10.0,),
             Row(
               
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: <Widget>[
                                       SizedBox(width: 20.0,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                      height: 70,
                                      width: 70,
                                      padding: EdgeInsets.all(40),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage("asset/img/logo.png"))
                                        ),
                                        
                                        // child: CircleAvatar(
                                        //   backgroundImage: AssetImage("asset/img/app.jpg"),
                                        // ),
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
                                                color: Colors.white,
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
                   color: Colors.white,
                   fontWeight: FontWeight.normal,
                    fontSize: 12.0,
                     fontFamily: 'OpenSans'
                      ),
                       ),
             ), 

              SizedBox(height: 15.0,),    
           ],
         ),
      
       );
  }
}