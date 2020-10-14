
import 'dart:convert';

import 'package:WhereTo/AnCustom/UserDialog_help.dart';
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
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class NewRestaurantViewFeatured extends StatefulWidget {
  @override
  _NewRestaurantViewFeaturedState createState() => _NewRestaurantViewFeaturedState();
}

class _NewRestaurantViewFeaturedState extends State<NewRestaurantViewFeatured> {
  
String categ ="0";
  @override
  void initState() {
    
    super.initState();
    streamRestaurantsFeatured..getFeaturedViewRestaurant(categ);
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
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
                  ProgressDialog featuredRestaurant = ProgressDialog(context);
                              featuredRestaurant.style(
                                message: "Loading Restaurant Please Wait..",
                                borderRadius: 10.0,
                                backgroundColor: Colors.white,
                                progressWidget: CircularProgressIndicator(),
                                elevation: 10.0,
                                insetAnimCurve: Curves.easeInExpo,
                                progressTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Gilroy-light"
                                )
                              );
                              featuredRestaurant =ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
                   return Column(
                     children: <Widget>[
                      //  NewRestaurantBox(
                      //   image: nf[index].imagePath,
                      //    restaurantName:nf[index].restaurantName ,
                      //    address: nf[index].latitude,nf[index].longitude,
                         
                      //    onTap: () async{
                      //      featuredRestaurant.show();
                      //           SharedPreferences local =
                      //           await SharedPreferences.getInstance();
                      //           var userjson = local.getString('user');
                      //           var user = json.decode(userjson);
                      //           var restaurant;
                      //           var status;
                      //           var address;
                      //           var insideResto =nf[index].restaurantName;
                      //           var insideAddress =nf[index].latitude+","+nf[index].longitude;
                      //           var isRead = false;
                      //           Map<String, dynamic> temp;
                      //           List<dynamic> converted = [];
                      //           final response = await ApiCall().getData('/viewUserOrders/${user['id']}');
                      //           final List<ViewUserOrder> transaction =viewUserOrderFromJson(response.body);
                      //           transaction.forEach((element) {
                      //             restaurant = element.restaurantName;
                      //             status = element.status;
                      //             address =element.address;
                      //             temp = {
                      //               "restaurant": restaurant,
                      //               "status": status,
                      //               "address":address,
                      //             };
                      //             converted.add(temp);
                      //           });
                      //           for (var i = 0; i < converted.length; i++) {
                      //             if (insideResto ==converted[i]['restaurant'] &&insideAddress==converted[i]['address'] &&converted[i]['status'] < 4) {
                      //               isRead = true;
                      //               break;
                      //             }
                      //           }
                      //           if (isRead) {
                      //            await featuredRestaurant.hide();
                      //           UserDialog_Help.restaurantDialog(context);
                      //           } else {
                      //             await featuredRestaurant.hide();
                      //             // if (int.parse(formatNow.split(":")[0]) >=int.parse(formatClosing.split(":")[0]) ||int.parse(formatNow.split(":")[0]) >= 0 &&int.parse(formatNow.split(":")[0]) <08) {
                      //             //   print(
                      //             //       "CLOSE current:${formatNow.split(":")[0]} restoTime:${formatClosing.split(":")[0]}");
                      //             //   showDial(context,
                      //             //       "Sorry The Restaurant is close at the Moment Please Come Back");
                      //             // } else {
                      //             //   if (int.parse(formatNow.split(":")[0]) >=
                      //             //       int.parse(formatOpen.split(":")[0])) {
                                    
                      //                 Navigator.push(
                      //                     context,
                      //                     new MaterialPageRoute(
                      //                         builder: (context) => ListStactic(
                      //                           restauID:nf[index].id.toString(),
                      //                           nameRestau: nf[index].restaurantName.toString(),
                      //                           baranggay: nf[index].barangayId.toString(),
                      //                           address:nf[index].latitude+","+nf[index].longitude,
                      //                           categID: categ,  
                      //                             )));
                      //           }
                           
                          
                      //    },
                      //  ),
                     ],
                   );
                },
                ),
            ),
          );
        }
    }
}