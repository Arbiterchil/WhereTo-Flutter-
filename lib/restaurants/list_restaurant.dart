
import 'dart:convert';

import 'package:WhereTo/MenuRestaurant/categ_type.dart';
import 'package:WhereTo/MenuRestaurant/restaurant_menu_list.dart';
import 'package:WhereTo/Transaction/myOrders.dart';
import 'package:WhereTo/Transaction/mycart.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:WhereTo/restaurants/card_menu.dart';
import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ListStactic extends StatefulWidget {
  final String nameRestau;
  final String restauID;
  const ListStactic({Key key, this.nameRestau, this.restauID}) : super(key: key);
  @override
  _ListStacticState createState() => _ListStacticState();
}

class _ListStacticState extends State<ListStactic>
    with SingleTickerProviderStateMixin {


  Future<List<TyepCateg>> _categRest() async {
    final response = await ApiCall().getCategory('/getCategories');
    final List<TyepCateg> category = tyepCategFromJson(response.body);
    return category;
  }
  Future<List<RestaurantMenu>> _menuList(int id, String menuName) async {
    final response = await ApiCall().getCategory('/getMenuCategory/$id');
    final List<RestaurantMenu> restList = restaurantMenuFromJson(response.body);
    final query = restList
        .where((element) =>
            element.restaurantName.contains(widget.nameRestau) &&
            element.menuName.contains(menuName))
        .toList();
    return query;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Container(
          child: FutureBuilder(
            future: _categRest(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
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
              } else {
                return DefaultTabController(
                  length: snapshot.data.length,
                  child: Scaffold(
                    backgroundColor: Colors.white10,
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(130.0),
                      child: AppBar(                    
                        actions: <Widget>[
                          Container(
                            child:
                              BlocConsumer<OrderBloc, List<TransactionOrders>>(
                              builder: (context, snapshot) {
                                return Badge(
                                  badgeContent: Text(snapshot.length.toString()),
                                  badgeColor: Colors.white,
                                  borderRadius: 20,
                                  position: BadgePosition.topLeft(),
                                  child: Container(
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MyCart(
                                                        restauID: widget.restauID,
                                                        nameRestau:widget.nameRestau,
                                                      )));
                                        }),
                                  ),
                                );
                              },
                              listener: (BuildContext context, order) {
                                 
                                  },
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              onPressed: () async{
                                SharedPreferences local =await SharedPreferences.getInstance();
                                var userjson =local.getString('user');
                                var user =json.decode(userjson);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyOrder(id: user['id'].toString())));
                                                }),
                                              ],
                      // backgroundColor: Colors.amber,
                      backgroundColor: Color(0xFF0C375B),
                      leading: IconButton(
                      icon: Icon(
                      Icons.arrow_back_ios,
                      ),
                      onPressed: () {
                                                                     Navigator.push(context, MaterialPageRoute(
                                                                    builder: (context) => SearchDepo()));
                      // Navigator.pop(context);
                      BlocProvider.of<OrderBloc>(context).add(Computation.deleteAll());
                      }),
                                                                  
                      title: Text(
                      widget.nameRestau,
                      
                      textAlign: TextAlign.center,
                      
                      style: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.white,
                      fontSize: 24.0,
                       fontWeight: FontWeight.bold,
                       fontFamily: 'Brandon_Grotesque'),
                      ),
                      bottom: TabBar(
                                                                unselectedLabelColor: Colors.amber,
                                                                indicator: BoxDecoration(
                                                                  color: Color(0xFF176DB5),
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
                                                      ),
                                                          body: Builder(builder: (context) {
                                                            return TabBarView(
                                                              children: snapshot.data.map<Widget>((TyepCateg ty) {
                                                                return Container(
                                                                  child: FutureBuilder<List<RestaurantMenu>>(
                                                                      future: _menuList(ty.id, ty.categoryName),
                                                                      builder: (context, data) {
                                                                       
                                                                        if(data.hasData){
                                                                          if(data.data.length >0){
                                                                            return ListView.builder(
                                                                              itemCount: data.data.length,
                                                                              itemBuilder: (context, index) {
                                                                                if(data.data.length >0){
                                                                                  return Padding(
                                                                                  padding: EdgeInsets.all(15),
                                                                                    child: MenuBoxRestaurant(
                                                                                      menuName:data.data[index].menuName ,
                                                                                      menuDescription: data.data[index].description,
                                                                                      fixprice:  "₱" +data.data[index].price.toString(),
                                                                                      hugs:"Best Seller" , 
                                                                                           
                                                                                      onTap: (){
                                                                                         BlocProvider.of<
                                                                                                          OrderBloc>(
                                                                                                      context)
                                                                                                  .add(
                                                                                                Computation.add(
                                                                                                  TransactionOrders(
                                                                                                      name: data
                                                                                                          .data[index]
                                                                                                          .menuName,
                                                                                                      description: data
                                                                                                          .data[index]
                                                                                                          .description,
                                                                                                      price: data
                                                                                                          .data[index]
                                                                                                          .price,
                                                                                                      quantity: 1,
                                                                                                      id: data
                                                                                                          .data[index]
                                                                                                          .id,
                                                                                                       
                                                                                                      ),
                                                                                                ),
                                                                                              );
                      
                                                                                      },
                                                                                    )



                                                                         
                                                                                );
                                                                                }else{
                                                                                  return Container();
                                                                                }
                                                                              });
                                                                          }else{
                                                                            return Center(
                                                                            child: Container()
                                                                          );
                                                                          }
                                                                        }else{
                                                                          return Center(
                                                                            child: CircularProgressIndicator(),
                                                                          );
                                                                        }
                                                                      }),
                                                                );
                                                              }).toList(),
                                                            );
                                                          }),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              );
                                            }),
                                          );
                                        }
                                      
                                      
}
//  Card(
//                                                                                       color: Colors.white70,
//                                                                                       elevation: 15.6,
//                                                                                       clipBehavior: Clip.antiAlias,
//                                                                                       child: ListTile(
//                                                                                         title: Padding(
//                                                                                           padding: EdgeInsets.only(
//                                                                                               top: 10),
//                                                                                           child: Text(data
//                                                                                               .data[index].menuName),
//                                                                                         ),
//                                                                                         subtitle: Column(
//                                                                                           crossAxisAlignment:
//                                                                                               CrossAxisAlignment
//                                                                                                   .start,
//                                                                                           children: <Widget>[
//                                                                                             Text(data.data[index]
//                                                                                                 .description),
//                                                                                             Text(
//                                                                                               "₱" +
//                                                                                                   data.data[index]
//                                                                                                       .price
//                                                                                                       .toString(),
//                                                                                               style:
//                                                                                                   GoogleFonts.roboto(
//                                                                                                       color:
//                                                                                                           Colors.blue,
//                                                                                                       letterSpacing:
//                                                                                                           2,
//                                                                                                       fontSize: 20,
//                                                                                                       fontWeight:
//                                                                                                           FontWeight
//                                                                                                               .w700),
//                                                                                             ),
//                                                                                           ],
//                                                                                         ),
//                                                                                         trailing: Container(
//                                                                                           width: 50,
//                                                                                           child: InkWell(
//                                                                                             onTap: () {
                                                                                             
                                      
//                                                                                               // Navigator.push(context, MaterialPageRoute(
//                                                                                               // builder: (context) => MyHomePage()));
//                                                                                             },
//                                                                                             splashColor: Colors.blue,
//                                                                                             child: Container(
//                                                                                               width: 50,
//                                                                                               padding:
//                                                                                                   EdgeInsets.all(10),
//                                                                                               decoration: BoxDecoration(
//                                                                                                   shape:
//                                                                                                       BoxShape.circle,
//                                                                                                   color: Colors
//                                                                                                       .transparent),
//                                                                                               child: Icon(Icons.add,
//                                                                                                   color: Colors.blue),
//                                                                                             ),
//                                                                                           ),
//                                                                                         ),
//                                                                                       ),
//                                                                                     ),