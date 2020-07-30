import 'dart:async';

import 'package:WhereTo/Transaction/MyOrder/bloc.provider.dart';
import 'package:WhereTo/Transaction/MyOrder/getMenuPerTransaction.class.dart';
import 'package:WhereTo/api/api.dart';




class BlocAll implements BlocBase{

StreamController<List<MenuOrderTransaction>> streamApi =StreamController.broadcast();
Sink<List<MenuOrderTransaction>> get sinkApi =>streamApi.sink;
Stream<List<MenuOrderTransaction>> get stream =>streamApi.stream;

  Future<void> getMenuTransaction(var id) async{
    final response = await ApiCall().getData('/getMenuPerTransaction/$id');
    final List<MenuOrderTransaction> transaction = menuOrderTransactionFromJson(response.body);
    sinkApi.add(transaction);
  }
  
  @override
  void dispose() {
    streamApi.close();
  }

}