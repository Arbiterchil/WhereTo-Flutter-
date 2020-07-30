import 'dart:convert';
import 'dart:ffi';

import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/view_MenuTransac.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_views.dart';
import 'package:WhereTo/Rider_viewTransac/view_Transac.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../designbuttons.dart';



class RiderTransaction extends StatefulWidget {

   final String number;

  const RiderTransaction({Key key, this.number}) : super(key: key);




  @override
  _RiderTransactionState createState() => _RiderTransactionState();
}
class _RiderTransactionState extends State<RiderTransaction> {

  
var totalAll;
  var priceTotal = 0 ;
  var totals;
  bool getmessage = false;
      var constant;
  var finalID;
  var idgetter;
  
  @override
  void initState() {
    notifmeNow();
    mybackUp();
    super.initState();
  }
void notifmeNow() async{
 OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
                constant =notification.payload.additionalData; 
                
                setState(() {
                  if(constant != null){
                    print(constant['id'].toString());
                    getmessage = true;
                    finalID = constant['id'];

                  }else{
                    print("No Data");
                  }
                });
    });

  var status = await OneSignal.shared.getPermissionSubscriptionState();
         String url = 'https://onesignal.com/api/v1/notifications';
    var playerId = status.subscriptionStatus.userId;

    var numb = "3";
    var contents = {
      "include_player_ids": [playerId],
      "include_segments": ["Users Notif"],
      "excluded_segments": [],
      "contents": {"en": "This is a a Fucking test"},
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
    // var repo =
        await http.post(url, headers: headers, body: json.encode(contents));

      // print(repo.body);
      

        
    
     }

  Future<List<RiderViewClass>> getTransac() async {
   
        final response = await ApiCall().viewTransac('/getTransactionDetails/$finalID');
        List<RiderViewClass> riderme = [];
        var body = json.decode(response.body);
        for (var body in body){
            RiderViewClass riderViewClass = RiderViewClass
          (
            id: body["id"],
            name: body["name"],
            restaurantName: body["restaurantName"],
            address: body["address"],
            deviceId: body["deviceId"],
            riderId: body["riderId"],
            deliveryAddress: body["deliveryAddress"],
            );

            riderme.add(riderViewClass);
        }
        print(riderme.length);
        return riderme;
  }

 mybackUp() async {

   SharedPreferences local = await SharedPreferences.getInstance();
        
          var check = local.getBool("cuurentIdtrans");
        if(check !=null ){

            if(check){
                  idgetter = local.getString("menuplustrans");
                  print(idgetter);
                    
            }else{
              print("No Id Getter.");
            }

        }

 }   

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    backgroundColor: Color(0xFF398AE5),
    body: WillPopScope(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                     Container(
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: DesignButton(
                                        height: 55,
                                        width: 55,
                                        color: Color(0xFF398AE5),
                                        offblackBlue: Offset(-4, -4),
                                        offsetBlue: Offset(4, 4),
                                        blurlevel: 4.0,
                                        icon: Icons.arrow_back,
                                        iconSize: 30.0,
                                        onTap: ()  {
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                                return RiderProfile();
                                              }));
                                    },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: DesignButton(
                                        height: 55,
                                        width: 55,
                                        color: Color(0xFF398AE5),
                                        offblackBlue: Offset(-4, -4),
                                        offsetBlue: Offset(4, 4),
                                        blurlevel: 4.0,
                                        icon: Icons.refresh,
                                        iconSize: 30.0,
                                        onTap: (){
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                                return RiderTransaction();
                                              }));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                     SizedBox(height: 40.0,),
                    //  TestCombineRxDart(),
                    // idgetter==null ?  "": RiderViewing(),
                  //  getmessage ?  _viewRider() : false
                  // RiderViewing(),
                  _viewRider()
                  
                   
                
             
                  ],
                ),
              ),
            ),
         
        ),
      ),
      onWillPop: () async => false),
    );
  }

  Widget _viewRider(){
        return Visibility(
          visible: getmessage,
          child: Container(
            child: FutureBuilder(
              future: getTransac(),
              builder: (BuildContext context , AsyncSnapshot snapshot){
                        if(snapshot.data == null){
                    return Container(
                      child: Center(
                        child: Text("No Transaction Yet...",
                        style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize:  16.0,
                fontWeight: FontWeight.normal
              ),),    
                      ),
                    );
                  }else{

                          return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                     return Column(
                       children: <Widget>[
                         ViewTransacRider(
                          image: "asset/img/app.jpg",
                          transacId: snapshot.data[index].id.toString(),
                          name: snapshot.data[index].name,
                          address: snapshot.data[index].address,
                          deliveryAddress: snapshot.data[index].deliveryAddress,
                          restaurantName: snapshot.data[index].restaurantName,
                          onTap: () async {
                             final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/${snapshot.data[index].id.toString()}');
                        
                              var body = json.decode(response.body);
                              for(var body in body){
                                  RiverMenu riverMenu = RiverMenu(
                                    menuName: body["menuName"],
                              description: body["description"],
                              price: body["price"],
                              quantity: body["quantity"],
                                  );
                                  List prices =  [riverMenu.price] ;
                                  List quans =  [riverMenu.quantity];
                                  for(var i = 0 ; i < prices.length; i++){
                                    for(var x = 0 ; x < quans.length ; x++){
                                        totalAll = prices[i]*quans[x];
                                      List all =  [totalAll]; 
                                      for(var z = 0 ; z < all.length; z++){
                                        
                                            priceTotal = priceTotal+all[z];
                                            
                              
                                            
                                      }
                                  }
                                  }           
                              }
                              totals = priceTotal;
                              print(totals);
                               Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return ViewMenuOnTransac(
                                                    getID: snapshot.data[index].id.toString(),
                                                    gotTotal: totals.toString(),
                                                    deliverTo: snapshot.data[index].deliveryAddress.toString(),
                                                    restaurantName: snapshot.data[index].restaurantName.toString(),
                                                    deviceID: snapshot.data[index].deviceId.toString(),
                                                    riderID: snapshot.data[index].riderId.toString(),);
                                                }));

                          },
                        ),
                       ],
                     );
                  },
                  ),
              ),
            );



                  }
              },
            ),
          ),
        );


  }

}