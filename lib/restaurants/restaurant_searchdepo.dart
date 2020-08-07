import 'dart:convert';
import 'package:WhereTo/AnCustom/restaurant_front.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/dialog.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:WhereTo/restaurants/searchRestaurant.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SearchDepo extends StatefulWidget {
  @override
  _SearchDepoState createState() => _SearchDepoState();
}

Future<List<SearchDeposition>> getRest() async {
  final response = await ApiCall().getRestarant('/getFeaturedRestaurant');
  List<SearchDeposition> search = searchDepoFromJson(response.body);
  return search;
}

class _SearchDepoState extends State<SearchDepo> {
  TextEditingController search = new TextEditingController();
  String searchit = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 190.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            stops: [0.2, 4],
                            colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Satify Your Own",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0,
                                  fontFamily: 'Gilroy-light'),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "CRAVES",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23.0,
                                  fontFamily: 'Gilroy-ExtraBold'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, top: 110, left: 20),
                        child: Container(
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
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
                              onChanged: (input) {
                                setState(() {
                                  searchit = input;
                                });
                              },
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 520.0,
                  width: MediaQuery.of(context).size.width,
                  child: listData(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listData() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
          ),
        ),
        child: FutureBuilder(
          future: getRest(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Restaurants Loading"),
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return snapshot.data[index].restaurantName
                              .contains(searchit) |
                          snapshot.data[index].address.contains(searchit)
                      ? GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 20, right: 20),
                            child: RestaurantFront(
                              image:
                                  "asset/img/${snapshot.data[index].restaurantName}.png",
                              restaurantName:
                                  snapshot.data[index].restaurantName,
                              restaurantAddress: snapshot.data[index].address,
                              openAndclose: snapshot.data[index].openTime +
                                  "-" +
                                  snapshot.data[index].closingTime,
                              onTap: () async {
                                  final now = await NTP.now();
                                  final formatNow =DateFormat.Hm().format(now);
                                 
                                  DateFormat inputFormat = DateFormat("H:mm");
                                  DateTime dateCloseTime = inputFormat.parse(snapshot.data[index].closingTime);
                                  DateTime dateOpen = inputFormat.parse(snapshot.data[index].openTime);
                                  String formatClosing =DateFormat.Hm().format(dateCloseTime);
                                  String formatOpen =DateFormat.Hm().format(dateOpen);
                                  // int cpTime =int.parse(formatNow.substring(0, 2));
                                  // int restoTime =int.parse(formatClosing.substring(0, 1));
                                  // int restoOpen =int.parse(formatOpen.substring(0,1));
                                SharedPreferences local =
                                    await SharedPreferences.getInstance();
                                var userjson = local.getString('user');
                                var user = json.decode(userjson);
                                var restaurant;
                                var status;
                                var insideResto =
                                    snapshot.data[index].restaurantName;
                                var isTrue = false;
                                Map<String, dynamic> temp;
                                List<dynamic> converted = [];
                                final response = await ApiCall()
                                    .getData('/viewUserOrders/${user['id']}');
                                final List<ViewUserOrder> transaction =
                                    viewUserOrderFromJson(response.body);
                                transaction.forEach((element) {
                                  restaurant = element.restaurantName;
                                  status = element.status;
                                  temp = {
                                    "restaurant": restaurant,
                                    "status": status
                                  };
                                  converted.add(temp);
                                });

                                for (var i = 0; i < converted.length; i++) {
                                  if (insideResto ==
                                          converted[i]['restaurant'] &&
                                      converted[i]['status'] < 4) {
                                    isTrue = true;
                                    break;
                                  }
                                }
                                if (isTrue) {
                                  showDial(context,
                                      "You have a pending Transaction order on this Restaurant.");
                                } else {
                                  if(int.parse(formatNow.split(":")[0]) >=int.parse(formatClosing.split(":")[0]) || int.parse(formatNow.split(":")[0]) >=0 && int.parse(formatNow.split(":")[0]) <08){
                                    print("CLOSE current:${formatNow.split(":")[0]} restoTime:${formatClosing.split(":")[0]}");
                                    showDial(context,"Sorry The Restaurant is close at the Moment Please Come Back");
                                  }else{
                                      if(int.parse(formatNow.split(":")[0])  >= int.parse(formatOpen.split(":")[0])){
                                         Navigator.pushReplacement(
                                        context,new MaterialPageRoute(builder: (context) => ListStactic(
                                                restauID: snapshot
                                                    .data[index].id
                                                    .toString(),
                                                nameRestau: snapshot
                                                    .data[index].restaurantName
                                                    .toString(),
                                              )));
                                      }else{
                                        showDial(context,"Sorry The Restaurant is Not yet open at the Moment Please Wait!");
                                
                                      }
                                      
                                  }
                                  // if (formatClosing.contains("PM") &&formatNow.contains("PM")) {

                                  //   if (cpTime > restoTime) {
                                  //     showDial(context,
                                  //         "Sorry The Restaurant Close as this moment of Time");
                                  //     print("CLOSE");
                                  //   } else {
                                  //      print("OPEN");
                                  //      Navigator.pushReplacement(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         builder: (context) => ListStactic(
                                  //               restauID: snapshot
                                  //                   .data[index].id
                                  //                   .toString(),
                                  //               nameRestau: snapshot
                                  //                   .data[index].restaurantName
                                  //                   .toString(),
                                  //             )));
                                  //   }
                                  // }else{
                                    
                                  //    if(formatNow.contains("AM")){
                                  //      if(cpTime > 11 || cpTime >=1 || restoOpen < cpTime){
                                         
                                  //      }else{
                                  //        Navigator.pushReplacement(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         builder: (context) => ListStactic(
                                  //               restauID: snapshot
                                  //                   .data[index].id
                                  //                   .toString(),
                                  //               nameRestau: snapshot
                                  //                   .data[index].restaurantName
                                  //                   .toString(),
                                  //             )));
                                  //      }
                                  //    }
                                  // }
                                 
                                }
                              },
                            ),
                          ),
                        )
                      : Container();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
