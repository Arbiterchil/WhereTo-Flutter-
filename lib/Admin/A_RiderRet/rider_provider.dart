import 'package:WhereTo/Admin/A_RiderRet/riderApi_Rets.dart';
import 'package:WhereTo/Admin/A_RiderRet/rider_responseRet.dart';

class RiderProvider{
  RetriveTransacApi _retriveTransacApi = RetriveTransacApi();
  Future<RetrievResponse> getAllTransAll(){
    return _retriveTransacApi.getTransactionOrder();
  }
}