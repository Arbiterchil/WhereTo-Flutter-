

import 'dart:convert';
import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.class.dart';
import 'package:WhereTo/api/api.dart';


class ReceiptService{

static Future<ReceiptClass> getReceiptOrders(var id) async{

final res =await ApiCall().getData('/getReceipt/$id');
final collection =jsonDecode(res.body);
var json =ReceiptClass.fromJson(collection);
return json;

}
}

