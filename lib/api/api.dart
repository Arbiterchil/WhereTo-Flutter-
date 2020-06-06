import 'dart:convert';

import 'package:http/http.dart' as http;


class ApiCall{

  final String  url = 'http://10.0.2.2:8000/api/';

  postData(data ,api) async {

    var fullurl = url+api;
    return http.post(fullurl
    ,
    body: jsonEncode(data),
    headers: _setHeaders()
    );

  }
  getData(api) async{
    var fullurl = url+api;
    return await http.get(
      fullurl,
      headers: _setHeaders()
      );
  }

  _setHeaders() => {
    'Content-type':'application/json',
    'Accept':'application/json'
  };

}
