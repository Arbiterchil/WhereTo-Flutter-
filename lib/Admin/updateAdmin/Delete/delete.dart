import 'package:WhereTo/api/api.dart';
import 'package:flutter/cupertino.dart';

class DeleteChose{

  deleteMenuChosen(BuildContext context,int id) async{
    await ApiCall().makeMenuFeatured('/deleteMenu/$id');
    print("delete Success");
    Navigator.pop(context);
  }

  deleteRestuChosen(BuildContext context,int id) async{
    await ApiCall().deleteRestaurant('/deleteRestaurant/$id');
    print("delete Success");
    Navigator.pop(context);
  }

}
final deleteResMen = DeleteChose();