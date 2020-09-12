import 'dart:async';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:rxdart/rxdart.dart';




class BlocAll {



PublishSubject<List<ViewUserOrder>> _publishSubject =PublishSubject();
Stream<List<ViewUserOrder>> get sinkMyOrder =>_publishSubject.stream;
 

    Future<void>getMenuTransaction() async{
    var id =await ID().getId();
    final response = await ApiCall().getData('/viewUserOrders/$id');
    final List<ViewUserOrder> transaction = viewUserOrderFromJson(response.body);
    _publishSubject.sink.add(transaction);
  }
  
 
  void dispose(){
   _publishSubject.close();
    
  }

}