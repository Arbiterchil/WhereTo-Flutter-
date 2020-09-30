
import 'package:WhereTo/Admin/A_RiderRet/rider_viewRets.dart';
import 'package:WhereTo/Admin/A_Rider_Remain/rider_reaminStream.dart';
import 'package:WhereTo/Admin/A_Rider_Remain/rider_remainResponse.dart';
import 'package:WhereTo/Rider_MonkeyBar/rider_bottom.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/rider_previous.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/view_MenuTransac.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:flutter/material.dart';

import '../../styletext.dart';

class RaminDataIndi extends StatefulWidget {

  final String id;

  const RaminDataIndi({Key key, this.id}) : super(key: key);

  @override
  _RaminDataIndiState createState() => _RaminDataIndiState(id);
}



class _RaminDataIndiState extends State<RaminDataIndi> {

  final String id;

  _RaminDataIndiState(this.id);
  @override
  void initState() {

    super.initState();
    remainStream..getRemianData();
  }

  @override
  void dispose() {
    super.dispose();
    remainStream.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
         shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<RemainResponse>(
                        stream: remainStream.subject.stream,
                        builder: (context, AsyncSnapshot<RemainResponse> asyncSnapshot){
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
                Text("Something went wrong")
              ],
            ),
          );
}
  Widget _views(RemainResponse response){
    List<RetieveAlltransac> v = response.retieveAlltransac;

     if(v.length == 0 ){
          return Center(
            child: Container(
              child: Text('No Transaction',
              style: TextStyle(
                color: Colors.white,
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
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                    // child: Customgettransac( image: "asset/img/logo.png",
                    //             transacId: v[index].id.toString(),
                    //             name: v[index].name,
                    //             address: v[index].restoLatitude.toString()+","+v[index].restoLongitude.toString(),
                    //             deliveryAddress:v[index].transLatitude+","+v[index].transLongitude,
                    //             restaurantName: v[index].restaurantName,
                    //             onTap: () async {

                    //                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    //                                     return Riderprevious(
                    //                                       getID:v[index].id.toString(),
                    //                                       deliverTo:v[index].transLatitude+","+v[index].transLongitude,
                    //                                       restaurantName: v[index].restaurantName,
                    //                                       deviceID: v[index].deviceId,
                    //                                       riderID: v[index].riderId.toString(),
                    //                                       deliveryCharge: v[index].deliveryCharge.toString(),
                    //                                       nametran:  v[index].name,
                    //                                       contactNumber : v[index].contactNumber.toString(),
                    //                                       playerId: v[index].deviceId,
                    //                                        user_coor :  v[index].restoLatitude.toString()+","+v[index].restoLongitude.toString()
                    //                                       );
                    //                                   }));
                    //             },
                    // ),
                    child:GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
                                                        return Riderprevious(
                                                          getID:v[index].id.toString(),
                                                          // reslats: v[index].restoLatitude,
                                                          // reslongs: v[index].restoLongitude,
                                                          // dellats: v[index].transLatitude,
                                                          // dellongs: v[index].transLongitude,
                                                          restaurantName: v[index].restaurantName,
                                                          deviceID: v[index].deviceId,
                                                          riderID: v[index].riderId.toString(),
                                                          deliveryCharge: v[index].deliveryCharge.toString(),
                                                          nametran:  v[index].name,
                                                          contactNumber : v[index].contactNumber.toString(),
                                                          playerId: v[index].deviceId,
                                                          user_coor: v[index].deliveryAddress,
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
                                                    //    SizedBox(height: 3.0,),
                                                    //     FutureBuilder(
                                                    //           future: CoordinatesConverter()
                                                    //           .getAddressByLocation(
                                                    //             v[index].restoLatitude.toString()
                                                    //             +","+
                                                    //             v[index].restoLongitude.toString()),
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
                                                    // //    Text(,
                                                    // //       overflow: TextOverflow.ellipsis,
                                                    // //       style: TextStyle(
                                                    // //       color:pureblue,
                                                    // //       fontWeight: FontWeight.normal,
                                                    // //       fontSize: 11.0,
                                                    // //       fontFamily: 'Gilroy-light'
                                                    // // ),
                                                    // //       ),
                                                      
                                                      
                                                    //   SizedBox(height: 3.0,), 
                                                    //   Flexible(
                                                    //         child: FutureBuilder(
                                                    //           future: CoordinatesConverter().getAddressByLocation(
                                                    //             v[index].transLatitude.toString()+","+v[index].transLongitude.toString()),
                                                    //           builder: (con ,snaps){
                                                    //             if(snaps.data == null){
                                                    //               return Container();
                                                    //             }else{
                                                    //               return Container(
                                                    //           child: Text('To: ${snaps.data}',
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
                                                    //       ),
                                                       
                         ],
                       ),
                     ),
                   ),
                 ),
               ],
             ),

                 
                        ),
    ) ,
                  ),
                ],
              );
            },
            
            );
        }
  }
}