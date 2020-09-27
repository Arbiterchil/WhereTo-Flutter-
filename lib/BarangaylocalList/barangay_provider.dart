import 'package:WhereTo/BarangaylocalList/barangay_api.dart';
import 'package:WhereTo/BarangaylocalList/barangay_response.dart';

class BarangayProvider{

  BaranggayApi baranggayApi = BaranggayApi();

  Future<BaranggayRespone> getBaararangSaifon(){
    return baranggayApi.bararangHoudi();
  }


}