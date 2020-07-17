
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../bloc.Navigation_bloc/navigation_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget with NavigationStates{
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  var userData;
  var constant;
  @override
  void initState() {
    _getUserInfo();
    configSignal();
    super.initState();
    getUserLocation();
  }
 



  void _getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user'); 
      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  }


    getUserLocation() async {
      var currentLocation;
      LocationData myLocation;
      String error;
      Location location = new Location();
      try {
        myLocation = await location.getLocation();
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          error = 'please grant permission';
          print(error);
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          error = 'permission denied- please enable it from app settings';
          print(error);
        }
        myLocation = null;
      }
      currentLocation = myLocation;
      final coordinates = new Coordinates(
          myLocation.latitude, myLocation.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      var first = addresses.first;
      print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
      print(currentLocation.toString());
      return first;
  
  }

 
void configSignal() async {

       
void configSignal() async {

      await OneSignal.shared.setLocationShared(true);
      await OneSignal.shared.promptLocationPermission();

      

      await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');

      OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
     
      

      OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {

          setState(() {
            //  constant = notification.payload.additionalData;
          });

          
          
       });
          

        await OneSignal.shared.setSubscription(true);

          var tags = await OneSignal.shared.getTags();
          print(tags);

       var status = await OneSignal.shared.getPermissionSubscriptionState();
    String url = 'https://onesignal.com/api/v1/notifications';
    var playerId = status.subscriptionStatus.userId;


//      await OneSignal.shared.postNotification(OSCreateNotification(
//   playerIds: [playerId],
//   content: "this is a test from OneSignal's Flutter SDK",
//   heading: "Test Notification",
//   buttons: [
//     OSActionButton(text: "test1", id: "id1"),
//     OSActionButton(text: "test2", id: "id2")
//   ]
// ));
// "include_player_ids" : [playerId],
//       // "include_segments" : ["Penongs","Subscribed Users"],
//       // "excluded_segments":[],
//       "contents":{"en":"hehhehehehehhe"},
//       "headings":{"en":"Jayce Mico Trial"},
//       // "data":{"test":userData["name"]},
//       "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"

 await OneSignal.shared.sendTags({"Test": "Value"});
    var contents = {
      "include_player_ids" : [playerId],
      "include_segments" : ["Penongs Users"],
      "excluded_segments":[],
      "contents":{"en":"hehhehehehehhe"},
      "headings":{"en":"Jayce Mico Trial"},
      // "data":{"test":userData["name"]},
      "filter":
      [
        {
          "field": "tag","key":"Test","relation":"=","value":"Value"
        },
        {
          "field": "location","radius":"50","lat":"7.4281606","long":"125.8067263"
        }
        ],
      "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"

      };
  Map<String,String> headers = {'Content-Type':'application/json',
  'authorization':'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'};
    var repo = await http.post(
    url,
    headers: headers,
    body: json.encode(contents)
    );
      print(repo.body);


  }


    


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            child: Stack(
                children: <Widget>[ 
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: <Widget>[
                            // Container(
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(
                            //       colors: [
                            //         Colors.white,
                            //          Colors.white,
                            //       ],                        
                            //     ),
                            //   ),
                            // ),
                              Padding(
                          padding: EdgeInsets.only(top: 80.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                  width: 200.0,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xFF262AAA),
                                      width: 2.0,
                                      ),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                   backgroundImage: AssetImage('asset/img/app.jpg'),

                                  ),
                                ),
                                ],
                              ),
                              SizedBox(height: 10.0,),
                               Text(userData!= null ? '${userData['name']}' : '',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                          color: Colors.black
                        ),),
                         Text("Welcome, Have a Nice Day!",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black54
                        ),),
                            ],
                          ),
                        ),
                              SizedBox(height: 40.0,),
                               Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context){
                        //   return  Point_Reward();
                        // }));
                      },
                      child: Text("Points | Rewards",style:
                       TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 22.0,),
                    ),
                              ),
                  ],
                ),
              ),
               SizedBox(height: 20.0,),
                             Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(left: 30.0, right: 30.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 40, bottom: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Card(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 15, top: 10, bottom: 10),
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.location_city,
                                                color: Color(0xFF262AAA),
                                              ),
                                            ),
                                            Text(
                                            'Address',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 35),
                                          child: Text(
                                           userData!= null ? '${userData['address']}' : '',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontSize: 15.0,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),                   
                                Card(
                                  elevation: 4.0,
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(left: 15, top: 10, bottom: 10),
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.phone,
                                                color: Color(0xFF262AAA),
                                              ),
                                            ),
                                            Text(
                                              'Contact Number',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:  Colors.black,
                                                fontSize: 17.0,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 35),
                                          child: Text(
                                            userData!= null ? '${userData['contactNumber']}' : '',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontSize: 15.0,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                         SizedBox(height: 10.0,),
                        // Text("The Message Is "+constant.toString()),
                        ],
                        ),
                      ),
                    ),
                ],
            ),
            
      ),
    );
  }

}