import 'dart:convert';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/api/api.dart';

import 'package:WhereTo/modules/OtherFeatures/trans_port.dart';
import 'package:WhereTo/restaurants/searchRestaurant.dart';
import 'package:location/location.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class Profile extends StatefulWidget with NavigationStates{
//   @override
//   _Profile createState() => _Profile();
// }

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  var userData;
  var constant;
  bool casting;
  String getRestaurant;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String searchit = "";
  @override
  void initState() {
    _getUserInfo();
    casting = false;
<<<<<<< HEAD

    // configSignal();
    getService();
    getPermission();
=======
    super.initState();
>>>>>>> 8acd245b5b77d47dbb58bd38071d1a95b38d2d30
    getLocation();
    super.initState();
    
    
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }
 getLocation() async{
    var location =Location();
    try{
      var userLocation =await location.getLocation();
      print("${userLocation.latitude},${userLocation.longitude}");
    } on Exception catch (e){
      print(e.toString());
    }
 }

 Future<void>getService() async{
   var location =Location();
   bool _serviceEnabled;
   _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService();
  if (!_serviceEnabled) {
    return;
  }
}
 }
 Future<void>getPermission() async{
   var location =Location();
   PermissionStatus permissionStatus =await location.hasPermission();
   if(permissionStatus ==PermissionStatus.denied){
     permissionStatus =await location.requestPermission();
     if(permissionStatus !=PermissionStatus.granted){
       return;
     }
   }
 }



  void configSignal() async {
    var data;
    await OneSignal.shared.setLocationShared(true);
    await OneSignal.shared.promptLocationPermission();
    await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      setState(() {
        //  constant = notification.payload.additionalData;
        data =notification.payload.additionalData;
        
      });
    });
    await OneSignal.shared.setSubscription(true);
    var tags = await OneSignal.shared.getTags();
    var sendtag = await OneSignal.shared.sendTags({'UR': 'TRUE'});
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    String url = 'https://onesignal.com/api/v1/notifications';
    var playerId = status.subscriptionStatus.userId;
    var idChil = "1106b49d-60f0-435a-b44f-5d2f4849cb38";
    var numb = "3";
    var contents = {
      "include_player_ids": [idChil,playerId],
      "include_segments": ["Users Notif"],
      "excluded_segments": [],
      "contents": {"en": "This is a test."},

      "data": {"id": numb},

      "headings": {"en": "Erchil Testings"},
      "filter": [
        {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
      ],
      "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
    };
    var repo =
        await http.post(url, headers: headers, body: json.encode(contents));

    // await OneSignal.shared.deleteTags(["userID","2","transactionID","2"]);
    print(data.toString());
    print(tags);
    print(sendtag);
    print(playerId);
    print(repo.body);
  
    
  }

  
   Future<List<SearchDeposition>> getRest() async {
   final response =await ApiCall().getRestarant('/getFeaturedRestaurant');
   List<SearchDeposition> search =searchDepoFromJson(response.body);
   return search;
 }




  @override
  Widget build(BuildContext context) {
  return Scaffold(
      key: scaffoldKey,
      backgroundColor:Color(0xFFF2F2F2) ,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    Stack(
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
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
                            
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
                                                  Text(userData!= null ? '${userData['name']}':  'Fail get data.',
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                  fontFamily: 'Gilroy-ExtraBold'
                                                ),
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Text(userData!= null ? '${userData['email']}' :  'Fail get data.',
                                                  style: TextStyle(
                                                  color: Colors.grey[300],
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
                                   Padding(
                                      padding: const EdgeInsets.only(top: 35,
                                      left: 40,
                                      // right: 50
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
        //                                   GestureDetector(
        //                                     onTap: (){
        //                                        Navigator.pushReplacement(
        // context,
        // new MaterialPageRoute(
        //     builder: (context) => UserSoloTransport()));
        //                                     },
        //                                     child: Container(
        //                                       height: 40,
        //                                       width: 40,
        //                                       decoration: BoxDecoration(
        //                                         shape: BoxShape.circle,
        //                                         color: Colors.white
        //                                       ),
        //                                       child: Center(
        //                                         child: Icon(
        //                                           Icons.list,
        //                                           color: Color(0xFF0C375B),

        //                                         ),
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   GestureDetector(
        //                                     onTap: (){
        //                                       Navigator.pushReplacement(
        // context,
        // new MaterialPageRoute(
        //     builder: (context) => UserSoloTransport()));
        //                                     },
        //                                     child: Container(
        //                                       height: 40,
        //                                       width: 40,
        //                                       decoration: BoxDecoration(
        //                                         shape: BoxShape.circle,
        //                                         color: Colors.white
        //                                       ),
        //                                       child: Center(
        //                                         child: Icon(
        //                                           Icons.directions_transit,
        //                                           color: Color(0xFF0C375B),

        //                                         ),
        //                                       ),
        //                                     ),
        //                                   ),

                                          RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    onPressed: (){
                      UserDialog_Help.exit(context);
                    },                
                    child: Text ( "LOG OUT", style :TextStyle(
                    color: Color(0xFF0C375B),
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0,
                                fontFamily: 'Gilroy-ExtraBold'
                  ),),),
                                        ],
                                      ),
                                     ), 
                                 ],
                               ),
                             ),
                       ),
                      ],
                    ),
                   SizedBox(height: 40,),
                  //  GridView(
                  //    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  //    crossAxisCount: Orientation.portrait == Orientation.portrait ? 2 : 3),
                  //    children: <Widget>[
                      
                  //    ],
                     
                  //    ),

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
            Icon(icon,color: Colors.white,size: 15.0,),
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
                        color: Colors.white,
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
