

import 'dart:convert';


import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.class.dart';
import 'package:WhereTo/api/api.dart';


class ReceiptService{

Future<ReceiptClass> getReceiptOrders() async{

final res =await ApiCall().getData('/getReceipt/54');
final collection =jsonDecode(res.body);
var json =ReceiptClass.fromJson(collection);
return json;

}
}

