

import 'package:WhereTo/Admin/Get_Sales/get_saleClass.dart';

class GetSaleResponse {

final List<GetSalerepo> getSale;
  final String error;

  GetSaleResponse(this.getSale, this.error);

  GetSaleResponse.fromJson(json)
  : getSale = json,error = "" ;
    

  GetSaleResponse.withError(String errorvalue)
  : getSale = List(),
  error = errorvalue; 


}