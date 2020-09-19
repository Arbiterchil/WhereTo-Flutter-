

import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.class.dart';
import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.service.dart';
import 'package:rxdart/rxdart.dart';



class ReceiptBloc{
PublishSubject<List<Receipt>> _publishSubject =PublishSubject();
Stream<List<Receipt>> get receipt =>_publishSubject.stream;

ReceiptBloc(){
  receiptView;
}

Stream get receiptView async*{
  yield await ReceiptService.getRecipt();
}


 
dispose() =>_publishSubject.close();
}