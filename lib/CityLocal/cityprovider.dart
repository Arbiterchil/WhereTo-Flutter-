import 'package:WhereTo/CityLocal/cityApi.dart';
import 'package:WhereTo/CityLocal/cityresponse.dart';

class Cityprovider{

  CityApi cityApi = CityApi();

  Future<CityResponses> getListCity(){
    return cityApi.cityLocals();
  }

}