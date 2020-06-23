import 'dart:convert';
import 'package:WhereTo/MenuRestaurant/categ_type.dart';
import 'package:WhereTo/MenuRestaurant/restaurant_menu_list.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant/model.dart';
import 'package:WhereTo/api_restaurant_bloc/bloc.Restaurant.dart';
import 'package:WhereTo/api_restaurant_bloc/bloc.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:WhereTo/restaurants/restaurant.dart';






class ListStactic extends StatefulWidget {
   final Restaurant restaurant;
   final String nameRestau;
  const ListStactic({Key key, this.restaurant, this.nameRestau}) : super(key: key);
  @override
  _ListStacticState createState() => _ListStacticState();
}
class _ListStacticState extends State<ListStactic> with SingleTickerProviderStateMixin {
  
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

  Future<List<RestaurantMenu>> _menuList(int id) async{
  var response = await ApiCall().getCategory('/getMenuCategory/$id');
  List<RestaurantMenu> restaurant =[];
  var body =json.decode(response.body);
  for(var body in body){
      RestaurantMenu restaurantMenu =RestaurantMenu(
      body['id'], body['restaurantName'], body['menuName'], body['description'], body['price'],
      );
      if(body['restaurantName'].toString().contains(widget.nameRestau)){
        restaurant.add(restaurantMenu);
      }
  }
    print("Restaurant length: ${restaurant.length}");
    return restaurant;
}
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // int getmeouts = widget.restaurant.id;
    


     return Scaffold(
       body: Builder(
         builder: (context){
        return Container(
        child: FutureBuilder(
          future: _categRest(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data == null){
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                        strokeWidth: 3.0,
                        ),
                        ),  
                    ),
                  );
              }else{
                return DefaultTabController(
                  length: snapshot.data.length,
                   child: Scaffold(
                     backgroundColor: Color(0xFF3936ea),
                     appBar: AppBar(
                       backgroundColor: Colors.amber,
                       title: Text( widget.restaurant.restaurantName,
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         color: Colors.black,
                         fontSize: 24.0,
                         fontWeight: FontWeight.bold
                       ),),
                       bottom: TabBar(
                           unselectedLabelColor: Colors.black,
                           indicator: BoxDecoration(
                             color: Color(0xFF3936ea),
                             borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(20),
                               topRight: Radius.circular(20),
                             ),
                             ),
                         isScrollable: true,
                         tabs: snapshot.data.map<Widget>((TyepCateg ty) {
                              return Container(
                                width: 80.0,
                                child: Tab(
                                text: ty.categoryName,
                              ),
                              );
                         }).toList(),
                     ),
                     ), 


                      body: TabBarView(
                        children:snapshot.data.map<Widget>((TyepCateg ty) {
                        
                              return Container(
                              child: FutureBuilder(
                              future: _menuList(ty.id), 
                              builder: (BuildContext context, AsyncSnapshot data){
                                if(data.data==null){
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }else{
                                  return ListView.builder(
                                 itemCount:data.data.length,
                                 itemBuilder: (context, index){
                                   return Padding(padding: EdgeInsets.all(20),
                                   child: InkWell(
                                     onTap: (){
                                       
                                     },
                                     child: Card(
                                       elevation: 15.6,
                                       clipBehavior: Clip.antiAlias,
                                       child: ListTile(
                                         title: Text(data.data[index].menuName),
                                         subtitle:Text(data.data[index].description),
                                         trailing: Text("₱"+" "+data.data[index].price.toString()),
                                       ),
                                     ),
                                   ),
                                   );
                                 });
                                }
                              }),
                              );
                             
                         }).toList(),),  
                   ),
                   );
              }
        },
        ),      
    );
         }
         ),
     );
  }

}