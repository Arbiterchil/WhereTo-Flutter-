
import 'dart:convert';

import 'package:WhereTo/Rider_ViewMenuTransac/ETry/blocvisery.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/EditMenuRider/MenuforEdit.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerResponse.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerRestaurant.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerTransaCtion.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class SearchTrend extends StatefulWidget {
  @override
  _SearchTrendState createState() => _SearchTrendState();
}

class _SearchTrendState extends State<SearchTrend> {

  @override
  void initState() {
    //oke();
    blocky..init();
    super.initState();
  }
  @override
  void dispose() {
    blocky..dispose();
    super.dispose();
  }

  // Future<ResponseMenuRider> oke() async{
  //   var idSearchcity = UserGetPref().restaurntIdEdit;
  //   var response = await ApiCall().getRestarant('/getMenuPerRestaurant/$idSearchcity');
  //   // List<GetMenuPerRestaurant> vin = getMenuPerRestaurantFromJson(response.body);
  //   // final finals = vin
  //   // .where((element) => 
  //   // element.menuName.toLowerCase().contains("sea")
  //   // || element.menuName.toUpperCase().contains("SEA")
  //   // );
  
  //   Map<String,dynamic> vin = json.decode(response.body);
  //   // List bem = vin.map((e) => 
  //   //  GetMenuPerRestaurant(
  //   //    menuName: e.menuName,
  //   //    totalPrice: e.totalPrice,
  //   //    description: e.description,
  //   //    id: e.id,
  //   //    isFeatured: e.isFeatured
  //   //  )
  //   // )
  //   // .toList();
  //   var oks = vin.map((key, value) => null);
  //   print(ResponseMenuRider.fromJson(bem));
      
  // }

  // List<GetMenuPerRestaurant> van;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Word go Try',
                          suffixIcon: Icon(Icons.search),
                        ),
                        onChanged: (val){
                         
                         blocky.changeQ(val);
                        },
                      ),
                    ),
               
                ),
                SizedBox(height: 40,),
                Container(
                  height: 600,
                  child: StreamBuilder<ResponseMenuRider>(
                    stream: blocky.menuList,
                    builder: (con,AsyncSnapshot<ResponseMenuRider> snapshot){
                      if(snapshot.hasData){
                       return ListView.builder(
                         itemCount: snapshot.data.filter.length,
                         itemBuilder: (_,data){
                            return ListTile(
                          title: Text(snapshot.data.filter[data].menuName),
                        );
                         });
  // if(snapshot.data.error !=null && snapshot.data.error.length > 0){
  //               return _errorTempMessage(snapshot.data.error);
  //           }
  //             return _views(snapshot.data);
                      }else{
                        return Center(
                          child: Text('GG'),
                        );
                      }
                    })
                  
                  ),
              ],
            ),
          )),
    );
  }


  Widget _views(ResponseMenuRider responseMenuRider){
    List<GetMenuPerRestaurant> rest = responseMenuRider.filter;
    if(rest.length == 0){
      return Text("GG Agian");
    }else{
     return ListView.builder(
       itemCount: rest.length,
       itemBuilder: (_,index){
        return ListTile(
        title:Text(rest[index].menuName) ,
      );
     });
    }
  }

  Widget _errorTempMessage(String error){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Comback Later.")
              ],
            ),
          );
}
}