import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserGetPref{

static final UserGetPref _instance = UserGetPref._ctor();
factory UserGetPref(){
  return _instance;
}
UserGetPref._ctor();
SharedPreferences _prefs;
init() async{
  _prefs = await SharedPreferences.getInstance();
}
get getUserDataJson{
  var data =   _prefs.getString('user') ?? '';
  var user = json.decode(data);
  return user;
}
Future setuserJson(String vals){
  return _prefs.setString('user', vals);
}

get getLocationTrial{
  var livin;
  StreamSubscription<Position> positionStream = getPositionStream().listen(
    (Position position) {
         livin = position.latitude;
        print(position == null ? 'Unknown' :
        position.latitude.toString() + ', ' + position.longitude.toString());
        // print('DESOLE  $livin');
    });
    print(positionStream);
    return livin;
}
}