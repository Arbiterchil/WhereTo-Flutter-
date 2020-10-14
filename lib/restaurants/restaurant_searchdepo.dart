import 'dart:convert';
import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/A_loadingSimpe/locationchanges.dart';
import 'package:WhereTo/A_loadingSimpe/simple_loading.dart';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/Transaction/SearchMenu/newSearch.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/google_maps/googlemap_address.dart';
import 'package:WhereTo/modules/OtherFeatures/Auth/auth_pref.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWStream_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/newRestaurant_box.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:WhereTo/restaurants/new_Carousel.dart';
import 'package:WhereTo/styletext.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FoodDisplay.dart';

class SearchDepo extends StatefulWidget {
  @override
  _SearchDepoState createState() => _SearchDepoState();
}

class _SearchDepoState extends State<SearchDepo> {
  String categ = "0";
  String imagpth;
  String lat ;
  String long;
  ScrollController scrollcont;
  
  @override
  void initState() {
    super.initState();
    imagpth = UserGetPref().getUserDataJson['imagePath'];
    streamRestaurantsFeatured..getFeaturedViewRestaurant(UserGetPref().citygetId);
  }

  

  @override
  void dispose() {
    super.dispose();
    streamRestaurantsFeatured..drainStream();
  }

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController search = new TextEditingController();
  String searchit;
  var userData;
  String address;
  String newAddress;
  String addressusi = "";
  bool isLoc = false;
  String newAnd = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                Container(
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topRight,
                      colors: [
                       Colors.black.withOpacity(.7),
                        Colors.white.withOpacity(.0),

                      ],
                      stops: [0.5,2.2],
                      ),
                    image: DecorationImage(
                      image: AssetImage("asset/img/bannertop.jpg"),
                      fit: BoxFit.cover
                      ),
                  ),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [

                    Align(
                     alignment: Alignment.bottomRight,
                     child: Padding(
                       padding: const EdgeInsets.only(right: 70,bottom: 5),
                       child: Container(
                         height: 50,
                         width: 50,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle
                         ),
                         child: RaisedButton(
                           splashColor: wheretoDark,
                           color: Colors.white,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(100)
                           ),
                           child: Center(
                             child: Icon(
                              Icons.location_city,
                               color: wheretoDark,
                               size: 24,
                             ),
                           ),
                           onPressed: () => showDialog(
                            barrierDismissible: true,
                            context: (context),
                            builder: (context) =>
                            LocationChangeforUsers(),
                             ),
            
      ),
                       ),
                       ),
                   ),      


                   Align(
                     alignment: Alignment.bottomRight,
                     child: Padding(
                       padding: const EdgeInsets.only(right: 10,bottom: 5),
                       child: Container(
                         height: 50,
                         width: 50,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle
                         ),
                         child: RaisedButton(
                           splashColor: skintone,
                           color: Colors.white,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(100)
                           ),
                           child: Center(
                             child: Icon(
                              Icons.exit_to_app,
                               color: wheretoDark,
                               size: 24,
                             ),
                           ),
                           onPressed: () =>  showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => 
          DialogForAll(
        widgets: SpinKitDoubleBounce(color: wheretoDark,size: 80,),
        labelHeader: "Do you want to exit app?",
        message: "Please double Check you unfinished orders.",
        buttTitle1: "Yes",
        buttTitle2: "No",
        yesFunc: () =>authShared.logRemoveAll(context),
        noFunc: () => Navigator.pop(context),
        showorNot1: true,
        showorNot2: true,
      ),)),
                       ),
                       ),
                   ),   

                   Align(
                     alignment: Alignment.topCenter,
                     child: Padding(
                       padding: const EdgeInsets.only(top:18.0,),
                       child: GestureDetector(
                         onTap: () => showSearch(context: context, delegate: CustomSearch()),
                         child: Container(
                              height: 40,
                              width: 260,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 9),
                                      child: Icon(
                                        EvaIcons.search,
                                        size: 25,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                   Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 9),
                                      child: Text("Search Now...",
                                      style: TextStyle(
                                        color: Colors.indigo,
                                        fontFamily: 'Brandon_Grotesque_light',
                                        fontSize: 20
                                      ),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                       ),
                     ),
                   ),
                    Positioned(
                      top: 150,
                      left: 10,
                      child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Discover New Food",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Brandon_Grotesque_light',
                              fontSize: 18,
                            ),
                            ),
                            Text("Browse now!",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Brandon_Grotesque',
                              fontSize: 28,
                            ),
                            )
                          ],
                        ),),
                  
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                viewMenuFeaturedTitle(),
                FoodDisplay(),
                SizedBox(height: 10,),
                // Stack(
                //   children: <Widget>[
                //     Padding(
                //       padding: const EdgeInsets.only(left: 15,right: 15),
                //       child: NewCarousel(),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 10,),
                viewzRestaurantFeaturedTitle(),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: StreamBuilder<NewRestaurantResponse>(
                    stream: streamRestaurantsFeatured.subject.stream,
                    builder:
                        (context, AsyncSnapshot<NewRestaurantResponse> snaphot) {
                      if (snaphot.hasData) {
                        if (snaphot.data.error != null &&
                            snaphot.data.error.length > 0) {
                          return _error(snaphot.data.error);
                        }
                        return _views(snaphot.data);
                      } else if (snaphot.hasError) {
                        return _error(snaphot.error);
                      } else {
                        return _load();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          ),
      onWillPop: () async => false),
    );

    // return Scaffold(
    //   backgroundColor: Colors.grey[50],
    //   body: WillPopScope(
    //     onWillPop: () async => false,
    //     child: SafeArea(
    //         child: SingleChildScrollView(
    //       physics: AlwaysScrollableScrollPhysics(),
    //       child: Padding(
    //         padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Container(
    //               width: MediaQuery.of(context).size.width,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   logoutIcon(),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                   cirlceLoaction(),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                   Expanded(child: textbarSearch()),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),

    //             Stack(
    //               children: <Widget>[
    //                 NewCarousel(),
    //               ],
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             viewMenuFeaturedTitle(),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             FoodDisplay(),
    //             SizedBox(
    //               height: 15,
    //             ),
    //             viewzRestaurantFeaturedTitle(),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 5.0, right: 5.0),
    //               child: StreamBuilder<NewRestaurantResponse>(
    //                 stream: streamRestaurantsFeatured.subject.stream,
    //                 builder:
    //                     (context, AsyncSnapshot<NewRestaurantResponse> snaphot) {
    //                   if (snaphot.hasData) {
    //                     if (snaphot.data.error != null &&
    //                         snaphot.data.error.length > 0) {
    //                       return _error(snaphot.data.error);
    //                     }
    //                     return _views(snaphot.data);
    //                   } else if (snaphot.hasError) {
    //                     return _error(snaphot.error);
    //                   } else {
    //                     return _load();
    //                   }
    //                 },
    //               ),
    //             ),
    //             SizedBox(
    //               height: 15,
    //             ),
    //             //   deliveryAdress(),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             Divider(
    //               height: 6.0,
    //               thickness: 1,
    //               color: wheretoDark,
    //               indent: 60.0,
    //               endIndent: 60.0,
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),

    //             SharedPrefCallnameData(),
    //             SizedBox(
    //               height: 10,
    //             ),
    //           ],
    //         ),
    //       ),
    //     )),
    //   ),
    // );

  }

  Widget viewMenuFeaturedTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            // border: Border.all(
            //   width: 1,
            //   color: wheretoDark,
            // )
            ),
        child: Text(
          "Featured Food in Restaurants",
          style: TextStyle(
              color: wheretoDark,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              fontFamily: 'Brandon_Grotesque_light'),
        ),
      ),
    );
  }

  Widget viewzRestaurantFeaturedTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            // border: Border.all(
            //   width: 1,
            //   color: wheretoDark,
            // )
            ),
        child: Text(
          "Featured Restaurants",
          style: TextStyle(
              color: wheretoDark,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              fontFamily: 'Brandon_Grotesque_light'),
        ),
      ),
    );
  }

  Widget textbarSearch() {
    return Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          // Colors.white.withOpacity(0.80),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200], spreadRadius: 3.3, blurRadius: 3.3),
          ],
          // border: Border.all(
          //   width: 1,
          //   color: wheretoDark,
          // ),
        ),
        alignment: Alignment.centerLeft,
        child: TextField(
          readOnly: true,
          showCursor: false,
          style: TextStyle(
              color: wheretoDark,
              fontWeight: FontWeight.bold,
              fontFamily: 'Gilroy-light'),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(
              top: 15.0,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: wheretoDark,
            ),
            hintText: "Search",
            hintStyle: TextStyle(
                color: wheretoDark,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gilroy-ExtraBold'),
          ),
          onTap: () {
            // Navigator.push(context, new MaterialPageRoute(builder: (context) =>SearchDelegate(s)));
            showSearch(context: context, delegate: CustomSearch());
          },
        ));
  }

  Widget logoutIcon() {
    return GestureDetector(
      onTap: () => UserDialog_Help.exit(context),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200], spreadRadius: 3.3, blurRadius: 3.3),
          ],
        ),
        child: Icon(
          Icons.exit_to_app,
          color: Color(0xFF0C375B),
          size: 30,
        ),
      ),
    );
  }

  Widget cirlceLoaction() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.grey[200], spreadRadius: 3.3, blurRadius: 3.3),
        ],
      ),
      child: IconButton(
          icon: Icon(
            Icons.location_on,
            size: 30,
          ),
          onPressed: () async {
            // showModalBottomSheet(context: context, barrierColor: Colors.white.withOpacity(0.05),backgroundColor: Colors.transparent, builder: (context){
            //   return Padding(padding: EdgeInsets.all(30),
            //           child: Container(

            //           decoration: BoxDecoration(

            //             color: Colors.white,
            //             borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(40.0),
            //               topRight: Radius.circular(40.0),
            //               bottomLeft: Radius.circular(40.0),
            //               bottomRight: Radius.circular(40.0),
            //             )
            //           ),
            //           height: 250,
            //           child:Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                Expanded(child:ListTile(
            //                   leading: Icon(Icons.location_on, size: 30, color: Colors.black),
            //                   subtitle: FutureBuilder(
            //                     future: CoordinatesConverter().convert(address),
            //                     builder: (context,snaps){
            //                       if(snaps.data == null){
            //                         return Container();
            //                       }else{
            //                         return  Text(snaps.data, style: TextStyle(
            //                     fontFamily: "Gilroy-light",
            //                     color: Colors.black,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 20,
            //                     ),);
            //                       }
            //                     },
            //                   ),

            //                ),),

            //                   ListTile(
            //                   leading: IconButton(icon: Icon(Icons.add, size: 30, color: Colors.black,),
            //                   onPressed: (){
            //                      Navigator.push(context, MaterialPageRoute(builder: (context) => MapAdress()));

            //                   }),
            //                   subtitle:  Text("New Address", style: TextStyle(
            //                     color: Colors.black,
            //                     fontFamily: "Gilroy-light",
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 20,
            //                     ),),
            //                 ),

            //               ],
            //             ),

            //           )

            //         );
            // });
          }),
    );
  }

  Widget deliveryAdress() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: GestureDetector(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                        // border: Border.all(
                        //   width: 1,
                        //   color: wheretoDark
                        // ),
                        ),
                    child: Text(
                      "Delivery Address : ",
                      style: TextStyle(
                          color: wheretoDark,
                          fontSize: 16,
                          fontFamily: "Gilroy-ExtraBold",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    address ?? "",
                    style: TextStyle(
                      color: wheretoDark,
                      fontSize: 10,
                      fontFamily: "Gilroy-light",
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  isLoc = false;
                });
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AddressLine()));
              })),
    );
  }

  Widget _load() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: SpinKitChasingDots(
              color: Colors.indigo,
              size: 40,
            )
          ),
        ],
      ),
    );
  }

  Widget _error(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Come Back Later.")],
      ),
    );
  }

  Widget _views(NewRestaurantResponse newFeatured) {
    List<NeWRestaurant> nf = newFeatured.feature;
    if (nf.length == 0) {
      return Container(
        child: Text(
          'Feature Fast Food.',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 16.0,
              fontWeight: FontWeight.normal),
        ),
      );
    } else {
      return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 280.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nf.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  FutureBuilder(
                    future: CoordinatesConverter().getAddressByLocation("${nf[index].latitude},${nf[index].longitude}"),
                    builder: (context, datasnapshot1){
                    return NewRestaurantBox(
                    image: nf[index].imagePath,
                    restaurantName: nf[index].restaurantName,
                    address:
                     nf[index].latitude.toString()+","+ nf[index].longitude.toString(),
                    // address1: nf[index].longitude,
                    onTap: () async {
                       ProgressDialog featuredRestaurant = ProgressDialog(context);
                          featuredRestaurant.style(
                            message: "Loading Restaurant Please Wait..",
                            borderRadius: 10.0,
                            backgroundColor: Colors.white,
                            progressWidget:SpinKitWanderingCubes(color:  Colors.blue),
                            elevation: 10.0,
                            insetAnimCurve: Curves.fastLinearToSlowEaseIn,
                            progressTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Gilroy-light"
                            )
                          );
                          featuredRestaurant =ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
                          await featuredRestaurant.show();

                      SharedPreferences local =
                      await SharedPreferences.getInstance();
                      var userjson = local.getString('user');
                      var user = json.decode(userjson);
                      var restaurant;
                      var status;
                      String restoLat;
                      String restoLng;
                      var insideResto = nf[index].restaurantName;
                      var insideLat = nf[index].latitude;
                      var insideLng = nf[index].longitude;
                      var isRead = false;
                      Map<String, dynamic> temp;
                      List<dynamic> converted = [];
                      final response = await ApiCall().getData('/viewUserOrders/${user['id']}');
                      final List<ViewUserOrder> transaction =
                          viewUserOrderFromJson(response.body);
                      transaction.forEach((element) {
                        restaurant = element.restaurantName;
                        status = element.status;
                        restoLat = element.restoLatitude;
                        restoLng = element.restoLongitude;
                        temp = {
                          "restaurant": restaurant,
                          "status": status,
                          "restolatitude": restoLat,
                          "restoLongitude": restoLng,
                        };
                        converted.add(temp);
                       
                      });
                      for (var i = 0; i < converted.length; i++) {
                        if (insideResto ==converted[i]['restaurant'] && converted[i]['status'] < 4) {
                          isRead = true;
                          break;
                        }
                      }
                      if (isRead) {
                        featuredRestaurant.hide();
                        UserDialog_Help.restaurantDialog(context);
                        
                      } else {
                        // if (int.parse(formatNow.split(":")[0]) >=int.parse(formatClosing.split(":")[0]) ||int.parse(formatNow.split(":")[0]) >= 0 &&int.parse(formatNow.split(":")[0]) <08) {
                        //   print(
                        //       "CLOSE current:${formatNow.split(":")[0]} restoTime:${formatClosing.split(":")[0]}");
                        //   showDial(context,
                        //       "Sorry The Restaurant is close at the Moment Please Come Back");
                        // } else {
                        //   if (int.parse(formatNow.split(":")[0]) >=
                        //       int.parse(formatOpen.split(":")[0])) {
                       
                        featuredRestaurant.hide();
                        // Navigator.push(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (context) => ListStactic(
                        //               restauID: nf[index].id.toString(),
                        //               nameRestau:
                        //                   nf[index].restaurantName.toString(),
                        //               baranggay:
                        //                   nf[index].barangayId.toString(),
                        //               lat: double.parse(nf[index].latitude),
                        //               lng: double.parse(nf[index].longitude),
                        //               categID: categ,
                        //             )));
                        Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)
                        => ListStactic(restauID: nf[index].id.toString(),
                                      nameRestau:
                                          nf[index].restaurantName.toString(),
                                      baranggay:
                                          nf[index].barangayId.toString(),
                                      lat: double.parse(nf[index].latitude),
                                      lng: double.parse(nf[index].longitude),
                                      categID: categ,
                                    )),ModalRoute.withName('/'));
                      }
                    },
                  );
                    },
                  )
                ],
              );
            },
          ),
        ),
      );
    }
  }
}
