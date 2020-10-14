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

Future lat(double lat){
  return _prefs.setDouble('Lats', lat);
}
Future lng(double lng){
  return _prefs.setDouble('Longs',lng);
}

Future cityId(String id){
  return _prefs.setString("citys", id);
}
Future restuaddForAdmin(String id){
  return _prefs.setString("AdminRes", id);
}
Future restuNameExtra(String name){
  return _prefs.setString("restuname", name);
}

get restuNamed{
  var getname = _prefs.getString("restuname");
  return getname;
}

get adminEmergergency{
  var idformAdd = _prefs.getString("AdminRes");
  return idformAdd;
}
get citygetId{
  var city = _prefs.getString("citys");
  return city;
}
get latsdaw{
  var lats = _prefs.getDouble('Lats') ?? '';
  return lats;
}
get lngsdaw{
  var longs = _prefs.getDouble('Longs') ?? '';
  return longs;
}

}