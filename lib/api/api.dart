import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiCall{

    // final String url = 'http://10.0.2.2:8000/api',https://wheretoapplication.azurewebsites.net/api;
    // final String url = 'http://192.168.1.10:8000/api';
    final String url = 'https://wheretoapplication.azurewebsites.net/api';
    
    postData(data ,api) async {
    var fullurl = url+api+ await _getToken();
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }

   postApproveRemit(data ,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }
   postRemitRider(data ,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }

  getDeviceUserScammer(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
    headers: _setHeaders()
    );
  }

  logVerify(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
    headers: _setHeaders()
    );
  }

  postVerify(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }
   susVerify(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }
  
  getunverified(api) async {
    var fullurl = url+api;
    return http.get(
    fullurl,
    headers: _setHeaders()
    );
  }
  getRemitImage(api) async {
    var fullurl = url+api;
    return http.get(
    fullurl,
    headers: _setHeaders()
    );
  }

  validId(data ,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }

  addRider(data ,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }  

  addRestaurant(data ,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }
  addMenu(data ,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }

  playerIdSave(data ,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }


  transactionBuying(api) async{
    var fullurl = url+api;
    return http.post(
      fullurl,
    headers: _setHeaders()
    );
  }
  transactionDelivery(api) async{
    var fullurl = url+api;
    return http.post(
      fullurl,
    headers: _setHeaders()
    );
  }
  transactionComplete(api) async{
    var fullurl = url+api;
    return http.post(
      fullurl,
    headers: _setHeaders()
    );
  }


  assignRiders(data,api) async{
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }

 

  getData(api) async{
    var fullurl = url + api;
    // print(fullurl);
    return await http.get(
      fullurl,
      headers: _setHeaders()
      );
  }
  getOffline(api) async{
    var fullurl = url + api;
    // print(fullurl);
    return await http.post(
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

  getBararang(api) async {
    var fullurl = url+api;
    return http.get(
    fullurl,
    headers: _setHeaders()
    );
  }

  getComment(api) async {
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
