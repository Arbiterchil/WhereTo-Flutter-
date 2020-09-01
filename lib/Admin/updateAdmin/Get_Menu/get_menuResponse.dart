
import 'package:WhereTo/Admin/updateAdmin/Get_Menu/get_menus.dart';

class MenuGetResponse {



  final MenuGet menuget;
  final String error;


  MenuGetResponse(this.menuget, this.error);

 MenuGetResponse.fromJson(json)
  : menuget = MenuGet.fromJson(json),error = "" ;
    

  MenuGetResponse.withError(String errorvalue)
  : menuget = MenuGet(),
  error = errorvalue; 



}