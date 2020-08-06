import 'dart:async';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/api/api.dart';




class BlocAll {

StreamController<List<ViewUserOrder>> streamApi =StreamController.broadcast();
Sink<List<ViewUserOrder>> get sinkApi =>streamApi.sink;
Stream<List<ViewUserOrder>> get stream =>streamApi.stream;

var id;
StreamSubscription periodicSub;
 

    Future<void>getMenuTransaction(var id) async{
    final response = await ApiCall().getData('/viewUserOrders/$id');
    final List<ViewUserOrder> transaction = viewUserOrderFromJson(response.body);
    sinkApi.add(transaction);
  }
  
 
  void dispose(){
    streamApi.close();
    periodicSub.cancel();
  }

}