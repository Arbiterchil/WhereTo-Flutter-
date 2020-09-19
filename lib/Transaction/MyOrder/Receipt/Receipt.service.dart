

import 'dart:convert';


import 'package:WhereTo/Transaction/MyOrder/Receipt/Receipt.class.dart';
import 'package:WhereTo/api/api.dart';


class ReceiptService{

static Future<List<Receipt>> getRecipt() async{
final res =await ApiCall().getData('/getReceipt/54');
List collection =jsonDecode(res.body);
final Iterable<Receipt> _receipt = collection.map((e) => Receipt.fromJson(e)).toList();
return _receipt;
}


}