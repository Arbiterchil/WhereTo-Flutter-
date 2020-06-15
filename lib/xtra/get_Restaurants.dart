

// import 'package:WhereTo/restaurants/resmoderator_api.dart';
// import 'package:WhereTo/restaurants/restaurant_response.dart';
// import 'package:rxdart/rxdart.dart';

// class RestaurantListBloc {

//   final RestaurantApi _api = RestaurantApi();
//   final BehaviorSubject<RestaurantResponse> _subject = BehaviorSubject<RestaurantResponse>();

//   getRestUp() async{
//     RestaurantResponse restaurantResponse = await _api.getRestaurants();
//     _subject.sink.add(restaurantResponse);
//   }

//   dispose(){
//     _subject.close();
//   }

//   BehaviorSubject<RestaurantResponse> get subject => _subject;
// }

// final resBloc  = RestaurantListBloc();