import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiCall{
  postData(data ,api) async {
    String  url = 'http://10.0.2.2:8000/api';
    var fullurl = url+api+ await _getToken();
    return http.post(fullurl
    ,
    body: jsonEncode(data),
    headers: _setHeaders()
    );

  }
  getData(api) async{
     String  url = 'http://10.0.2.2:8000/api';
    var fullurl = url + api + await _getToken();
    return await http.get(
      fullurl,
      headers: _setHeaders()
      );
  }

  getRestarant(api) async{
    String url = 'http://10.0.2.2:8000/api';
    var fullurl = url+api;
    return await http.get(
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
