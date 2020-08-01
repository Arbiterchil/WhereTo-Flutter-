import 'dart:async';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/api/api.dart';




class BlocAll {

StreamController<List<GetViewOrders>> streamApi =StreamController.broadcast();
Sink<List<GetViewOrders>> get sinkApi =>streamApi.sink;
Stream<List<GetViewOrders>> get stream =>streamApi.stream;

  Future<void> getMenuTransaction(var id) async{
    final response = await ApiCall().getData('/viewCurrentOrders/$id');
    final List<GetViewOrders> transaction = getViewOrdersFromJson(response.body);
    sinkApi.add(transaction);
  }
  
 
  void dispose() =>streamApi.close();

}