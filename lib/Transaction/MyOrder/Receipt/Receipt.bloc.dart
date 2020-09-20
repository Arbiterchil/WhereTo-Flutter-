
import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.class.dart';
import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.service.dart';
import 'package:rxdart/rxdart.dart';


class ReceiptBloc{

PublishSubject<ReceiptClass> _publishSubject =PublishSubject();
Stream<ReceiptClass> get receipt =>_publishSubject.stream;

Stream<ReceiptClass> receiptView(var id) async*{
  // return Stream.fromFuture(ReceiptService.getRecipt());
  yield await ReceiptService.getReceiptOrders(id);
}
ReceiptBloc(var id){
receiptView(id).listen((event) =>_publishSubject.add(event));
}
dispose()=>_publishSubject.close();
}