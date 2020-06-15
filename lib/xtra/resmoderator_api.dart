
// import 'dart:convert';
// import 'package:WhereTo/api/api.dart';
// import 'package:WhereTo/restaurants/restaurant.dart';
// import 'package:WhereTo/restaurants/restaurant_response.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

// class RestaurantApi {

//  List<Restaurant> _rest = List<Restaurant>();
  
//   Future<RestaurantResponse> getRestaurants() async {
  
//     //  String url = 'http://10.0.2.2:8000/api/getFeaturedRestaurant';
//       try{

//         var response = await ApiCall().getRestarant('/getFeaturedRestaurant');
//         var bods = (json.decode(response.body) as List).map((e) => new Restaurant.fromJson(e)).toList();
//       return RestaurantResponse.fromJson(bods);
       
        

//         // var uri = Uri.https("http://10.0.2.2:8000", "/api/getFeaturedRestaurant",params);
//         // var uis = await http.get(uri,headers: _setHeaders());
//         // return RestaurantResponse.fromJson(json.decode(uis.body));
   
//       }catch(error,stacktrace){
//           print("Error Occurence. $error and $stacktrace" );
//           return RestaurantResponse.withError("$error");
//       }
//   }



// }

