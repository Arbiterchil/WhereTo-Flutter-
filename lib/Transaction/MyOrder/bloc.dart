import 'dart:async';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/api/api.dart';




class BlocAll {

StreamController<List<GetViewOrders>> streamApi =StreamController.broadcast();
Sink<List<GetViewOrders>> get sinkApi =>streamApi.sink;
Stream<List<GetViewOrders>> get stream =>streamApi.stream;

var id;
StreamSubscription periodicSub;
 

    Future<void>getMenuTransaction(var id) async{
    final response = await ApiCall().getData('/viewCurrentOrders/$id');
    final List<GetViewOrders> transaction = getViewOrdersFromJson(response.body);
    periodicSub = new Stream.periodic(Duration(seconds: 1), (v) =>v).listen((event) {
    sinkApi.add(transaction);
    });

  }
  
 
  void dispose(){
    streamApi.close();
    periodicSub.cancel();
  }

}