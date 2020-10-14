
import 'package:WhereTo/CityLocal/cityclass.dart';

class CityResponses{

  final List<CityLocals> citys;
  final String error;

  CityResponses(this.citys, this.error);

  CityResponses.fromJson(List<dynamic> json)
  : citys = 
  json.cast<Map<String,dynamic>>()
  .map((e) => new CityLocals.fromJson(e))
  .toList(),
  error ="";

  CityResponses.withError(String val)
  : citys = List<dynamic>()
  ,error = val;

}