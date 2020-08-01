import 'dart:convert';

import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/view_MenuTransac.dart';
import 'package:WhereTo/Rider_viewTransac/DummyTesting/dummy_Card.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_reponse.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_stream.dart';
import 'package:WhereTo/Rider_viewTransac/view_Transac.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';

class RiderViewing extends StatefulWidget {
  
  

  @override
  _RiderViewingState createState() => _RiderViewingState();
}
class _RiderViewingState extends State<RiderViewing> {

  var totalAll;
  var priceTotal = 0 ;
  var totals;

var constant;
  var finalID;
 

  @override
  void initState() { 
    super.initState();
    streamRider..getView();
  }
  @override
  void dispose() {
    super.dispose();
    streamRider..drainStream();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RiderResponse>(
      stream: streamRider.subject.stream,
      builder: (context , AsyncSnapshot<RiderResponse> snaphot){
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
    Widget _views(RiderResponse rider){
        List<RiderViewClass> rs = rider.riderview;

        if(rs.length == 0 ){
          return Container(
            child: Text('Ok.',
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: rs.length,
                itemBuilder: (context,index){
                   return Column(
                     children: <Widget>[
                       
        
                      // ViewTransacRider(
                      //   image: "asset/img/app.jpg",
                      //   transacId: rs[index].id.toString(),
                      //   name: rs[index].name,
                      //   address: rs[index].address,
                      //   deliveryAddress: rs[index].deliveryAddress,
                      //   restaurantName: rs[index].restaurantName,
                      //   onTap: () async {
                      //      final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/${rs[index].id.toString()}');
                      
                      //       var body = json.decode(response.body);
                      //       for(var body in body){
                      //           RiverMenu riverMenu = RiverMenu(
                      //             menuName: body["menuName"],
                      //       description: body["description"],
                      //       price: body["price"],
                      //       quantity: body["quantity"],
                      //           );
                      //           List prices =  [riverMenu.price] ;
                      //           List quans =  [riverMenu.quantity];
                      //           for(var i = 0 ; i < prices.length; i++){
                      //             for(var x = 0 ; x < quans.length ; x++){
                      //                 totalAll = prices[i]*quans[x];
                      //               List all =  [totalAll]; 
                      //               for(var z = 0 ; z < all.length; z++){
                                      
                      //                     priceTotal = priceTotal+all[z];
                                          
                            
                                          
                      //               }
                      //           }
                      //           }           
                      //       }
                      //       totals = priceTotal;
                      //       print(totals);
                      //        Navigator.push(context, MaterialPageRoute(builder: (context){
                      //                           return ViewMenuOnTransac(
                      //                             getID: rs[index].id.toString(),
                      //                             gotTotal: totals.toString(),
                      //                             deliverTo: rs[index].deliveryAddress.toString(),
                      //                             restaurantName: rs[index].restaurantName.toString(),
                      //                             deviceID: rs[index].deviceId.toString(),
                      //                             riderID: rs[index].riderId.toString(),);
                      //                         }));

                      //   },

                      // ),

                      

                     ],
                   );
                },
                ),
            ),
          );
        }
    }



}