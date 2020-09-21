

import 'package:WhereTo/Admin/Get_Sales/get_saleClass.dart';

class GetSaleResponse {

final List<GetSalerepo> getSale;
  final String error;

  GetSaleResponse(this.getSale, this.error);

  GetSaleResponse.fromJson( List<dynamic>json)
  : getSale = 
  json
  .cast<Map<String,dynamic>>()
  .map((e) => new GetSalerepo.fromJson(e))
  .toList(),error = "" ;
    

  GetSaleResponse.withError(String errorvalue)
  : getSale = List(),
  error = errorvalue; 


}