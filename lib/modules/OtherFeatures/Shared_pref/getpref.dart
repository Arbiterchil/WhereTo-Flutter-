import 'dart:convert';

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

}