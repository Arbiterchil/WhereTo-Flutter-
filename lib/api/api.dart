import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiCall{

    // final String url = 'http://10.0.2.2:8000/api',https://wheretoapplication.azurewebsites.net/api;
    // final String url = 'http://192.168.1.8:8000/api';
    final String url = 'https://wheretoapplication.azurewebsites.net/api';
    // final String url = 'http://10.0.2.2:8000/api';

  cancelOrder(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }
  newAddress(data,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }
  
  

   getRestaurantSalesReport(data,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  } 

  getTotalRestaurantSalesReport(data,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }  


  changepasssword(data ,api) async {
    var fullurl = url+api+ await _getToken();
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }

  updateMenu(data ,api) async {
    var fullurl = url+api+ await _getToken();
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }

  makeMenuFeatured(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }

  updateRestaurant(data ,api) async {
    var fullurl = url+api+ await _getToken();
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
  }

  makeRestaurantFeatured(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }

  deleteRestaurant(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }

  unSuspendRider(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }
  suspendRider(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }

   getTransactionDetailsById(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
    headers: _setHeaders()
    );
  }   

   getTransactionDetails(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
    headers: _setHeaders()
    );
  }  

   getMenu(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
    headers: _setHeaders()
    );
  } 

   getAllPlayerId(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
    headers: _setHeaders()
    );
  }

  viewUnremittedList(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
    headers: _setHeaders()
    );
  }
  
  getRiderRemit(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
    headers: _setHeaders()
    );
  }

  addRemittanceRecord(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }

  checkRiderIfSuspended(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
    headers: _setHeaders()
    );
  }


    postData(data ,api) async {
    var fullurl = url+api+ await _getToken();
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
    
  }
  postOrder(data ,api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    body: jsonEncode(data),
    headers: _setHeaders()
    );
    
  }
  
  postCancelOrder(api) async {
    var fullurl = url+api+ await _getToken();
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }

   
   updateImageValid(data ,api) async {
    var fullurl = url+api;
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

  
  getCurentUser(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
    headers: _setHeaders()
    );
  }

  getAdminDevice(api) async {
    var fullurl = url+api;
    return http.get(fullurl,
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

  getCheckUser(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
    headers: _setHeaders()
    );
  }
  getUserVerification(api) async {
    var fullurl = url+api;
    return http.post(fullurl,
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
