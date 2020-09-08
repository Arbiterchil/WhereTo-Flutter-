import 'dart:convert';

import 'package:WhereTo/AnCustom/LocationSet.dart';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/Services/connectivity_status.dart';
import 'package:WhereTo/Transaction/MyOrder/address.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/Transaction/SearchMenu/newSearch.dart';
import 'package:WhereTo/Transaction/SearchMenu/search.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWStream_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_view.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/newRestaurant_box.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/static_food.dart';
import 'package:WhereTo/restaurants/carousel_rest.dart';
import 'package:WhereTo/restaurants/dialog.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:WhereTo/restaurants/new_Carousel.dart';
import 'package:WhereTo/styletext.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FoodDisplay.dart';
class SearchDepo extends StatefulWidget {
  @override
  _SearchDepoState createState() => _SearchDepoState();
}



class _SearchDepoState extends State<SearchDepo> {
String categ ="0";

  @override
  void initState() {
    _getUserInfo();
    super.initState();
    streamRestaurantsFeatured..getFeaturedViewRestaurant();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamRestaurantsFeatured..drainStream();
  }

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController search = new TextEditingController();
  String searchit;
  var userData;
  String address;
  String newAddress;
  bool isLoc =false;
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    
    var user = json.decode(userJson);
    setState(() {
      userData = user;
      address =userData!= null ? userData['address'] :  'Fail get data.';
      newAddress ="${localStorage.getString("unit_number")}, ${localStorage.getString("house_number")}, ${localStorage.getString("building")}, ${localStorage.getString("street_name")}";
    });
  }

  @override
  Widget build(BuildContext context) {
    // var connectionStatus =Provider.of<ConnectivityStatus>(context);
    // if(connectionStatus ==ConnectivityStatus.Wifi){
    //   asuka.showSnackBar(SnackBar(content: Text("Connected",style: TextStyle(
    //     color: Colors.green
    //   ),)));
    // }
    // if(connectionStatus ==ConnectivityStatus.Offline){
    //   asuka.showSnackBar(SnackBar(content: Text("No Internet",style: TextStyle(
    //     color: Colors.red
    //   ),)));
    // }
    // if(connectionStatus ==ConnectivityStatus.Cellular){
    //   asuka.showSnackBar(SnackBar(content: Text("Mobile Data",style: TextStyle(
    //     color: Colors.orange
    //   ),)));
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pureblue,
        title: Padding(
          padding: EdgeInsets.only(left: 0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.8,
            child: GestureDetector(
                child: Column(
                  children: [
                  Text(
                "Delivery Address",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "Gilroy-light",
                    fontWeight: FontWeight.bold),
                  ),
                  Text(address ?? "" , style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: "Gilroy-light",
                fontWeight: FontWeight.bold
              ),),
                  ],
                ),
              onTap: (){
                setState(() {
                  isLoc=false;
                });
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AddressLine()));
              },
              ),

          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(icon: Icon(Icons.location_on), onPressed: (){
            setState(() {
              isLoc =true;
            });
          }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => UserDialog_Help.exit(context),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(
                    Icons.exit_to_app,
                    color: Color(0xFF0C375B),
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
                  ],
                ),
                // SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 0,right: 0),
                  child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: pureblue,
                                // Colors.white.withOpacity(0.80),
                                // borderRadius: BorderRadius.circular(30.0),
                              ),
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                readOnly: true,
                                showCursor: false,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy-light'),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    top: 15.0,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color:  Colors.white,
                                  ),
                                  hintText: "Search for Food",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy-light'),
                                ),
                                onTap: () {
                                  if(userData['address'].toString().contains("Tagum")){
                                  //   Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return SearchResto();
                                  // }));
                                  showSearch(context: context, delegate: CustomSearch());
                                  }else{
                                  AwesomeDialog(
                                  context: context,
                                  headerAnimationLoop: false,
                                  animType: AnimType.SCALE,
                                  dialogType: DialogType.INFO,
                                  title: "Location Not Available",
                                  desc: "This app is only available in Tagum City for the meantime",
                                  btnOkText: "Comeback Later",
                                  btnOkColor: Color(0xFF0C375B),
                                  btnOkOnPress: () async {
                                  Navigator.pop(context);
                                  }).show();
                                  }
                                  
                                },
                              )),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,),
                  child: SharedPrefCallnameData(),
                ),
                
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: 300,
                    height: 20,
                    child: Text(
                      "Featured Food in Restaurants",
                      style: TextStyle(
                          color: pureblue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Gilroy-light'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FoodDisplay(),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: 200,
                    height: 20,
                    child: Text(
                      "Featured Restaurants",
                      style: TextStyle(
                          color:pureblue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Gilroy-light'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
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
                  
                   return Column(
                     children: <Widget>[
                       NewRestaurantBox(
                        image: nf[index].imagePath,
                         restaurantName:nf[index].restaurantName ,
                         address: nf[index].address,
                         
                         onTap: () async{
                           ProgressDialog featuredRestaurant = ProgressDialog(context);
                              featuredRestaurant.style(
                                message: "Loading Restaurant Please Wait..",
                                borderRadius: 10.0,
                                backgroundColor: Colors.white,
                                progressWidget: CircularProgressIndicator(),
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
                              featuredRestaurant.show();
                                SharedPreferences local =
                                await SharedPreferences.getInstance();
                                var userjson = local.getString('user');
                                var user = json.decode(userjson);
                                var restaurant;
                                var status;
                                var address;
                                var insideResto =nf[index].restaurantName;
                                var insideAddress =nf[index].address;
                                var isRead = false;
                                Map<String, dynamic> temp;
                                List<dynamic> converted = [];
                                final response = await ApiCall().getData('/viewUserOrders/${user['id']}');
                                final List<ViewUserOrder> transaction =viewUserOrderFromJson(response.body);
                                transaction.forEach((element) {
                                  restaurant = element.restaurantName;
                                  status = element.status;
                                  address =element.address;
                                  temp = {
                                    "restaurant": restaurant,
                                    "status": status,
                                    "address":address,
                                  };
                                  converted.add(temp);
                                });
                                for (var i = 0; i < converted.length; i++) {
                                  if (insideResto ==converted[i]['restaurant'] &&insideAddress==converted[i]['address'] &&converted[i]['status'] < 4) {
                                    isRead = true;
                                    break;
                                  }
                                }
                                if (isRead) {
                                 await featuredRestaurant.hide();
                                UserDialog_Help.restaurantDialog(context);
                                } else {
                                  await featuredRestaurant.hide();
                                  // if (int.parse(formatNow.split(":")[0]) >=int.parse(formatClosing.split(":")[0]) ||int.parse(formatNow.split(":")[0]) >= 0 &&int.parse(formatNow.split(":")[0]) <08) {
                                  //   print(
                                  //       "CLOSE current:${formatNow.split(":")[0]} restoTime:${formatClosing.split(":")[0]}");
                                  //   showDial(context,
                                  //       "Sorry The Restaurant is close at the Moment Please Come Back");
                                  // } else {
                                  //   if (int.parse(formatNow.split(":")[0]) >=
                                  //       int.parse(formatOpen.split(":")[0])) {
                                    
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ListStactic(
                                                restauID:nf[index].id.toString(),
                                                nameRestau: nf[index].restaurantName.toString(),
                                                baranggay: nf[index].barangayId.toString(),
                                                address:nf[index].address.toString(),
                                                categID: categ,  
                                                  )));
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
