import 'dart:convert';

import 'package:WhereTo/AnCustom/restaurant_front.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/bloc.search.dart';
import 'package:WhereTo/restaurants/dialog.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:WhereTo/restaurants/searchRestaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class SearchResto extends StatefulWidget {
  @override
  _SearchRestoState createState() => _SearchRestoState();
}

class _SearchRestoState extends State<SearchResto> {
  BlocSearch blocSearch;
   Future<void>getBloc(var id) async {
    await blocSearch.getRest(id);
  }

  Future<void> disposeBloc() async {
    blocSearch.dispose();
  }
  TextEditingController search =TextEditingController();
  @override
  Widget build(BuildContext context) {
    setState(() {
    blocSearch = BlocSearch();
    getBloc(search.text); 
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: (){
          Navigator.pop(context);
        }),
        actions: [
          IconButton(icon: Icon(Icons.clear, color: Colors.black,), onPressed:(){
            search.text ="";
          }),
        ],
        title: TextField(
          controller: search,
          onChanged: (val){
            val =search.text;
            getBloc(search.text); 
          },
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.black,
            hintText: "Search"
          ),
        ),
        
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Container(
            height: 700.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            color: Color(0xFFF2F2F2F2),
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: StreamBuilder<List<SearchDeposition>>(
            stream: blocSearch.stream,
            builder: (context,snapshot){
              if(snapshot.hasData){
              if(snapshot.data.length >0){
                return new ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if(snapshot.data.length >0){
                     return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RestaurantFront(
                              image:
                                  "asset/img/${snapshot.data[index].restaurantName}.jpg",
                              restaurantName:
                                  snapshot.data[index].restaurantName,
                              restaurantAddress: snapshot.data[index].address,
                              openAndclose: snapshot.data[index].openTime +
                                  "-" +
                                  snapshot.data[index].closingTime,
                              onTap: () async {
                                final now = await NTP.now();
                                final formatNow = DateFormat.Hm().format(now);
                                DateFormat inputFormat = DateFormat("H:mm");
                                DateTime dateCloseTime = inputFormat
                                    .parse(snapshot.data[index].closingTime);
                                DateTime dateOpen = inputFormat
                                    .parse(snapshot.data[index].openTime);
                                String formatClosing =
                                    DateFormat.Hm().format(dateCloseTime);
                                String formatOpen =
                                    DateFormat.Hm().format(dateOpen);
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
                                  if (int.parse(formatNow.split(":")[0]) >=int.parse(formatClosing.split(":")[0]) ||int.parse(formatNow.split(":")[0]) >= 0 &&int.parse(formatNow.split(":")[0]) <08) {
                                    print(
                                        "CLOSE current:${formatNow.split(":")[0]} restoTime:${formatClosing.split(":")[0]}");
                                    showDial(context,
                                        "Sorry The Restaurant is close at the Moment Please Come Back");
                                  } else {
                                    if (int.parse(formatNow.split(":")[0]) >=
                                        int.parse(formatOpen.split(":")[0])) {
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ListStactic(
                                                    restauID: snapshot
                                                        .data[index].id
                                                        .toString(),
                                                    nameRestau: snapshot
                                                        .data[index]
                                                        .restaurantName
                                                        .toString(),
                                                  )));
                                    } else {
                                      showDial(context,
                                          "Sorry The Restaurant is Not yet open at the Moment Please Wait!");
                                    }
                                  }
                                }
                              },
                            ),
                          );   
                  }else{
                    return Container();
                  }
                },
              );
              }else{
                return Container();
              }

            }else{
              return Container(
                child: Center(
                  child: Text(
                    "Restaurants Loading..",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gilroy-light',
                        fontStyle: FontStyle.normal),
                  ),
                ),
              );
            }
          }),
          ),
          )
        ],
      ),
    );
  }
}