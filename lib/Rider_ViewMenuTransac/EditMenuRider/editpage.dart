
import 'package:WhereTo/Rider_ViewMenuTransac/EditMenuRider/appStateProv.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/EditMenuRider/editBloc.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/EditMenuRider/forEdit.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerStream.dart';
import 'package:flutter/material.dart';

class EditPageMenuTrial extends StatefulWidget {
  @override
  _EditPageMenuTrialState createState() => _EditPageMenuTrialState();
}

class _EditPageMenuTrialState extends State<EditPageMenuTrial> {

  @override
  Widget build(BuildContext context) {
    
    return AppState(
      data: AppStateData(
        editMenuBloc: EditMenuBloc(),),
        child: ForEditTrial(),
    );
  }
}