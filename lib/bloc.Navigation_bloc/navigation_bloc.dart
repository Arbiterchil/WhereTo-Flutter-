

// import '../restaurants/restaurant_del.dart';
// import '../modules/editProfileScreen.dart';
// import '../modules/profile.dart';
// import 'package:bloc/bloc.dart';

// enum NavigationEvents {
//   HomepageClickEvent,
//    MyProfileClicked,
//    MyRestaurantBrowse,
//    }

// abstract class NavigationStates{

// }

// class NavigationBloc extends Bloc<NavigationEvents,NavigationStates>{
//   @override
//   NavigationStates get initialState => Profile();
     
     
//   @override
//   Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
//     switch(event){
//         case NavigationEvents.HomepageClickEvent : 
//         yield Profile();
//         break;
//         case NavigationEvents.MyRestaurantBrowse : 
//         yield RestDel();
//         break;  
//         case NavigationEvents.MyProfileClicked : 
//         yield Edit();
//         break; 
//     }
//   }

// }