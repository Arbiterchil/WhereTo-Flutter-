import 'dart:convert';

import 'package:WhereTo/A_loadingSimpe/simple_loading.dart';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/static_food.dart';
import 'package:WhereTo/restaurants/blocClassMenu.dart';
import 'package:WhereTo/restaurants/blocMenuFeatured.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodDisplay extends StatefulWidget {
  @override
  _FoodDisplayState createState() => _FoodDisplayState();
}

final PageStorageBucket _bucket = new PageStorageBucket();
final PageStorageKey key = new PageStorageKey("persistent");

final blocFeatured = BlocisFeatured();
Future<void> getBloc() async {
  await blocFeatured.getIsFeatured();
}

Future<void> disposeBloc() async {
  blocFeatured.dispose();
}

class _FoodDisplayState extends State<FoodDisplay> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      getBloc();
      PageStorage.of(context)
          .writeState(context, "Load!", identifier: ValueKey(key));
    });
    return Container(
      height: 220,
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<List<IsFeatured>>(
              stream: blocFeatured.sinkAllMenu,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return ListView.builder(
                        cacheExtent: 9999,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data.length > 0) {
                            return PageStorage(
                              bucket: _bucket,
                              key: key,
                              child: StaticFoodDisplay(
                                pricetag: "P ${snapshot.data[index].totalPrice.toString()}",
                                restaurantname:
                                    snapshot.data[index].restaurantName,
                                foodname: snapshot.data[index].menuName,
                                description: snapshot.data[index].categoryName,
                                image: snapshot.data[index].imagePath,
                                onTap: () async {
                                  
                                  
                            // showDialog(
                            // barrierDismissible: true,
                            // context: context,
                            // builder: (con)=>SimpleAppLoader());

                                  ProgressDialog featured =
                                      ProgressDialog(context);
                                  featured.style(
                                      message:
                                          "Loading Restaurant Please Wait..",
                                      borderRadius: 10.0,
                                      backgroundColor: Colors.white,
                                      progressWidget: SpinKitPumpingHeart(color: Colors.red)
                                         ,
                                      elevation: 10.0,
                                      insetAnimCurve:
                                          Curves.fastLinearToSlowEaseIn,
                                      progressTextStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: "Gilroy-light"));
                                  featured = ProgressDialog(context,
                                      type: ProgressDialogType.Normal,
                                      isDismissible: false);
                                  featured.show();
                                  SharedPreferences local =
                                      await SharedPreferences.getInstance();
                                  var userjson = local.getString('user');
                                  var user = json.decode(userjson);
                                  var restaurant;
                                  var status;
                                  var restoLat;
                                  var restoLng;
                                  var insideResto =
                                      snapshot.data[index].restaurantName;
                                  var insideLat =snapshot.data[index].latitude;
                                  var insideLng =snapshot.data[index].longitude;
                                  var isRead = false;
                                  Map<String, dynamic> temp;
                                  List<dynamic> converted = [];
                                  final response = await ApiCall().getData('/viewUserOrders/${user['id']}');
                                  final List<ViewUserOrder> transaction =viewUserOrderFromJson(response.body);
                                  transaction.forEach((element) {
                                    restaurant = element.restaurantName;
                                    status = element.status;
                                    restoLat = element.restoLatitude;
                                    restoLng =element.restoLongitude;
                                    temp = {
                                      "restaurant": restaurant,
                                      "status": status,
                                      "restolatitude":restoLat ,
                                      "restoLongitude":restoLng,
                                    };
                                    converted.add(temp);
                                  });
                                  for (var i = 0; i < converted.length; i++) {
                                    if (insideResto ==converted[i]['restaurant'] &&insideLat ==converted[i]['restolatitude'] && insideLng ==converted[i]['restoLongitude'] && converted[i]['status'] < 4) {
                                      isRead = true;
                                      break;
                                    }
                                  }
                                  if (isRead) {
                                    featured.hide();
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
                                   
                                      
                                    
                                      featured.hide();
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ListStactic(
                                                    restauID: snapshot
                                                        .data[index]
                                                        .restaurantId
                                                        .toString(),
                                                    nameRestau: snapshot
                                                        .data[index]
                                                        .restaurantName
                                                        .toString(),
                                                    baranggay: snapshot
                                                        .data[index]
                                                        .barangayName,
                                                    lat: double.parse(snapshot.data[index].latitude),
                                                    lng: double.parse(snapshot.data[index].longitude),
                                                    categID: snapshot
                                                        .data[index].categoryId
                                                        .toString(),
                                                  )));
                                    
                                  }
                                },
                              ),
                            );
                          } else {
                            return SpinKitPumpingHeart(color: Colors.red,);
                          }
                        });
                  } else {
                    return SpinKitPumpingHeart(color: Colors.red,);
                  }
                } else {
                  return SpinKitPumpingHeart(color: Colors.red,);
                }
              }),
        ),
      ),
    );
  }
}
