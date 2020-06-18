

import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';

import 'categ_type.dart';

class CategList extends StatefulWidget {
  @override
  _CategListState createState() => _CategListState();
}



class _CategListState extends State<CategList> with SingleTickerProviderStateMixin{

  TabController tabs;
  

  Future<List<TyepCateg>> _categRest() async{

      var response = await ApiCall().getCategory('/getCategories');

      List<TyepCateg> categ = [];
      var body = json.decode(response.body);

      for(var body in body){

          TyepCateg mens = TyepCateg(
            body['id'],
            body['categoryName'],
          );
        categ.add(mens);

      }
      print(categ.length);
      return categ;
    }

  @override
  void initState() {
    super.initState();

    _categRest();

  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
          future: _categRest(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data == null){
                  return Container(
                    child: Text("Loading..."),
                  );
              }else{
                return DefaultTabController(
                  length: snapshot.data.length,
                   child: TabBar(
                     isScrollable: true,
                     tabs: snapshot.data.map<Widget>((TyepCateg ty) {
                          return Tab(
                            text: ty.categoryName,
                          );
                     }).toList(),
                   ),
                   );
              }
        },
        ),      
    );
  }
}
