import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiCall{

    // final String url = 'http://10.0.2.2:8000/api';
    final String url = 'http://192.168.1.3:8000/api';
  
    postData(data ,api) async {
    var fullurl = url+api+ await _getToken();
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }

 

  getData(api) async{
    var fullurl = url + api + await _getToken();
    // print(fullurl);
    return await http.get(
      fullurl,
      headers: _setHeaders()
      );
  }

  getRestarant(api) async{
    
    var fullurl = url+api;
    return await http.get(
      fullurl,
      headers: _setHeaders()
    );
  }

  getMenuRestaurant(api) async{
    var fullurl = url+api;
    return await http.get(
      fullurl,
      headers: _setHeaders()
    );
  }
  getCategory(api) async{
    var fullurl = url+api;
    return await http.get(
      fullurl,
      headers: _setHeaders()
    );
  }
  getMenuCategory(api) async{
    var fullurl = url+api;
    return await http.get(
      fullurl,
      headers: _setHeaders()
    );
  }

 viewTransac(api) async {
    var fullurl = url+api;
    return http.get(
    fullurl,
    headers: _setHeaders()
    );
  }

viewMenuTransac(api) async {
    var fullurl = url+api;
    return http.get(
    fullurl,
    headers: _setHeaders()
    );
  }
  
  _setHeaders() => {
  'Content-type' : 'application/json',
        'Accept' : 'application/json',
        
  };

  _getToken() async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var token = localStorage.getString('token');
        return '?token=$token';
    }

}
