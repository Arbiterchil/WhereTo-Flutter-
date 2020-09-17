
import 'package:WhereTo/Admin/A_RiderRet/rider_responseRet.dart';
import 'package:WhereTo/Admin/A_RiderRet/rider_streamRets.dart';
import 'package:WhereTo/Admin/A_RiderRet/rider_viewRets.dart';
import 'package:WhereTo/Admin/A_Rider_Remain/rider_remainView.dart';
import 'package:WhereTo/Rider_MonkeyBar/rider_bottom.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/view_MenuTransac.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styletext.dart';



class RiderTransaction extends StatefulWidget {



  const RiderTransaction({Key key}) : super(key: key);
  @override
  _RiderTransactionState createState() => _RiderTransactionState();
}
class _RiderTransactionState extends State<RiderTransaction> {

    var del;
var totalAll;
  var priceTotal = 0 ;
  var totals;
  bool getmessage = false;
  bool mine = false;
  var constant;
  var finalID;
  var playerId;
  var user_coor;
  var userRN;
  var idgetter;
  var getidSave;
  var getplayerOd;
  @override
  void initState() {
    
    mybackUp();
     menuTrans(); 
    super.initState();
    retriveStream..getRetieveTransac();
    
  }


  void menuTrans() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var idfromSave = localStorage.getString('menuplustrans');
      setState(() {
        if(idfromSave !=null){
          mine = true;
          getidSave = idfromSave;
      }else{
        print("Good Enough");
      }
      });
      
  }

void mybackUp() {
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
          constant =notification.payload.additionalData; 
                setState(()  {
                   constant =notification.payload.additionalData; 
                  // if(constant != null){
                    finalID = constant['transact_id'];
                    getmessage = true; 
                    playerId = constant['player_id'].toString();
                });          
    });
 }   
Map<String,String> alldata ={};  
List idsComming = [];

@override
  void dispose() {
    super.dispose();
    retriveStream..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFFF2F2F2),
    // Color(0xFF398AE5),
    body: WillPopScope(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                      GestureDetector(
                          onTap: () => 
                          Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) =>RiderTransaction())),
                          child: Text("Refresh",
                          style: TextStyle(
                            color: pureblue,
                            fontFamily: 'Gilroy-light',
                            fontSize: 16,
                          ),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Visibility(
                          visible: mine,
                          child: GestureDetector(
                            onTap: (){
                              print(getidSave);
                               showDialog(context: context,
                          barrierDismissible: true,
                          builder: (context) => RaminDataIndi(
                            id: getidSave,
                          ));
                            },
                            child: Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                color: pureblue,
                              ),
                              child: Center(
                                child: Text("Go to Previous.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gilroy-light',

                                ),),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 40.0,),
                  //  _viewRider(),
                  // RiderViewing()
                  Container(
                    height: 600,
                    child: StreamBuilder<RetrievResponse>(
                      stream: retriveStream.subject.stream,
                      builder: (context, AsyncSnapshot<RetrievResponse> asyncSnapshot){
                         if(asyncSnapshot.hasData){
                            if(asyncSnapshot.data.error !=null && asyncSnapshot.data.error.length > 0){
                            return _error(asyncSnapshot.data.error);
                       }
                       return  _views(asyncSnapshot.data);       
                        }else if(asyncSnapshot.hasError){
                              return _error(asyncSnapshot.error);
                        }else{
                              return _load();
                        }
                      },
                    ),
                  )
                  ],
                ),
              ),
            ),
         
        ),
      ),
      onWillPop: () async => false),
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
                    valueColor: AlwaysStoppedAnimation<Color>(pureblue),
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
                Text("Please Refresh to get Fresh Data.")
              ],
            ),
          );
}
  Widget _views(RetrievResponse response){
    List<RetieveAlltransac> v = response.feature;

     if(v.length == 0 ){
          return Center(
            child: Container(
              child: Text('No Transaction',
              style: TextStyle(
                color: pureblue,
                fontFamily: 'Gilroy-light',
                fontSize:  16.0,
                fontWeight: FontWeight.normal
              ),),
            ),
          );
        }else{
        
          return ListView.builder(
            itemCount: v.length,
            itemBuilder: (context,index){
              //  del = v[index].deliveryAddress;
              //  converting();
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    // child: Customgettransac( image: "asset/img/logo.png",
                    //             transacId: v[index].id.toString(),
                    //             name: v[index].name,
                    //             address: v[index].restoLatitude.toString()+","+v[index].restoLongitude.toString(),
                    //             deliveryAddress:v[index].transLatitude+","+v[index].transLongitude,
                    //             restaurantName: v[index].restaurantName,
                    //             onTap: () async {

                    //                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    //                                     return ViewMenuOnTransac(
                    //                                       getID:v[index].id.toString(),
                    //                                       deliverTo:v[index].transLatitude+","+v[index].transLongitude,
                    //                                       restaurantName: v[index].restaurantName,
                    //                                       deviceID: v[index].deviceId,
                    //                                       riderID: v[index].riderId.toString(),
                    //                                       deliveryCharge: v[index].deliveryCharge.toString(),
                    //                                       nametran:  v[index].name,
                    //                                       contactNumber : v[index].contactNumber.toString(),
                    //                                       playerId: v[index].deviceId,
                    //                                       user_coor :  v[index].restoLatitude.toString()+","+v[index].restoLongitude.toString()
                    //                                       );
                    //                                   }));
                    //             },
                    // ),
                    child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
                                                        return ViewMenuOnTransac(
                                                          getID:v[index].id.toString(),
                                                          reslats: v[index].restoLatitude,
                                                          reslongs: v[index].restoLongitude,
                                                          dellats: v[index].transLatitude,
                                                          dellongs: v[index].transLongitude,
                                                          restaurantName: v[index].restaurantName,
                                                          deviceID: v[index].deviceId,
                                                          riderID: v[index].riderId.toString(),
                                                          deliveryCharge: v[index].deliveryCharge.toString(),
                                                          nametran:  v[index].name,
                                                          contactNumber : v[index].contactNumber.toString(),
                                                          playerId: v[index].deviceId,
                                                          // user_coor :  v[index].restoLatitude.toString()+","+v[index].restoLongitude.toString()
                                                          );
                                                      }));
      },
      child:  Container(
             height: 150,
             width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
               border: Border.all(
                 width: 1,
                 color: pureblue,
               ),
               borderRadius: BorderRadius.all(Radius.circular(20)),
             ),
             child: Stack(
               children: <Widget>[
                 Align(
                   alignment: Alignment.centerLeft,
                   child: Padding(
                     padding: const EdgeInsets.only(left: 20),
                     child: Container(
                       height: 50,
                       width: 50,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                           image: AssetImage("asset/img/logo.png") )
                       ),
                     
                     ),
                   ),
                 ),
                 Align(
                   alignment: Alignment.centerRight,
                   child: Padding(
                     padding: const EdgeInsets.only(right: 20),
                     child: Container(
                        width: 190,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                          Text(v[index].name,
                                                      style: TextStyle(
                                                      color: pureblue,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18.0,
                                                      fontFamily: 'Gilroy-ExtraBold'
                                                    ),
                                                      ),
                                                      SizedBox(height: 7.0,),
                                                      Text(v[index].restaurantName,
                                                      style: TextStyle(
                                                      color: pureblue,
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 11.0,
                                                      fontFamily: 'Gilroy-light'
                                                    ),
                                                      ),
                                                       SizedBox(height: 3.0,),
                                                    //     FutureBuilder(
                                                    //           future: CoordinatesConverter().convert(v[index].restoLatitude,v[index].restoLongitude),
                                                    //           builder: (con ,snaps){
                                                    //             if(snaps.data == null){
                                                    //               return Container();
                                                    //             }else{
                                                    //               return Container(
                                                    //           child: Text('From: ${snaps.data}',
                                                    //           overflow: TextOverflow.ellipsis,
                                                    //           style: TextStyle(
                                                    //           color: pureblue,
                                                    //           fontWeight: FontWeight.normal,
                                                    //           fontSize: 11.0,
                                                    //           fontFamily: 'Gilroy-light'
                                                    // ),
                                                    //           ),
                                                    //         );
                                                    //             }
                                                    //           },
                                                    //         ),
                                                    //    Text(,
                                                    //       overflow: TextOverflow.ellipsis,
                                                    //       style: TextStyle(
                                                    //       color:pureblue,
                                                    //       fontWeight: FontWeight.normal,
                                                    //       fontSize: 11.0,
                                                    //       fontFamily: 'Gilroy-light'
                                                    // ),
                                                    //       ),
                                                      
                                                      
                                                      SizedBox(height: 3.0,), 
                                                      Flexible(
                                                            child: FutureBuilder(
                                                              future: CoordinatesConverter().convert(v[index].transLatitude,v[index].transLongitude),
                                                              builder: (con ,snaps){
                                                                if(snaps.data == null){
                                                                  return Container();
                                                                }else{
                                                                  return Container(
                                                              child: Text('To: ${snaps.data}',
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                              color: pureblue,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 11.0,
                                                              fontFamily: 'Gilroy-light'
                                                    ),
                                                              ),
                                                            );
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                       
                         ],
                       ),
                     ),
                   ),
                 ),
               ],
             ),

                 
                        ),
    ),

                  ),
                ],
              );
            },
            
            );
        }

    

  }

}