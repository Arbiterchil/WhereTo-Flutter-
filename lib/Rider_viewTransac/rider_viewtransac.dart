
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
                    // print(constant['id'].toString());
                    // print(constant['transact_id'].toString());
                    // print(constant['player_id'].toString());
                    // print(constant['user_coordinates'].toString());
                    // print(constant['transac_id'].toString());
                    getmessage = true;
                    // getThisShitOn(constant['transact_id'].toString());  
                    
                    playerId = constant['player_id'].toString();
                    // user_coor = constant['user_coordinates'].toString();
                    // idsComming.add(finalID);
                                  
                  // }else{
                  //   print("No Data");
                  // }
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
                    child: Customgettransac( image: "asset/img/logo.png",
                                transacId: v[index].id.toString(),
                                name: v[index].name,
                                address: v[index].address,
                                deliveryAddress:v[index].deliveryAddress,
                                restaurantName: v[index].restaurantName,
                                onTap: () async {

                                     Navigator.push(context, MaterialPageRoute(builder: (context){
                                                        return ViewMenuOnTransac(
                                                          getID:v[index].id.toString(),
                                                          deliverTo: v[index].deliveryAddress,
                                                          restaurantName: v[index].restaurantName,
                                                          deviceID: v[index].deviceId,
                                                          riderID: v[index].riderId,
                                                          deliveryCharge: v[index].deliveryCharge.toString(),
                                                          nametran:  v[index].name,
                                                          contactNumber : v[index].contactNumber.toString(),
                                                          playerId: v[index].deviceId,
                                                          user_coor : v[index].address);
                                                      }));
                                },
                    ),
                  ),
                ],
              );
            },
            
            );
        }

    

  }
  String valuemore= "";
  void converting(){
    
     CoordinatesConverter().convert(del).then((value) => setState(()=> valuemore =value));
      print(valuemore);
  } 

  // Widget _viewRider(){

  //     return Container(
  //       height: MediaQuery.of(context).size.height,
  //       width: MediaQuery.of(context).size.width,
  //         child: ListView.builder(
  //           scrollDirection: Axis.vertical,
  //           itemCount: inCommingtoSave.length,
  //           itemBuilder: (context , index){

  //             return SingleChildScrollView(
  //                 physics: AlwaysScrollableScrollPhysics(),
  //               child: Column(
  //                        children: <Widget>[

  //                         Padding(
  //                           padding: const EdgeInsets.only(top: 15),
  //                           child: Customgettransac( image: "asset/img/logo.png",
  //                             transacId: inCommingtoSave[index]['id'],
  //                             name: inCommingtoSave[index]['name'],
  //                             address: inCommingtoSave[index]['address'],
  //                             deliveryAddress: inCommingtoSave[index]['deliveryAddress'],
  //                             restaurantName: inCommingtoSave[index]['restaurantName'],
  //                             onTap: () async {

  //                                  Navigator.push(context, MaterialPageRoute(builder: (context){
  //                                                     return ViewMenuOnTransac(
  //                                                       getID: inCommingtoSave[index]['id'],
  //                                                       deliverTo: inCommingtoSave[index]['deliveryAddress'],
  //                                                       restaurantName: inCommingtoSave[index]['restaurantName'],
  //                                                       deviceID: inCommingtoSave[index]['deviceId'],
  //                                                       riderID: inCommingtoSave[index]['riderId'],
  //                                                       deliveryCharge: inCommingtoSave[index]['deliveryCharge'],
  //                                                       nametran:  inCommingtoSave[index]['name'],
  //                                                       playerId: inCommingtoSave[index]['deviceId'],
  //                                                       user_coor : user_coor.toString());
  //                                                   }));

  //                             },),
  //                         ),
  //                        ],
  //                      ),
  //             );

  //           },
  //         ),


  //     );


        // return Container(
        //     child: FutureBuilder(
        //       future: getTransac(),
        //       builder: (BuildContext context , AsyncSnapshot snapshot){
        //                 if(snapshot.data == null){
        //             return Container(
        //               child: Center(
        //                 child: Text("No Transaction Yet...",
        //                 style: TextStyle(
        //         color: Colors.white,
        //         fontFamily: 'OpenSans',
        //         fontSize:  16.0,
        //         fontWeight: FontWeight.normal
        //       ),),    
        //               ),
        //             );
        //           }else{

        //                   return SingleChildScrollView(
        //       physics: AlwaysScrollableScrollPhysics(),
        //       child: Container(
        //         height: MediaQuery.of(context).size.height,
        //         width: MediaQuery.of(context).size.width,
        //         child: ListView.builder(
        //           itemCount: snapshot.data.length,
        //           itemBuilder: (context,index){
        //              return Column(
        //                children: <Widget>[

        //                 Customgettransac( image: "asset/img/app.jpg",
        //                   transacId: snapshot.data[index].id.toString(),
        //                   name: snapshot.data[index].name,
        //                   address: snapshot.data[index].address,
        //                   deliveryAddress: snapshot.data[index].deliveryAddress,
        //                   restaurantName: snapshot.data[index].restaurantName,
        //                   onTap: () async {
                             
        //                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        //                                           return ViewMenuOnTransac(
        //                                             getID: snapshot.data[index].id.toString(),
        //                                             // gotTotal: totals.toString(),
        //                                             deliverTo: snapshot.data[index].deliveryAddress.toString(),
        //                                             restaurantName: snapshot.data[index].restaurantName.toString(),
        //                                             deviceID: snapshot.data[index].deviceId.toString(),
        //                                             riderID: snapshot.data[index].riderId.toString(),
        //                                             deliveryCharge: snapshot.data[index].deliveryCharge.toString(),
        //                                             nametran:  snapshot.data[index].name,
        //                                             playerId: playerId.toString(),
        //                                             user_coor : user_coor.toString());
        //                                         }));

        //                   },),
        //                ],
        //              );
        //           },
        //           ),
        //       ),
        //     );



        //           }
        //       },
        //     ),
         
        // );


  // }

}