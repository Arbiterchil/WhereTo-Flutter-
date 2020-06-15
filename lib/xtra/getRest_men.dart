
// import 'package:WhereTo/bloc.Navigation_bloc/get_Restaurants.dart';
// import 'package:WhereTo/restaurants/restaurant.dart';
// import 'package:WhereTo/restaurants/restaurant_response.dart';
// import 'package:flutter/material.dart';

// class Restaurantget extends StatefulWidget {
//   @override
//   _RestaurantgetState createState() => _RestaurantgetState();
// }

// class _RestaurantgetState extends State<Restaurantget> {

  
//   @override
//   void initState() {
//     super.initState();
//     resBloc..getRestUp();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<RestaurantResponse>(
//         stream: resBloc.subject.stream,
//         builder: (context,AsyncSnapshot<RestaurantResponse> snapshot){
//           if(snapshot.hasData){
//             if(snapshot.data.error != null && snapshot.data.error.length > 0){
//               return _buildError(snapshot.data.error);
//             }
//                 return _buildRestaurant(snapshot.data);
//           }else if(snapshot.hasError){
//               return _buildError(snapshot.error);
//           }else{
//              return _buildLoad();
//           }
//         });
//     }

//       Widget _buildLoad(){
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: 25.0,
//                   width: 25.0,
//                   child:  CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                     strokeWidth: 4.0,
//                   ),
//                 ),
//               ],
//             ),
//           );
//       }

//       Widget _buildError(String error){
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text("Error :  $error")
//               ],
//             ),
//           );
// }

//       Widget _buildRestaurant(RestaurantResponse data){

//          List<Restaurant> rslist = data.restaurants;   
//         if(rslist.length == 0){
//           return Container(
//             child: Text("no Restaurants"),
//             );   
//         }else{
//           return Container(
//             height: 270.0,
//             padding: EdgeInsets.only(left: 10.0),
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: rslist.length,
//               itemBuilder: (context,index){
//                 return Padding(
//                   padding: EdgeInsets.only(
//                     top:10.0,
//                     bottom: 10.0,
//                     left: 10.0,
//                     right: 19.0
//                   ),
//                   child: Column(
//                     children: <Widget>[
//                       rslist[index].address == null ? 
//                       Container(
//                         width: 120.0,
//                         height: 180.0,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(2.0)),
//                           shape: BoxShape.rectangle
//                         ),
//                         child: Column(
//                               children: <Widget>[

//                               ],
//                         ),
//                       ) :
//                       Container(
//                         width: 120.0,
//                         height: 180.0,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(2.0)),
//                           shape: BoxShape.rectangle,
//                           image: DecorationImage(image: AssetImage("asset/img/png.jpg"),
//                           fit: BoxFit.cover,
//                           ),
                                                    
//                         ),
//                       ),
//                       SizedBox(height: 10.0,),
//                       Container(
//                         width: 100.0,
//                         child: Text(rslist[index].restaurantName,
//                         maxLines: 2,
//                         style: TextStyle(
//                           height: 1.4,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 11.0
//                         ),
//                         ),
//                       ),
//                       SizedBox(height: 5.0,),

//                     ],
//                   ),
//                 );
//               },
//               ),
//           );
//         }
//       }

//     }


 