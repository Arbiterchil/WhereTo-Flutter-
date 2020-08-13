import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefCallnameData extends StatefulWidget {
  @override
  _SharedPrefCallnameDataState createState() => _SharedPrefCallnameDataState();
}

class _SharedPrefCallnameDataState extends State<SharedPrefCallnameData> {
  var userData;
  var constant;
  bool casting;
  String getRestaurant;
  String searchit;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getUserInfo();
  }


  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Padding(padding: const EdgeInsets.only(left: 20,right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: <Widget>[
                         Container(
                           height: 110,
                           width: 110,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             image: DecorationImage(
                               image: AssetImage("asset/img/62512004_p0.png"),
                               fit: BoxFit.cover),
                           ),
                         ),
                         SizedBox(width: 10,),
                        Flexible(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                
                           Text(userData!= null ? '${userData['name']}':  'Fail get data.',
                                                    style: TextStyle(
                                                    color: Color(0xFF0C375B),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                    fontFamily: 'Gilroy-ExtraBold'
                                                  ),
                                                    ),
                                                    SizedBox(height: 2,),
                                                    Text(userData!= null ? '${userData['email']}' :  'Fail get data.',
                                                    style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 10.0,
                                                    fontFamily: 'Gilroy-light'
                                                  ),
                                                    ),
                                                     NCard(
                                                        active: false,
                                   icon: Icons.phone_android,
                                   label: userData!= null ? '${userData['contactNumber']}' :  'Fail get data.',
                                                      ),
                                                      NCard(
                                                        active: false,
                                   icon: Icons.my_location,
                                   label: userData!= null ? '${userData['address']}' :  'Fail get data.',
                                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                  ),
                ),
                ),
    );
  }
}


class NCard extends StatelessWidget {

  final bool active;
  final IconData icon;
  final String label;
  final Function onTap;
  const NCard({this.active,this.icon,this.onTap,this.label});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: onTap,
      child: Container(
        height: 30.0,
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        // decoration: eBox,
        child: Row(
          children: <Widget>[
            Icon(icon,color: Color(0xFF0C375B),size: 15.0,),
            SizedBox(width: 7.0,),
        
             Flexible(
               flex: 1,
               child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      child: Text(label,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Color(0xFF0C375B),
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        fontFamily: 'Gilroy-light'
                      ),),
                    ),
                  ),
             ),
           
            
          ],
        ),
      ),
    );
  }
}