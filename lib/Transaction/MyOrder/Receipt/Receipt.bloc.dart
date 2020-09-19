

import 'dart:convert';

import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.class.dart';
import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.service.dart';
import 'package:WhereTo/api/api.dart';
import 'package:rxdart/rxdart.dart';



class ReceiptBloc{

PublishSubject<ReceiptClass> _publishSubject =PublishSubject();
Stream<ReceiptClass> get receipt =>_publishSubject.stream;

// Stream<List<ReceiptClass>> get receiptView async*{
//   // return Stream.fromFuture(ReceiptService.getRecipt());
//   yield await ReceiptService.getRecipt();
// }

// ReceiptBloc(){
// receiptView.listen((event) =>_publishSubject.add(event));
// }
Future<void> getReceiptOrders() async{
    ReceiptClass res =await ReceiptService().getReceiptOrders();
    _publishSubject.sink.add(res);
}



dispose()=>_publishSubject.close();
}