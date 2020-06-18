import 'dart:convert';
import 'package:WhereTo/MenuRestaurant/categ_type.dart';
import 'package:WhereTo/api/api.dart';

class CallCateg{

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

}



// import 'dart:convert';

// import 'package:WhereTo/api/api.dart';
// import 'package:flutter/material.dart';

// import 'categ_type.dart';

// class CategList extends StatefulWidget {
//   @override
//   _CategListState createState() => _CategListState();
// }



// class _CategListState extends State<CategList> with SingleTickerProviderStateMixin{

//   TabController tabs;
  

//   Future<List<TyepCateg>> _categRest() async{

//       var response = await ApiCall().getCategory('/getCategories');

//       List<TyepCateg> categ = [];
//       var body = json.decode(response.body);

//       for(var body in body){

//           TyepCateg mens = TyepCateg(
//             body['id'],
//             body['categoryName'],
//           );
//         categ.add(mens);

//       }
//       print(categ.length);
//       return categ;
//     }

//   @override
//   void initState() {
//     super.initState();

//     _categRest();

//     setState(() {
//         _categRest().then((value) {

//           tabs = TabController(length: value.length, vsync: this);

//         });
//     });

//   }

  


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: FutureBuilder(
//           future: _categRest(),
//           builder: (BuildContext context,AsyncSnapshot snapshot){
//               if(snapshot.data == null){
//                   return Container(
//                     child: Text("Loading..."),
//                   );
//               }else{
//                 return DefaultTabController(
//                   length: snapshot.data.length,
//                    child: Scaffold(
//                      appBar: AppBar(
//                        bottom: TabBar(
//                              controller: tabs,
//                            unselectedLabelColor: Colors.black,
//                            indicator: BoxDecoration(
//                              color: Color(0xFF3936ea),
//                              borderRadius: BorderRadius.only(
//                                topLeft: Radius.circular(20),
//                                topRight: Radius.circular(20),
//                              ),
//                              ),
//                          isScrollable: true,
//                          tabs: snapshot.data.map<Widget>((TyepCateg ty) {
//                               return Container(
//                                 width: 80.0,
//                                 child: Tab(
//                                 text: ty.categoryName,
//                               ),
//                               );
//                          }).toList(),
//                      ),
//                      ), 
//                       body: TabBarView(
//                         children:snapshot.data.map<Widget>((TyepCateg ty) {
//                               return Container(
//                                 width: 80.0,
//                                 child: Tab(
//                                 text: ty.categoryName,
//                               ),
//                               );
//                          }).toList(),),  
                       

                    
                     
//                    ),
                   
//                    );
//               }
//         },
//         ),      
//     );
//   }
// }
