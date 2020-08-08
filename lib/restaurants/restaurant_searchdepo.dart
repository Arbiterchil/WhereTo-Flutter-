import 'dart:convert';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/restaurants/FoodDisplay.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_view.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/static_food.dart';
import 'package:WhereTo/restaurants/new_Carousel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchDepo extends StatefulWidget {
  @override
  _SearchDepoState createState() => _SearchDepoState();
}

class _SearchDepoState extends State<SearchDepo> {


     final scaffoldKey = new GlobalKey<ScaffoldState>(); 
      var userData;
  var constant;
  bool casting;
  String getRestaurant;
  String searchit;
  TextEditingController search = new TextEditingController();
  @override
  void initState() {
    casting = false;
    super.initState();
    getLocation();
    super.initState();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                Stack(
                  children: <Widget>[
                    NewCarousel(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, top: 100, left: 20),
                        child: Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.80),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              cursorColor: Color(0xFF0C375B),
                              controller: search,
                              style: TextStyle(
                                  color: Color(0xFF0C375B),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy-light'),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                  top: 7.0,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF0C375B),
                                ),
                                hintText: "Search",
                              ),
                              // onChanged: (input) {
                              //   setState(() {
                              //     searchit = input;
                              //   });
                              // },
                               onSubmitted: (input){
                                  setState(() {
                                    searchit = input;
                                    print(searchit);
                                    
                                  });
                              },
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,top: 10),
                        child: GestureDetector(
                          onTap: () => UserDialog_Help.exit(context),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.exit_to_app,
                                color:Color(0xFF0C375B),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        
                        ),
                    ),

                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 170),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Satisfy Your Own",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 35.0,
                                  fontFamily: 'Gilroy-ExtraBold'),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "CRAVINGS",
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                  fontFamily: 'Gilroy-ExtraBold'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
               SharedPrefCallnameData(),
                SizedBox(height: 40,),
                 Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(
                        width: 170,
                        height: 40,
                          child: Text("Popular Food in Restaurant's",
                          style: TextStyle(
                                color:Color(0xFF0C375B),
                                fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    fontFamily: 'Gilroy-light' 
                          ),),
                  
                      ),
                    ),
                    SizedBox(height: 10,),
                    FoodDisplay(),
                   SizedBox(height: 10,),               
                  Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(
                       width: 170,
                        height: 40,
                          child: Text("Popular Fast Food",
                          style: TextStyle(
                                color:Color(0xFF0C375B),
                                fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    fontFamily: 'Gilroy-light' 
                          ),),
                     
                      ),
                    ),
                    SizedBox(height: 5.0,),
                   Padding(
                     padding: const EdgeInsets.only(left: 10,right: 10),
                     child: NewRestaurantViewFeatured(),
                   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

}