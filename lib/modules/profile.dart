import 'dart:convert';
import 'package:WhereTo/AnCustom/alert_dialog.dart';
import 'package:WhereTo/AnCustom/dialogHelp.dart';
import 'package:WhereTo/AnCustom/restaurant_front.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:WhereTo/modules/OtherFeatures/trans_port.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_view.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/static_viewRest.dart';
import 'package:WhereTo/restaurants/carousel_rest.dart';
import 'package:WhereTo/restaurants/featured_rest.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import 'package:WhereTo/restaurants/searchRestaurant.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../bloc.Navigation_bloc/navigation_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styletext.dart';

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
    // configSignal();
    getService();
    getPermission();
    getLocation();
    super.initState();
    
    
  }


  void _showodalShit(){

    showModalBottomSheet(
      context : context,
      backgroundColor: Colors.transparent,
      builder:(builder){

      return new Padding(
          padding: EdgeInsets.only(left: 20.0,right: 20.0 ,top: 20.0),
          child: Container(
            height: 700.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2F2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              ),
            ),
            child: FutureBuilder(
              future: getRest(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.data == null){
                  return Container(
                    child: Center(
                      child: Text("Restaurants Searching..",
                      style: TextStyle(
                        color: Colors.black,
                                  fontFamily: 'Gilroy-light',
                                  fontStyle: FontStyle.normal
                      ),
                      ),
                    ),
                  );
                }else{

                    return new ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context , int index){
                          return snapshot.data[index].restaurantName.contains(searchit)
                          |snapshot.data[index].address.contains(searchit) ? GestureDetector(
                            onTap: (){
   
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: RestaurantFront(
                                image: "asset/img/${snapshot.data[index].restaurantName}.png",
                                restaurantName:snapshot.data[index].restaurantName ,
                                restaurantAddress: snapshot.data[index].address,
                                openAndclose: snapshot.data[index].openTime+"-"+snapshot.data[index].closingTime,
                                onTap: (){
                                  Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) 
                                  => ListStactic(
                                      restauID: snapshot.data[index].id.toString(),
                                     nameRestau: snapshot.data[index].restaurantName.toString(),
                                    )
                                  )
                                  ); 
                                },
                              ),
                            ),
                          ): Container(
                            // child: Center(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(20.0),
                            //     child: Container(
                            //         height: 300,
                            //         width: MediaQuery.of(context).size.width,
                            //         decoration: BoxDecoration(
                            //           image: DecorationImage(
                            //             image: AssetImage("asset/img/nosearch.png"))
                            //         ),
                            //     ),
                            //   ),
                            // ),
                          );
                        },
                      );

                }



              },
            ),
          ),
      );

    });

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
                children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      overflow: Overflow.visible,
                      children: <Widget>[                      
                        Container(
                          height: 330.0,
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
                                      padding: const EdgeInsets.only(top: 15,
                                      left: 70,
                                      // right: 50
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: (){
                                               Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (context) => UserSoloTransport()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.list,
                                                  color: Color(0xFF0C375B),

                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (context) => UserSoloTransport()));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.directions_transit,
                                                  color: Color(0xFF0C375B),

                                                ),
                                              ),
                                            ),
                                          ),

                                          RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    onPressed: (){},                
                    child: Text ( "EDIT PROFILE", style :TextStyle(
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
                        Padding(
                          padding: const EdgeInsets.only(top:210),
                          child: Divider(
                  height: 1.0,
                  thickness: 1,
                  
                  color: Colors.white,
                  indent: 90.0,
                  endIndent: 90.0,
                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 220,left: 25.0,right: 25.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.ltr,
                              children: <Widget>[
                               Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                    Text("What Do You",
                                style :TextStyle(
                                color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22.0,
                                  fontFamily: 'Gilroy-light'
                        ),),
                        SizedBox(width: 5.0,),
                         Text("Crave?",
                                style :TextStyle(
                                color: Colors.blue,
                                // Color(0xFF176DB5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  fontFamily: 'Gilroy-ExtraBold'
                        ),),
                                 ],
                               ),
                        SizedBox(height: 20.0,),
                               Container(
                                 width: MediaQuery.of(context).size.width,
                                 height: 40.0,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(50),
                                   color: Colors.white
                                 ),
                                 child: TextField(
                                   cursorColor: Color(0xFF0C375B),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Gilroy-light',
                                  fontStyle: FontStyle.normal
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(top:7.0,),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color:  Color(0xFF0C375B),
                                  ),
                                  hintText: "Search",
                              ),
                              textInputAction: TextInputAction.go,
                              onSubmitted: (input){
                                  setState(() {
                                    searchit = input;
                                    print(searchit);
                                    _showodalShit();
                                  });
                              },
                              // onTap: _showodalShit,
                            ),
                               )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                   Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text("Popular Fast Food",
                        style: TextStyle(
                              color:Color(0xFF0C375B),
                              fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  fontFamily: 'Gilroy-light' 
                        ),),
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Divider(
                  height: 1.0,
                  thickness: 1,
                  color: Color(0xFF0C375B),
                  indent: 20.0,
                  endIndent: 60.0,
                ),
                   SizedBox(height: 8.0,),
                   Padding(
                     padding: const EdgeInsets.only(left: 10,right: 10),
                     child: NewRestaurantViewFeatured(),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 10,right: 10),
                     child: Container(
                       width: MediaQuery.of(context).size.width,
                       child: Stack(
                         children: <Widget>[
                           Align(
                             alignment: Alignment.centerRight,
                             child:  RaisedButton(
                    color: Color(0xFF0C375B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    onPressed: (){},                
                    child: Text ( "Show More...", style :TextStyle(
                    color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0,
                                fontFamily: 'OpenSans'
                  ),),),
                           ),
                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: 10.0,),
                    Divider(
                  height: 1.0,
                  thickness: 1,
                  color: Color(0xFF0C375B),
                  indent: 90.0,
                  endIndent: 90.0,
                ), 
                SizedBox(height: 5.0,),
                   CarouselSex(),
                  SizedBox(height: 10.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text("Most Popular Restaurants",
                        style: TextStyle(
                              color:Color(0xFF0C375B),
                              fontWeight: FontWeight.w800,
                                  fontSize: 12.0,
                                  fontFamily: 'Gilroy-light' 
                        ),),
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Divider(
                  height: 3.0,
                  thickness: 2,
                  color: Color(0xFF0C375B),
                  indent: 20.0,
                  endIndent: 60.0,
                ),
                   SizedBox(height: 8.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          children: <Widget>[
                            StaticviewsRestaurant(
                              image: "asset/img/app.jpg",
                              restauratname: "Chowking",
                              address: "National Highway",
                              openOn: "Weekly",
                            ),
                             StaticviewsRestaurant(
                              image: "asset/img/fbmYkDz.jpg",
                              restauratname: "Jollibee",
                              address: "National Highway",
                              openOn: "Weekly",
                            ),
                             StaticviewsRestaurant(
                              image: "asset/img/mWWsAhL.jpg",
                              restauratname: "Mc Donald's",
                              address: "Rizal Street",
                              openOn: "Weekly",
                            ),
                             StaticviewsRestaurant(
                              image: "asset/img/76134055_p0.png",
                              restauratname: "Penongs",
                              address: "Rizal Street",
                              openOn: "Weekly",
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0,),
                      Padding(
                     padding: const EdgeInsets.only(left: 10,right: 10),
                     child: Container(
                       width: MediaQuery.of(context).size.width,
                       child: Stack(
                         children: <Widget>[
                           Align(
                             alignment: Alignment.centerRight,
                             child:  RaisedButton(
                    color: Color(0xFF0C375B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    onPressed: (){},                
                    child: Text ( "Show More...", style :TextStyle(
                    color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0,
                                fontFamily: 'OpenSans'
                  ),),),
                           ),
                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: 15.0,),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20,right: 20),
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     child: Text("Other",
                    //     style: TextStyle(
                    //           color:Color(0xFF0C375B),
                    //           fontWeight: FontWeight.w800,
                    //               fontSize: 12.0,
                    //               fontFamily: 'Gilroy-light' 
                    //     ),),
                    //   ),
                    // ),
                    // SizedBox(height: 5.0,),


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
