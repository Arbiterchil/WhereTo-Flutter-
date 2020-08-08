import 'dart:convert';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWStream_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_view.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/newRestaurant_box.dart';
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
     _getUserInfo();
    casting = false;
    super.initState();
    getLocation();
    streamRestaurantsFeatured..getFeaturedViewRestaurant();
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
                        padding: const EdgeInsets.only(right: 20, top: 180),
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
                Padding(padding: const EdgeInsets.only(left: 20,right: 20),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              StaticFoodDisplay(
                                restaurantname: "KFC",
                                foodname: "Potato Frys",
                                description: "Fries and Potato with Dip Ketchup",
                                image: "asset/img/fryandpota.jpg",
                                onTap: (){},
                              ),
                              StaticFoodDisplay(
                                restaurantname: "KFC",
                                foodname: "Vegetarian Food",
                                description: "Vegetarian food in Russia Cussine",
                                image: "asset/img/gulays.jpg",
                                onTap: (){},
                              ),
                              StaticFoodDisplay(
                                restaurantname: "Chowking",
                                foodname: "Noodles Chinese Food",
                                description: "Covid 19 Installed",
                                image: "asset/img/noodles.jpg",
                                onTap: (){},
                              ),
                              StaticFoodDisplay(
                                restaurantname: "Jollibee",
                                foodname: "Burger Extra Chili Hot",
                                description: "Burgers Burgers!",
                                image: "asset/img/burgers.jpg",
                                onTap: (){},
                              ),
                              StaticFoodDisplay(
                                restaurantname: "McDonalds",
                                foodname: "Burger Standard Falbor",
                                description: "Burgers Burgers!",
                                image: "asset/img/fryandpota.jpg",
                                onTap: (){},
                              ),

                            ],
                          ),
                        ),
                      ),
                      ),
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
                     child: StreamBuilder<NewRestaurantResponse>(
                      stream: streamRestaurantsFeatured.subject.stream,
                      builder: (context , AsyncSnapshot<NewRestaurantResponse> snaphot){
                        if(snaphot.hasData){
                            if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                                return _error(snaphot.data.error);
                            }
                              return _views(snaphot.data);
                        }else if(snaphot.hasError){
                              return _error(snaphot.error);
                        }else{
                              return _load();
                        }
                      },
                    ),
                   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   Widget _load(){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 4.0,
                  ),
                ),
          ],


        ),
      );
    }
 Widget _error(String error){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Error :  $error")
              ],
            ),
          );
}
Widget _views(NewRestaurantResponse newFeatured){
        List<NeWRestaurant> nf = newFeatured.feature;
        if(nf.length == 0 ){
          return Container(
            child: Text('Feature Fast Food.',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize:  16.0,
              fontWeight: FontWeight.normal
            ),),
          );
        }else{
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 210.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nf.length,
                itemBuilder: (context,index){
                   return Column(
                     children: <Widget>[
                       NewRestaurantBox(
                         image: "asset/img/${nf[index].restaurantName}.jpg",
                         restaurantName:nf[index].restaurantName ,
                         address: nf[index].address,
                         onTap: (){},
                       ),
                     ],
                   );
                },
                ),
            ),
          );
        }
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