import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';
import 'package:WhereTo/Transaction/MyOrder/getMenuPerTransaction.class.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';

class Response{

  final List<GetViewOrders> getview;
  final String error;

  Response(this.getview, this.error);

 Response.fromJson(json)
  : getview = json,error = "" ;
    

  Response.withError(String errorvalue)
  : getview = List(),
  error = errorvalue; 

}