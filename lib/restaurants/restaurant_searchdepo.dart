import 'dart:convert';
import 'package:WhereTo/A_loadingSimpe/simple_loading.dart';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/Transaction/SearchMenu/newSearch.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/google_maps/googlemap_address.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWStream_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_response.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/newRestaurant_box.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:WhereTo/restaurants/new_Carousel.dart';
import 'package:WhereTo/styletext.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
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
String categ ="0";

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    streamRestaurantsFeatured..getFeaturedViewRestaurant();
    
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
  bool isLoc =false;
  String newAnd ="";
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    
    var user = json.decode(userJson);
    setState(() {
      userData = user;
      address =userData!= null ? user['latitude']+","+user['longitude']:  'Fail get data.';
      newAddress ="${localStorage.getString("unit_number")}, ${localStorage.getString("house_number")}, ${localStorage.getString("building")}, ${localStorage.getString("street_name")}";
    });
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top:8.0,left: 10.0,right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        logoutIcon(),
                        SizedBox(width: 10,),
                        cirlceLoaction(),
                        SizedBox(width: 10,),
                        Expanded(
                          child: textbarSearch()
                          ),
                          SizedBox(width: 10,),
                        
                      ],
                    ),
                    
                  ),
                  SizedBox(height: 20,),
                  
                   Stack(
                    children: <Widget>[
                      NewCarousel(),
                    ],),
                    SizedBox(height: 10,),
                  viewMenuFeaturedTitle(),
                  SizedBox(height: 10,),
                  FoodDisplay(),
                  SizedBox(height: 15,),
                  viewzRestaurantFeaturedTitle(),
                  SizedBox(height: 10,),
                   Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
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
                   SizedBox(height: 15,),
                  //   deliveryAdress(),
                     SizedBox(height: 10,),
                   Divider(
                    height: 6.0,
                    thickness: 1,
                    color: wheretoDark,
                    indent: 60.0,
                    endIndent: 60.0,
                  ),
                  SizedBox(height: 20,),
                  
                  SharedPrefCallnameData(),
                   SizedBox(height: 10,),
                ],
              ),
            ),
          )),
      
    );

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
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: pureblue,
    //     title: Padding(
    //       padding: EdgeInsets.only(left: 0),
    //       child: Container(
    //         width: MediaQuery.of(context).size.width*0.8,
    //         child: GestureDetector(
    //             child: Column(
    //               children: [
    //               Text(
    //             "Delivery Address",
    //             style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 12,
    //                 fontFamily: "Gilroy-light",
    //                 fontWeight: FontWeight.bold),
    //               ),
    //               Text(address ?? "" , style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 10,
    //             fontFamily: "Gilroy-light",
    //             fontWeight: FontWeight.bold
    //           ),),
    //               ],
    //             ),
    //           onTap: (){
    //             setState(() {
    //               isLoc=false;
    //             });
    //             // Navigator.push(context, MaterialPageRoute(builder: (context) => AddressLine()));
    //           },
    //           ),

    //       ),
    //     ),
    //     leading: Padding(
    //       padding: EdgeInsets.only(left: 0),
    //       child: IconButton(icon: Icon(Icons.location_on), onPressed: (){
    //         setState(() {
    //           isLoc =true;
    //         });
    //       }),
    //     ),
    //     actions: [
    //       Padding(
    //         padding: const EdgeInsets.only(right: 10),
    //         child: GestureDetector(
    //           onTap: () => UserDialog_Help.exit(context),
    //           child: Container(
    //             height: 30,
    //             width: 30,
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: Colors.white,
    //             ),
    //             child: Center(
    //               child: Icon(
    //                 Icons.exit_to_app,
    //                 color: Color(0xFF0C375B),
    //                 size: 20,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    //   key: scaffoldKey,
    //   body: WillPopScope(
    //     onWillPop: () async => false,
    //     child: SafeArea(
    //       child: SingleChildScrollView(
    //         physics: AlwaysScrollableScrollPhysics(),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Stack(
    //               children: <Widget>[
    //                 NewCarousel(),
    //               ],
    //             ),
    //             // SizedBox(height: 20,),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 0,right: 0),
    //               child: Container(
    //                           height: 50.0,
    //                           decoration: BoxDecoration(
    //                             color: pureblue,
    //                             // Colors.white.withOpacity(0.80),
    //                             // borderRadius: BorderRadius.circular(30.0),
    //                           ),
    //                           alignment: Alignment.centerLeft,
    //                           child: TextField(
    //                             readOnly: true,
    //                             showCursor: false,
    //                             style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.bold,
    //                                 fontFamily: 'Gilroy-light'),
    //                             decoration: InputDecoration(
    //                               border: InputBorder.none,
    //                               contentPadding: const EdgeInsets.only(
    //                                 top: 15.0,
    //                               ),
    //                               prefixIcon: Icon(
    //                                 Icons.search,
    //                                 color:  Colors.white,
    //                               ),
    //                               hintText: "Search for Food",
    //                               hintStyle: TextStyle(
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.bold,
    //                                 fontFamily: 'Gilroy-light'),
    //                             ),
    //                             onTap: () {
    //                               if(userData['address'].toString().contains("Tagum")){
    //                               //   Navigator.push(context,
    //                               //     MaterialPageRoute(builder: (context) {
    //                               //   return SearchResto();
    //                               // }));
    //                               showSearch(context: context, delegate: CustomSearch());
    //                               }else{
    //                               AwesomeDialog(
    //                               context: context,
    //                               headerAnimationLoop: false,
    //                               animType: AnimType.SCALE,
    //                               dialogType: DialogType.INFO,
    //                               title: "Location Not Available",
    //                               desc: "This app is only available in Tagum City for the meantime",
    //                               btnOkText: "Comeback Later",
    //                               btnOkColor: Color(0xFF0C375B),
    //                               btnOkOnPress: () async {
    //                               Navigator.pop(context);
    //                               }).show();
    //                               }
                                  
    //                             },
    //                           )),
    //             ),
    //             SizedBox(height: 20,),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 10,right: 10,),
    //               child: SharedPrefCallnameData(),
    //             ),
                
    //             SizedBox(height: 40,),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20, right: 20),
    //               child: Container(
    //                 width: 300,
    //                 height: 20,
    //                 child: Text(
    //                   "Featured Food in Restaurants",
    //                   style: TextStyle(
    //                       color: pureblue,
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 16.0,
    //                       fontFamily: 'Gilroy-light'),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             FoodDisplay(),
    //             SizedBox(
    //               height: 30,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20, right: 20),
    //               child: Container(
    //                 width: 200,
    //                 height: 20,
    //                 child: Text(
    //                   "Featured Restaurants",
    //                   style: TextStyle(
    //                       color:pureblue,
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 16.0,
    //                       fontFamily: 'Gilroy-light'),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 5.0,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 10, right: 10),
    //               child: StreamBuilder<NewRestaurantResponse>(
    //   stream: streamRestaurantsFeatured.subject.stream,
    //   builder: (context , AsyncSnapshot<NewRestaurantResponse> snaphot){
    //     if(snaphot.hasData){
    //         if(snaphot.data.error !=null && snaphot.data.error.length > 0){
    //             return _error(snaphot.data.error);
    //         }
    //           return _views(snaphot.data);
    //     }else if(snaphot.hasError){
    //           return _error(snaphot.error);
    //     }else{
    //           return _load();
    //     }
    //   },
    //             ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget viewMenuFeaturedTitle(){

    return Padding(
      padding: const EdgeInsets.only(left: 5.0,right: 5.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          // border: Border.all(
          //   width: 1,
          //   color: wheretoDark,
          // )
        ),
        child: Text("Featured Food in Restaurants",
         style: TextStyle(
                            color: wheretoDark,
                             fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            fontFamily: 'Gilroy-ExtraBold'),
                      ),
        ),
    );
  

  }

   Widget viewzRestaurantFeaturedTitle(){

    return Padding(
      padding: const EdgeInsets.only(left: 5.0,right: 5.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          // border: Border.all(
          //   width: 1,
          //   color: wheretoDark,
          // )
        ),
        child: Text("Featured Restaurants",
         style: TextStyle(
                            color: wheretoDark,
                             fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            fontFamily: 'Gilroy-ExtraBold'),
                      ),
        ),
    );
  

  }

  Widget textbarSearch(){
   return FutureBuilder(
     future: CoordinatesConverter().convert(address),
     builder: (context , snaps){
      if(snaps.data == null){
        return Container();
      }else{
        return Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                color:Colors.white,
                                // Colors.white.withOpacity(0.80),
                                borderRadius: BorderRadius.circular(30.0),
                                 boxShadow: [
                             BoxShadow(
                               color: Colors.grey[200],
                               spreadRadius: 3.3,
                               blurRadius: 3.3
                             ),
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
                                  if(snaps.data.toString().contains("Tagum")){
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
                              )
                );
      }
   });
  }

  Widget logoutIcon(){
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
                               color: Colors.grey[200],
                               spreadRadius: 3.3,
                               blurRadius: 3.3
                             ),
                           ],
        ),
        child:  Icon(
                      Icons.exit_to_app,
                      color: Color(0xFF0C375B),
                      size: 30,
                    ),
      ),
    );


  }

  Widget cirlceLoaction(){

    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
         boxShadow: [
                             BoxShadow(
                               color: Colors.grey[200],
                               spreadRadius: 3.3,
                               blurRadius: 3.3
                             ),
                           ],
      ),
      child: IconButton(
        icon: 
        Icon(
          Icons.location_on
          ,size: 30,
          ), onPressed: ()async{

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

  Widget deliveryAdress(){

    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Container(
              width: MediaQuery.of(context).size.width*0.8,
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
                    
                    SizedBox(height: 10,),
                    Text(address ?? "" , style: TextStyle(
                  color:wheretoDark,
                  fontSize: 10,
                  fontFamily: "Gilroy-light",
                ),),
                    ],
                  ),
                onTap: (){
                  setState(() {
                    isLoc=false;
                  });
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => AddressLine()));
                  
                }
              )
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
                Text("Come Back Later.")
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

                      FutureBuilder(
                        future: CoordinatesConverter().convert(nf[index].latitude,nf[index].longitude),
                        builder: (cons,snaps){
                          if(snaps.data != null){
                            return NewRestaurantBox(
                        image: nf[index].imagePath,
                         restaurantName:nf[index].restaurantName ,
                         address:snaps.data, 
                         onTap: () async{

                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (con)=>SimpleAppLoader());

                          //  ProgressDialog featuredRestaurant = ProgressDialog(context);
                          //     featuredRestaurant.style(
                          //       message: "Loading Restaurant Please Wait..",
                          //       borderRadius: 10.0,
                          //       backgroundColor: Colors.white,
                          //       progressWidget: CircularProgressIndicator(),
                          //       elevation: 10.0,
                          //       insetAnimCurve: Curves.fastLinearToSlowEaseIn,
                          //       progressTextStyle: TextStyle(
                          //           color: Colors.black,
                          //           fontSize: 15.0,
                          //           fontWeight: FontWeight.w300,
                          //           fontFamily: "Gilroy-light"
                          //       )
                          //     );
                          //     featuredRestaurant =ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
                          //     featuredRestaurant.show();
                          
                                SharedPreferences local =
                                await SharedPreferences.getInstance();
                                var userjson = local.getString('user');
                                var user = json.decode(userjson);
                                var restaurant;
                                var status;
                                var address;
                                var insideResto =nf[index].restaurantName;
                                var insideAddress =nf[index].latitude+","+nf[index].longitude;
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
                                //  await featuredRestaurant.hide();
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
                                    var addr =await ID().getPosition();
                                    var converterUser =await CoordinatesConverter().addressByCity(addr);
                                    var converterResto =await CoordinatesConverter().addressByCity(nf[index].latitude+","+nf[index].longitude);
                                   
                                  
                                    
                                    // await featuredRestaurant.hide();
                                    Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ListStactic(
                                                restauID:nf[index].id.toString(),
                                                nameRestau: nf[index].restaurantName.toString(),
                                                baranggay: nf[index].barangayId.toString(),
                                                address:nf[index].latitude+","+nf[index].longitude,
                                                categID: categ,  
                                                  )));
                                    
                                    
                                }
                           
                          
                         },
                        );
                          }else{
                            return Container();
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
