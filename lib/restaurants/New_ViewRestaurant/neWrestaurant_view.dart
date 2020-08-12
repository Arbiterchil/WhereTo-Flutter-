
import 'dart:convert';

import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWStream_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/newRestaurant_box.dart';
import 'package:WhereTo/restaurants/dialog.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class NewRestaurantViewFeatured extends StatefulWidget {
  @override
  _NewRestaurantViewFeaturedState createState() => _NewRestaurantViewFeaturedState();
}

class _NewRestaurantViewFeaturedState extends State<NewRestaurantViewFeatured> {
  

  @override
  void initState() {
    
    super.initState();
    streamRestaurantsFeatured..getFeaturedViewRestaurant();
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   streamRestaurantsFeatured..drainStream();
  // }
  
  @override
  Widget build(BuildContext context) {
  return StreamBuilder<NewRestaurantResponse>(
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
                         onTap: () async {final now = await NTP.now();
                                final formatNow = DateFormat.Hm().format(now);
                                DateFormat inputFormat = DateFormat("H:mm");
                                DateTime dateCloseTime = inputFormat
                                    .parse(nf[index].closingTime);
                                DateTime dateOpen = inputFormat
                                    .parse(nf[index].openTime);
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
                                  nf[index].restaurantName;
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
                                  if (int.parse(formatNow.split(":")[0]) >=
                                          int.parse(
                                              formatClosing.split(":")[0]) ||
                                      int.parse(formatNow.split(":")[0]) >= 0 &&
                                          int.parse(formatNow.split(":")[0]) <
                                              08) {
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
                                                    restauID: nf[index].id
                                                        .toString(),
                                                    nameRestau: nf[index]
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
                     ],
                   );
                },
                ),
            ),
          );
        }
    }
}