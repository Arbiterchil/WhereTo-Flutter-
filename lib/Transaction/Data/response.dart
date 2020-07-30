import 'package:WhereTo/Transaction/MyOrder/getMenuPerTransaction.class.dart';

class Response{

  final List<MenuOrderTransaction> getview;
  final String error;

  Response(this.getview, this.error);

 Response.fromJson(json)
  : getview = json,error = "" ;
    

  Response.withError(String errorvalue)
  : getview = List(),
  error = errorvalue; 

}