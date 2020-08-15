import 'dart:convert';
// import 'package:geodesy/geodesy.dart';
import 'package:WhereTo/Transaction/Barangay/Barangay.class.dart';
import 'package:WhereTo/Transaction/button_deisngtransac.dart';
import 'package:WhereTo/Transaction/getDeviceID/getDeviceID.class.dart';
import 'package:WhereTo/Transaction/payload.dart';
import 'package:WhereTo/Transaction/sorties.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:WhereTo/styletext.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TransactionList extends StatefulWidget {
  final String barangay;
  final String restauID;
  TransactionList({this.restauID, this.barangay});
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  String lat;
  String long;
  List<dynamic> summary = [];
  String displaytotal;
  @override
  void setState(fn) async{
    
    super.setState(fn);
    
    
  }


      
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              // Navigator.pop(context);
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF0C375B),
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "My Cart",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF0C375B),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Gilroy-light'),
                ),
              ),
            ),
            Align(
              // Navigator.pop(context);
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => BlocProvider.of<OrderBloc>(context)
                      .add(Computation.deleteAll()),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF0C375B),
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: DesignButton(
            //     height: 55,
            //     width: 55,
            //     color: Color(0xFF398AE5),
            //     offblackBlue: Offset(-4, -4),
            //     offsetBlue: Offset(4, 4),
            //     blurlevel: 4.0,
            //     icon: Icons.clear,
            //     iconSize: 30.0,
            //     onTap: () {
                  
            //     },
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: 56),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: BlocConsumer<OrderBloc, List<TransactionOrders>>(
                    buildWhen: (List<TransactionOrders> previous,
                        List<TransactionOrders> current) {
                  return true;
                }, listenWhen: (List<TransactionOrders> previous,
                        List<TransactionOrders> current) {
                  if (current.length > previous.length) {
                    return true;
                  }
                  return false;
                }, builder: (context, snapshot) {
                  return Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 50),
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(15),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                        child: Container(
                                          height: 120,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF2F2F2),
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 4.4,
                               blurRadius: 4.4
                             ),
                           ],
                                          ),
                                          child: InkWell(
                                            onLongPress: () {
                                              BlocProvider.of<OrderBloc>(
                                                      context)
                                                  .add(Computation.delete(
                                                      index));
                                            },
                                            child: Stack(
                                              children: <Widget>[
                                                   Align(
                                                      alignment: Alignment.bottomLeft,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 5,bottom: 20,left: 5),
                                                        child: Container(
                                                          height: 40,
                                                          width: 100,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: 20 / 4,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Color(0xFF0C375B),
                                                              borderRadius: BorderRadius.all(Radius.circular(30)
                                                                  )),
                                                          
                                                            child: Center(
                                                              child: Text(
                                                                "₱ " +
                                                                    snapshot[index]
                                                                        .price
                                                                        .toString()+".00",
                                                                style: GoogleFonts.roboto(
                                                                    color:Colors.white,
                                                                    letterSpacing:
                                                                        1,
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                            ),
                                                              ),
                                                            ),
                                                          
                                                        ),
                                                      ),
                                                    ),
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    
                                                      child:Container(
                                                            width: 120,
                                                            height: MediaQuery.of(context).size.width,
 
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              bottomRight: Radius.circular(20)
                                                              ,
                                                              topRight: Radius.circular(20)
                                                            ),
                                                            image: DecorationImage(
                                                              image: AssetImage("asset/img/noodles.jpg"),
                                                              fit: BoxFit.cover)
                  
                                                                  )),
                                                          
                                                          
                                                      ),
                                                  ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10, left: 7),
                                                      child: Text(snapshot[index].name,
                                                        style: TextStyle(
                                                          color: Color(0xFF0C375B),
                                                          fontSize: 15,
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 8, left: 7),
                                                      child: Text(
                                                        snapshot[index]
                                                            .description,
                                                        style: TextStyle(
                                                          color: Color(0xFF0C375B),
                                                          fontSize: 12,
                                                          letterSpacing: 1,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                   
                                                  ],
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 90,
                                                        left: 170),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          
                                                              Container(
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  InkWell(
                                                                    onTap: () {
                                                                      if (snapshot[index]
                                                                              .quantity >
                                                                          1) {
                                                                        setState(
                                                                            () {
                                                                          snapshot[index].quantity =
                                                                              snapshot[index].quantity - 1;
                                                                          print(
                                                                              ' ${snapshot[index].id.toString()} ${snapshot[index].quantity.toString()}');
                                                                        });
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: 30,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            25,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 30,
                                                                    child: Center(
                                                                        child: Text(
                                                                      snapshot[
                                                                              index]
                                                                          .quantity
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.white),
                                                                    )),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        snapshot[index]
                                                                            .quantity = snapshot[index]
                                                                                .quantity +
                                                                            1;
                                                                        print(
                                                                            ' ${snapshot[index].id.toString()} ${snapshot[index].quantity.toString()}');
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              5),
                                                                      width: 30,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            25,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                        
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                                child: Container(
                                height: 55,
                                width: double.infinity,
                                child: GestureDetector(
                                  onTap: (){
                                  showCupertinoModalBottomSheet(
                                    elevation: 10.5,
                                    backgroundColor: Colors.grey[300],
                                    context: context, builder: (context, scrollController){
                                        return Container(
                                          height: MediaQuery.of(context).size.height /2 -60,
                                            child: SingleChildScrollView(
                                              physics: AlwaysScrollableScrollPhysics(),
                                              child: Column(
                                                textDirection: TextDirection.ltr,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                                                    child: Container(
                                                      height: 150.0,
                                                      width: MediaQuery.of(context).size.width,
                                                      decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey[500],
                                                          offset: Offset(4.0, 4.0),
                                                          blurRadius: 15.0,
                                                          spreadRadius: 1.0

                                                        ),
                                                        BoxShadow(
                                                          color: Colors.white,
                                                          offset: Offset(-4.0, -4.0),
                                                          blurRadius: 15.0,
                                                          spreadRadius: 1.0
                                                        )
                                                      ],  
                                                      ),
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Padding(padding: EdgeInsets.all(15),
                                                            child: Builder(
                                                              builder: (context){
                                                                  Map<String, dynamic> string;
                                                                  Map<String, int> converted ={};
                                                                  List<dynamic> order =[];
                                                                  List<dynamic> result= [];
                                                                  var name;
                                                                  var quantity;
                                                                  snapshot.forEach((element) {
                                                                    
                                                                    name =element.name;
                                                                    quantity =element.quantity;

                                                                    string ={
                                                                      "name": '$name',
                                                                      "quantity": '$quantity'
                                                                    };

                                                                    order.add(string);  
                                                                   
                                                                  });
                                                                  for(int z=0;z<order.length;z++){
                                                                    var item =order[z];
                                                                    if(converted.containsKey(item['name'])){
                                                                      converted[item['name']] +=int.parse(item['quantity']);
                                                                    }else{
                                                                      converted[item['name']] =int.parse(item['quantity']);
                                                                    }
                                                                  }
                                                                  converted.forEach((key, value) {
                                                                    result.add({
                                                                      "name": key,
                                                                      "quantity": value
                                                                    });
                                                                  });
                                                                return ListView.builder(
                                                                itemCount:result.length,
                                                                itemBuilder: (context, index){
                                                                  return Center(
                                                                  child:Container(
                                                                  child: Text("${result[index]['name']} x${result[index]['quantity']}", style: TextStyle(
                                                                    fontSize: 15,
                                                                    color: fCD,
                                                                    decoration: TextDecoration.none,
                                                                    fontWeight: FontWeight.w500
                                                                  ),),
                                                                ),
                                                                );
                                                                   
                                                                }
                                                                );
                                                              },
                                                                
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    ),
                                                  
                                                   Stack(
                                                     fit: StackFit.passthrough,
                                                     children: [
                                                       Padding(
                                                    padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                                                    child: Container(
                                                      height: 55.0,
                                                      width: MediaQuery.of(context).size.width,
                                                      decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey[500],
                                                          offset: Offset(4.0, 4.0),
                                                          blurRadius: 15.0,
                                                          spreadRadius: 1.0

                                                        ),
                                                        BoxShadow(
                                                          color: Colors.white,
                                                          offset: Offset(-4.0, -4.0),
                                                          blurRadius: 15.0,
                                                          spreadRadius: 1.0
                                                        )
                                                      ],  
                                                      ),
                                                      child: BlocConsumer<
                                                              OrderBloc,
                                                              List<
                                                                  TransactionOrders>>(
                                                            builder: (context,
                                                                datasnapshot) {
                                                              int total = 0;
                                                              for (int z = 0;
                                                                  z <
                                                                      datasnapshot
                                                                          .length;
                                                                  z++) {
                                                                total += snapshot[z]
                                                                        .price *
                                                                    snapshot[z]
                                                                        .quantity;
                                                              }
                                                              return Center(
                                                                  child: Text(
                                                                "Sub Total: $total",
                                                                style: GoogleFonts.archivo(
                                                                  decoration: TextDecoration.none,
                                                                    color: fCD,
                                                                    
                                                                    letterSpacing:
                                                                        2,
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              );
                                                            },
                                                            listener: (BuildContext
                                                                    context,
                                                                order) {
                                                              // Scaffold.of(context).showSnackBar(
                                                              // SnackBar(content: Text("Order Remove")));
                                                            },
                                                          ),

                                                    ),
                                                    ),
                                                    
                                                     ],
                                                   ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(25),
                                                    child: Align(
                                                      alignment: Alignment.bottomCenter,
                                                      child: Container(
                                                          height: 55,
                                                          width: 190,
                                                          decoration: BoxDecoration(
                                                            color: Color(0xFF0C375B),
                                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                                          ),
                                                          child: GestureDetector(
                                                            onTap: ()async{
                                                            if(snapshot.length ==0){
                                                            print("No Order");
                                                             
                                                            }else{
                                                               // Geodesy geodesy = Geodesy();
                                                            // Position _currentPosition;
                                                            // final point =LatLng(7.4281587, 125.8067275);
                                                            // final c =<LatLng>[];
                                                            // final destination = geodesy.pointsInRange(point, c, 100);
                                                            // print("Points: ${destination} ${destination}");
                                                            var location =Location();
                                                            var userLocation =await location.getLocation();
                                                            var id;
                                                            var quantity;
                                                            var restoCharge;
                                                            var userCharge;
                                                            var totalOrder;
                                                            Map<String, dynamic> string;
                                                            Map<String, dynamic> post;
                                                            Map<String, int> converted = {};
                                                            List<dynamic> order = [];
                                                            List<dynamic> result = [];
                                                            SharedPreferences localStorage =await SharedPreferences.getInstance();
                                                            var userJson = localStorage.getString('user');
                                                            var user =json.decode(userJson);
                                                            final barangay =await ApiCall().getData('/getBarangayList');
                                                            List<BarangayList> barangayResponse =barangayListFromJson(barangay.body);
                                                            String barangayname;
                                                            var istrue =false;
                                                            for(int z=0;z<barangayResponse.length;z++){
                                                              if(barangayResponse[z].id.toString().contains(user['barangayId'])){
                                                                 barangayname =barangayResponse[z].barangayName;
                                                                 istrue =true;
                                                                 break; 
                                                              }
                                                            }
                                                            if(istrue){
                                                                if(widget.barangay.isNotEmpty){
                                                                if(widget.barangay.contains("Magugpo")){
                                                                 setState(() {
                                                                   restoCharge =40;
                                                                 });
                                                               }else if(widget.barangay.contains("Apokon") ){
                                                                 setState(() {
                                                                   restoCharge =15;
                                                                   
                                                                 });
                                                               }else if(widget.barangay.contains("Bingcungan")){
                                                                 setState(() {
                                                                   restoCharge =20;
                                                                 });
                                                               }else if(widget.barangay.contains("Busaon")){
                                                                 setState(() {
                                                                   restoCharge =50;
                                                                 });
                                                               }else if(widget.barangay.contains("Canocotan")){
                                                                 setState(() {
                                                                   restoCharge =15;
                                                                 });
                                                               }else if(widget.barangay.contains("La Filipina")){
                                                                 setState(() {
                                                                   restoCharge =10;
                                                                 });
                                                               }else if(widget.barangay.contains("Liboganon")){
                                                                 setState(() {
                                                                   restoCharge =50;
                                                                 });
                                                               }else if(widget.barangay.contains("Madaum")){
                                                                 setState(() {
                                                                   restoCharge =30;
                                                                 });
                                                               }else if(widget.barangay.contains("Magdum")){
                                                                 setState(() {
                                                                   restoCharge =10;
                                                                 });
                                                               }else if(widget.barangay.contains("Mankilam")){
                                                                 setState(() {
                                                                   restoCharge =15;
                                                                 });
                                                               }else if(widget.barangay.contains("New Balamban")){
                                                                 setState(() {
                                                                   restoCharge =30;
                                                                 });
                                                               }else if(widget.barangay.contains("Nueva Fuerza")){
                                                                 setState(() {
                                                                   restoCharge =40;
                                                                 });
                                                               }else if(widget.barangay.contains("Pagsabangan")){
                                                                 setState(() {
                                                                   restoCharge =25;
                                                                 });
                                                               }else if(widget.barangay.contains("Pandapan")){
                                                                 setState(() {
                                                                   restoCharge =45;
                                                                 });
                                                               }else if(widget.barangay.contains("San Agustin")){
                                                                 setState(() {
                                                                   restoCharge =45;
                                                                 });
                                                               }else if(widget.barangay.contains("San Isidro")){
                                                                 setState(() {
                                                                   restoCharge =20;
                                                                 });
                                                               }else if(widget.barangay.contains("San Miguel")){
                                                                 setState(() {
                                                                   restoCharge =15;
                                                                 });
                                                               }else if(widget.barangay.contains("Visayan")){
                                                                 setState(() {
                                                                   restoCharge =20;
                                                                 });
                                                               }
                                                              }if(barangayname.isNotEmpty){
                                                                if(barangayname.contains("Magugpo")){
                                                                 setState(() {
                                                                   userCharge =40;
                                                                 });
                                                               }else if(barangayname.contains("Apokon") ){
                                                                 setState(() {
                                                                   userCharge =15;
                                                                   
                                                                 });
                                                               }else if(barangayname.contains("Bingcungan")){
                                                                 setState(() {
                                                                   userCharge =20;
                                                                 });
                                                               }else if(barangayname.contains("Busaon")){
                                                                 setState(() {
                                                                   userCharge =50;
                                                                 });
                                                               }else if(barangayname.contains("Canocotan")){
                                                                 setState(() {
                                                                   userCharge =15;
                                                                 });
                                                               }else if(barangayname.contains("La Filipina")){
                                                                 setState(() {
                                                                   userCharge =10;
                                                                 });
                                                               }else if(barangayname.contains("Liboganon")){
                                                                 setState(() {
                                                                   userCharge =50;
                                                                 });
                                                               }else if(barangayname.contains("Madaum")){
                                                                 setState(() {
                                                                   userCharge =30;
                                                                 });
                                                               }else if(barangayname.contains("Magdum")){
                                                                 setState(() {
                                                                   userCharge =10;
                                                                 });
                                                               }else if(barangayname.contains("Mankilam")){
                                                                 setState(() {
                                                                   userCharge =15;
                                                                 });
                                                               }else if(barangayname.contains("New Balamban")){
                                                                 setState(() {
                                                                   userCharge =30;
                                                                 });
                                                               }else if(barangayname.contains("Nueva Fuerza")){
                                                                 setState(() {
                                                                   userCharge =40;
                                                                 });
                                                               }else if(barangayname.contains("Pagsabangan")){
                                                                 setState(() {
                                                                   userCharge=25;
                                                                 });
                                                               }else if(barangayname.contains("Pandapan")){
                                                                 setState(() {
                                                                   userCharge =45;
                                                                 });
                                                               }else if(barangayname.contains("San Agustin")){
                                                                 setState(() {
                                                                   userCharge =45;
                                                                 });
                                                               }else if(barangayname.contains("San Isidro")){
                                                                 setState(() {
                                                                   userCharge =20;
                                                                 });
                                                               }else if(barangayname.contains("San Miguel")){
                                                                 setState(() {
                                                                   userCharge =15;
                                                                 });
                                                               }else if(barangayname.contains("Visayan")){
                                                                 setState(() {
                                                                   userCharge =20;
                                                                 });
                                                               }
                                                              }
                                                            }
                                                            if(widget.barangay.contains("Magugpo") && barangayname.contains("Magugpo")){
                                                              totalOrder =40;
                                                            }else if(widget.barangay.contains("Magugpo") && barangayname !="Magugpo"){
                                                              totalOrder =restoCharge +userCharge;
                                                            }else if(widget.barangay!="Magugpo" && barangayname !="Magugpo"){
                                                              totalOrder =40 +restoCharge +userCharge;
                                                              setState(() {
                                                                displaytotal =totalOrder;
                                                              });
                                                            }
                                                            print("total: $totalOrder");
                                                            snapshot
                                                                .forEach((element) async {
                                                              setState(() {
                                                                id = element.id;
                                                                quantity = element.quantity;
                                                                
                                                                string = {
                                                                  'menuId': '$id',
                                                                  'quantity': '$quantity',
                                                                };
                                                                order.add(string);
                                                              });
                                                            });
                                                            for (int z = 0;
                                                                z < order.length;
                                                                z++) {
                                                              var item = order[z];
                                                              if (converted.containsKey(item['menuId'])) {
                                                                converted[item['menuId']] +=int.parse(item['quantity']);
                                                              } else {
                                                                converted[item['menuId']] =
                                                                    int.parse(
                                                                        item['quantity']);
                                                              }
                                                            }
                                                            converted.forEach((key, value) {
                                                              result.add({
                                                                "menuId": key,
                                                                "quantity": value
                                                              });
                                                            });
                                                            
                                                            print(result);
                                                            setState(() {
                                                              post = {
                                                                'userId': user['id'],
                                                                'restaurantId':this.widget.restauID,
                                                                'order': result,
                                                                "deliveryAddress": "${userLocation.latitude},${userLocation.longitude}",
                                                                "deliveryCharge":totalOrder
                                                              };
                                                              // print(post);
                                                            });
                                                          
                                                          // var res = await ApiCall().postData(post, '/putOrder');
                                                          // if (res.statusCode == 200) {
                                                          //   var data = json.decode(res.body);
                                                          //   setState(() {
                                                          //      transactID =data; 
                                                          //   });
                                                          //   print(data);
                                                          //   print("Success");
                                                          
                                                          // }
                                                          // final response =await ApiCall().getData('/getAllPlayerId');
                                                          // List<GetPlayerId> search =getPlayerIdFromJson(response.body);
                                                          // List<dynamic> player =[];
                                                          // search.forEach((element) {
                                                          //   player.add(element.deviceId);
                                                          //   print(element.deviceId);
                                                          // });
                                                          // await OneSignal.shared.setLocationShared(true);
                                                          // await OneSignal.shared.promptLocationPermission();
                                                          // await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');
                                                          // OneSignal.shared
                                                          //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
                                                          // OneSignal.shared
                                                          //     .setNotificationReceivedHandler((OSNotification notification) {
                                                          
                                                          
                                                          // });

                                                          // await OneSignal.shared.setSubscription(true);
                                                          // await OneSignal.shared.getTags();
                                                          // var status = await OneSignal.shared.getPermissionSubscriptionState();
                                                          
                                                          // String url = 'https://onesignal.com/api/v1/notifications';
                                                          // var playerId = status.subscriptionStatus.userId;
                                                          // var contents = {
                                                          //   "include_player_ids": player,
                                                          //   "include_segments": ["All"],
                                                          //   "excluded_segments": [],
                                                          //   "contents": {"en": "FuCK you driver!"},
                                                          //   "data": {
                                                          //     "id": user['id'].toString(),
                                                          //     "player_id": playerId.toString(),
                                                          //     "transact_id": transactID.toString(),
                                                          //   },
                                                          //   "headings": {"en": "New Order"},
                                                          //   "filter": [
                                                          //     {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
                                                          //   ],
                                                          //   "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
                                                          // };
                                                          // Map<String, String> headers = {
                                                          //   'Content-Type': 'application/json',
                                                          //   'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
                                                          // };
                                                          
                                                          // await http.post(url, headers: headers, body: json.encode(contents));
                                                          // print(playerId);
                                                          // print(tags);
                                                          // print(repo);
                                                          
                                                          
                                                            }
                                                          },
                                                            child: Center(
                                                              child: Text("Place Order",
                                                               style: TextStyle(
                                                                  color: Colors.white,
                                                          fontSize: 15.0,
                                                          fontFamily: 'Gilroy-light'
                                                               ),
                                                              ),
                                                            ),
                                                          )



                                                      ),
                                                    ),),
                                                 
                                                ],
                                              ),
                                            ),
                                          
                                        );
                                    });
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 190,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0C375B),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: Text(
                                  "View Place Orders ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-light'
                                      ),
                                ),
                                    ),
                                  ),
                                ),
                                
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(top: 13, left: 30),
                            //   child: Container(
                            //     child: Text(
                            //       "View Place Orders ",
                            //       style: TextStyle(
                            //           fontSize: 25,
                            //           fontWeight: FontWeight.w400,
                            //           color: Colors.white,
                            //           fontFamily: 'Gilroy-light'
                            //           ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  );
                }, listener: (BuildContext context, orderList) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Order Remove")),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // sentNotif(String restoStreet) async {
  //   await OneSignal.shared.setLocationShared(true);
  //   await OneSignal.shared.promptLocationPermission();

  //   await OneSignal.shared.init('2348f522-f77b-4be6-8eae-7c634e4b96b2');

  //   OneSignal.shared
  //       .setInFocusDisplayType(OSNotificationDisplayType.notification);
  //   await OneSignal.shared.setSubscription(true);

  //   var tags = await OneSignal.shared.getTags();
  //   print(tags);
  //   await OneSignal.shared.deleteTags(["Penongs Quirante II", "TRUE"]);
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();
  //   String url = 'https://onesignal.com/api/v1/notifications';
  //   var playerId = status.subscriptionStatus.userId;

  //   await OneSignal.shared.sendTags({"$restoStreet": "TRUE"});
  //   var contents = {
  //     "include_player_ids": [playerId],
  //     "include_segments": ["Penongs Quirante II"],
  //     "excluded_segments": [],
  //     "contents": {"en": "New Order"},
  //     "headings": {"en": "Penongs Building Quirante II"},
  //     // "data":{"test":userData["name"]},
  //     "filter": [
  //       {
  //         "field": "tag",
  //         "key": "$restoStreet",
  //         "relation": "=",
  //         "value": "TRUE"
  //       },
  //     ],
  //     "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
  //   };
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
  //   };
  //   var repo =
  //       await http.post(url, headers: headers, body: json.encode(contents));
  //   print(repo.body);
  // }
}






