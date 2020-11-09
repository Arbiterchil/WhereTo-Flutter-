
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerTransaction.dart';

class GetMenuPertransactionResponse{

  final List<GetMenuPerTransaction> getTran;
  final String error;

  GetMenuPertransactionResponse(this.getTran, this.error);

  GetMenuPertransactionResponse.fromJson(List<dynamic> json)
  : getTran = 
  json.cast<Map<String,dynamic>>()
  .map((e) => new GetMenuPerTransaction.fromJson(e))
  .toList(),
  
  
  error = "";

  GetMenuPertransactionResponse.withError(String errors)
  : getTran = List()
  ,error = errors;

}