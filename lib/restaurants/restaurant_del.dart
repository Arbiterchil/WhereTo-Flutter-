// import 'package:WhereTo/Rider_viewTransac/view_Transac.dart';
// import 'package:WhereTo/restaurants/carousel_rest.dart';
// import 'package:WhereTo/restaurants/featured_rest.dart';
// import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
// import '../bloc.Navigation_bloc/navigation_bloc.dart';
// import 'package:flutter/material.dart';





// // class RestDel extends StatefulWidget with NavigationStates{

// //   @override
// // _RestDel createState() => _RestDel();
// // }

// class RestDel extends StatefulWidget{

//   @override
// _RestDel createState() => _RestDel();
// }

// class _RestDel extends State<RestDel>{
  
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       backgroundColor: Color(0xFF398AE5),
//      body: WillPopScope(
//        onWillPop: () async => false,
//        child: Container(
//          height: MediaQuery.of(context).size.height,
//          child: Stack(
//            children: <Widget>[
//                Container(
//                  height: MediaQuery.of(context).size.height,
//                  child: SingleChildScrollView(
//                    physics: AlwaysScrollableScrollPhysics(),
//                    child: Container(
//                             margin: EdgeInsets.only(top:70.0),
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.rectangle,
//                                 // color: Color(0xFF3936ea),
//                                 // color: Colors.white60,
//                             ),
//                             child: Column(
//                               children: <Widget>[
//                                 CarouselSex(),
//                                  SizedBox(height: 8.0),
//                                  Row(
//                                    children: <Widget>[
//                                        Padding(
//                                             padding: const EdgeInsets.only(left: 45 ,),
//                                             child:
//                                              Text("Popular : ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   fontSize: 18.0,
                                  
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'OpenSans',
//                                   color: Colors.white,
//                                 ),
//                                 ), 
//                                           ),
//                                    ],
//                                  ),
                               
//                                  SizedBox(height: 8.0),

//                                 FearturedRestaurant(),

//                                 SizedBox(height: 15.0),
//                                 Row(
//                                    children: <Widget>[
//                                        Padding(
//                                             padding: const EdgeInsets.only(left: 45 ,),
//                                             child:
//                                              Text("More Restaurant : ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'OpenSans',
//                                   color: Colors.white,
//                                 ),
//                                 ), 
//                                           ),
//                                    ],
//                                  ),
//                                  SizedBox(height: 8.0),
//                                   SizedBox(
//                                     height: 200.0,
//                                     width: 350.0,
//                                     child:  ListView(
//                                     children: <Widget>[

//                                     ViewTransacRider(
//                                 image: "asset/img/app.jpg",
//                                 transacId: "",
//                                 name: "",
//                                 address: "National Highway",
//                                 deliveryAddress: "",
//                                 restaurantName: "Jollibee",
//                                     ),
                                    
//                                   ViewTransacRider(
//                                 image: "asset/img/fbmYkDz.jpg",
//                                 transacId: "",
//                                 name: "",
//                                 address: "Rizal Street",
//                                 deliveryAddress: "",
//                                 restaurantName: "McDonald",
//                                     ),
//                                     ViewTransacRider(
//                                 image: "asset/img/mWWsAhL.jpg",
//                                 transacId: "",
//                                 name: "",
//                                 address: "National Highway",
//                                 deliveryAddress: "",
//                                 restaurantName: "Chowking",
//                                     ),      


                             
//                  ],
//                ),
//                                   ),
//                                  Container(

//                       margin: EdgeInsets.only(top:30.0, left: 70, right:70.0, ),
//                       width: 200.0,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.rectangle,
//                       ),
//                       child: MaterialButton(
//                 onPressed: (){},
//                 color: Colors.amber,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//                 child:  GestureDetector(
//                   onTap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context){
//                                           return SearchDepo();
//                                         }));
//                   },
//                   child: Row(
//                                               children: <Widget>[
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(right: 10),
//                                                   child: Icon(
//                                                     Icons.arrow_downward,
//                                                     color: Color(0xFF262AAA),
//                                                   ),
//                                                 ),
                                                
//                                                   Text(
//                                                   'Show More...',
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontSize: 17.0,
//                                                       decoration: TextDecoration.none,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                                   ),
                                                
//                                               ],
//                                             ),
//                 ),
//                 ),
//                     ),
//                                   SizedBox(height: 30.0),
//                                   Text("Alright Reserve in 2020",style: 
//                                   TextStyle(
//                                     fontWeight: FontWeight.normal,
//                                     fontSize: 12.0,
//                                     fontFamily: 'OpenSans',
//                                   color: Colors.white,
//                                   ),),
//                                   SizedBox(height: 10.0),

//                               ],
//                             ),
//                           ),
                          
//                  ),
//                ),
             
//            ],
//          ),
         
//        ),
//      ),
//     );
//   } 
// }


               