
import 'package:WhereTo/Rider/RiderDetails/riderpi.dart';
import 'package:WhereTo/Rider/RiderDetails/ridrDetailsresonse.dart';

class RiderProviderApi{

  RiderDetailApi riderDetailApi = RiderDetailApi();
  Future<RiderDetailsResponse> madetran(int id){
    return riderDetailApi.details(id);
  }
}