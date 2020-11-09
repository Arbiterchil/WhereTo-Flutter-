import 'package:WhereTo/Admin/Admin_Biew/adminView.dart';

class AdminViewResponses{

  final List<TransactionDetail> adminv ;
  final String error;

  AdminViewResponses(this.adminv, this.error);

  AdminViewResponses.fromJson(Map<String,dynamic> json)

  : adminv = (json['transactionDetails'] as List).map((e) => new TransactionDetail.fromJson(e)).toList()
  , error = "";

  AdminViewResponses.withError(String error) :
   adminv = List(),
   error = error
   ;

}