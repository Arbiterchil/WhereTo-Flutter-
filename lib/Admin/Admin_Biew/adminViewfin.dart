
import 'dart:convert';

import 'package:WhereTo/Admin/Admin_Biew/adminView.dart';
import 'package:WhereTo/Admin/Admin_Biew/adminView_Stream.dart';
import 'package:WhereTo/Admin/Admin_Biew/adminviewResonponse.dart';
import 'package:WhereTo/Admin/Admin_Biew/meniFinB.dart';
import 'package:WhereTo/Admin/admin_dash.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerTransaction.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuResponseTran.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuStreamtran.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class AdminViewer extends StatefulWidget {
  @override
  _AdminViewerState createState() => _AdminViewerState();
}

class _AdminViewerState extends State<AdminViewer> {


  @override
  void initState() {
    super.initState();
    adminviewStreamer..getTransaCView();
  }

  @override
  void dispose() {
    adminviewStreamer..drainStream();
    // getMenuStreamTransDet..drainStreamDet();
    super.dispose();
  }

var totalAll;
double priceTotal = 0;
var totals;

//  getTotalPrice(int id) async{


// final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/$id');                     
//                               var body = json.decode(response.body);
//                               for(var body in body){
//                                   RiverMenu riverMenu = RiverMenu(
//                                     menuName: body["menuName"],
//                               description: body["description"],
//                               totalPrice: body["totalPrice"].toDouble(),
//                               id: body["id"],
//                               quantity: body["quantity"],
//                                   );
//                                   List prices =  [riverMenu.totalPrice];
//                                   List quans =  [riverMenu.quantity];
//                                   for(var i = 0 ; i < prices.length; i++){
//                                     for(var x = 0 ; x < quans.length ; x++){
//                                         totalAll = prices[i]*quans[x];
//                                       List all =  [totalAll]; 
//                                       for(var z = 0 ; z < all.length; z++){
//                                             priceTotal = priceTotal+all[z];                                           
//                                       }
//                                   }
//                                   }           
//                               }
                            
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: ()=> Navigator.pushReplacement(context, new MaterialPageRoute(builder: (_)=>
                      AdminDash()
                      )),
                      child: Container(
                        height: 40,
                        child: Text('Back',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: 'Gilroy-light',
                          fontSize: 18
                        ),),
                      ),
                    ),

                    StreamBuilder<AdminViewResponses>(
                      stream: adminviewStreamer.subject.stream,
                      builder: (con,AsyncSnapshot<AdminViewResponses> adminres){
                        if(adminres.hasData){
                          if(adminres.data.error != null && adminres.data.error.length > 0){
                            return buildWidgetError(adminres.data.error);
                          }
                          return buildWidgetView(adminres.data);
                        }else if(adminres.hasError){
                           return buildWidgetError(adminres.data.error); 
                        }else{
                            return buildWidgetLoad();
                        }
                      }),                 
                  ],
                ),
              ),
            )),
        ),
    );
  }

  Widget  buildWidgetError(String error){
    return Center(
      child: Text("$error"),
    );
  }
  Widget buildWidgetLoad(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor:  new AlwaysStoppedAnimation<Color>(Colors.indigo[700]),
          strokeWidth: 4.0,
        ),
      ),
    );
  }
  Widget buildWidgetView(AdminViewResponses adminViewResponses){
    List<TransactionDetail> ads = adminViewResponses.adminv;
    if(ads.length == 0){
      return Container(
        height: 350,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text("No More"),
        ),
      );
    }else{
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: ads.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (con,index){
            // getMenuStreamTransDet..getMenuTransacDetails(ads[index].id);
            // getTotalPrice(ads[index].id);  
            return GestureDetector(
              onTap: () => showDialog(context: context,
              barrierDismissible: false,
              builder: (context)=>MenuForAdminView(id: ads[index].id,)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rider Name:',
                        style: TextStyle(
                          color:Colors.indigo,
                          fontFamily: 'Gilroy-light',
                          fontSize: 12
                          ),),
                        SizedBox(height: 5,),
                        Text(ads[index].name,
                        style: TextStyle(
                          color:Colors.indigo,
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 14
                          ),),
                        SizedBox(height: 10,),
                       
                        Text('Restaurant Name:',
                        style: TextStyle(
                          color:Colors.indigo,
                          fontFamily: 'Gilroy-light',
                          fontSize: 12
                          ),),
                        SizedBox(height: 5,),
                        Text(ads[index].restaurantName,
                        style: TextStyle(
                          color:Colors.indigo,
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 14
                          ),),
                        SizedBox(height: 10,),

                        Text('Delivery Charge:',
                        style: TextStyle(
                          color:Colors.indigo,
                          fontFamily: 'Gilroy-light',
                          fontSize: 12
                          ),),
                        SizedBox(height: 5,),
                        Text(ads[index].deliveryCharge.toString(),
                        style: TextStyle(
                          color:Colors.indigo,
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 14
                          ),),
                        SizedBox(height: 10,),

                        Text('Baranggay:',
                        style: TextStyle(
                          color:Colors.indigo,
                          fontFamily: 'Gilroy-light',
                          fontSize: 12
                          ),),
                        SizedBox(height: 5,),
                        Text(ads[index].barangayName,
                        style: TextStyle(
                          color:Colors.indigo,
                          fontFamily: 'Gilroy-ExtraBold',
                          fontSize: 14
                          ),),
                        SizedBox(height: 10,),

                        Text('Delivery Address Name:',
                        style: TextStyle(
                          color:Colors.indigo,
                          fontFamily: 'Gilroy-light',
                          fontSize: 12
                          ),),
                        SizedBox(height: 5,),
                        Container(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Text(ads[index].deliveryAddress,
                            style: TextStyle(
                              color:Colors.indigo,
                              fontFamily: 'Gilroy-ExtraBold',
                              fontSize: 14
                              ),),
                          ),
                        ),
                        SizedBox(height: 15,),

                        // StreamBuilder<GetMenuPertransactionResponse>(
                        //   stream: getMenuStreamTransDet.subject.stream,
                        //   builder: (cons,AsyncSnapshot<GetMenuPertransactionResponse> snapshot){
                        //     if(snapshot.hasData){
                        //     if(snapshot.data.error != null && snapshot.data.error.length > 0){
                        //       return buildWidgetError(snapshot.data.error);
                        //     }
                        //     return buildWidgetViewMenu(snapshot.data);
                        //   }else if(snapshot.hasError){
                        //      return buildWidgetError(snapshot.data.error); 
                        //   }else{
                        //       return buildWidgetLoad();
                        //   }
                        //   }),

                      ],
                    ),
                    ),
                ),
              ),
            );
          }),
      );
    }
  }
  Widget buildWidgetViewMenu(GetMenuPertransactionResponse gt){
    List<GetMenuPerTransaction> gts = gt.getTran;   
    if(gts.length == 0){
      return Center(
          child: Icon(Icons.clear,color: wheretoDark,size: 50,),
        );
    }else{
      return Column(
        children: [
          RichText(text: TextSpan(
            children: [
              TextSpan(
                text: 'Total: ',
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'Gilroy-light'
                )
              ),
              TextSpan(
                text: priceTotal.toStringAsFixed(2),
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'Gilroy-ExtraBold'
                )
              ),
            ]
          )),
          SizedBox(height: 15,),
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: gts.map((e) => 
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.indigo,
                      width: 1
                    ),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${e.totalPrice}',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 13,
                          ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Text('${e.menuName}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 13,
                          ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('x${e.quantity}',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: 'Gilroy-ExtraBold',
                            fontSize: 13,
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      );
    }
  }

}