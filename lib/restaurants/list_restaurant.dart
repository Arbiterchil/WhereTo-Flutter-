
import 'package:WhereTo/MenuRestaurant/categ_type.dart';
import 'package:WhereTo/MenuRestaurant/restaurant_menu_list.dart';
import 'package:WhereTo/Transaction/mycart.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';


class ListStactic extends StatefulWidget {
  final String nameRestau;
  final String restauID;
  const ListStactic({Key key, this.nameRestau, this.restauID}) : super(key: key);
  @override
  _ListStacticState createState() => _ListStacticState();
}

class _ListStacticState extends State<ListStactic>
    with SingleTickerProviderStateMixin {
  num _defaultValue = 0;
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
    // int getmeouts = widget.restaurant.id;
    int id;
    String menuName;
    // final bloc = BlocProviders.of<BlocTransaction>(context);
    // setState(() {
    //   bloc.category();
    //   bloc.menuList(widget.nameRestau, "Chicken", 4);
    // });
    int val = 0;
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
                    appBar: AppBar(
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
                                child: IconButton(
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.black,
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
                              );
                            },
                            listener: (BuildContext context, order) {
                                  Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("Order Added")));
                                },
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyOrders()));
                                                                  }),
                                                            ],
                                                            backgroundColor: Colors.amber,
                                                            leading: IconButton(
                                                                icon: Icon(
                                                                  Icons.arrow_back_ios,
                                                                ),
                                                                onPressed: () {
                                                                  //  Navigator.push(context, MaterialPageRoute(
                                                                  // builder: (context) => SearchDepo()));
                                                                  Navigator.pop(context);
                                                                  BlocProvider.of<OrderBloc>(context).add(Computation.deleteAll());
                                                                }),
                                                            title: Text(
                                                              widget.nameRestau,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 24.0,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            bottom: TabBar(
                                                              unselectedLabelColor: Colors.black,
                                                              indicator: BoxDecoration(
                                                                color: Colors.blue,
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
                                                          body: Builder(builder: (context) {
                                                            return TabBarView(
                                                              children: snapshot.data.map<Widget>((TyepCateg ty) {
                                                                return Container(
                                                                  child: FutureBuilder(
                                                                      future: _menuList(ty.id, ty.categoryName),
                                                                      builder: (context, data) {
                                                                        if (data.data == null) {
                                                                          return Center(
                                                                            child: CircularProgressIndicator(),
                                                                          );
                                                                        } else {
                                                                          return ListView.builder(
                                                                              itemCount: data.data.length,
                                                                              itemBuilder: (context, index) {
                                                                                return Padding(
                                                                                  padding: EdgeInsets.all(15),
                                                                                  child: Container(
                                                                                    height: 90,
                                                                                    child: Card(
                                                                                      color: Colors.white70,
                                                                                      elevation: 15.6,
                                                                                      clipBehavior: Clip.antiAlias,
                                                                                      child: ListTile(
                                                                                        title: Padding(
                                                                                          padding: EdgeInsets.only(
                                                                                              top: 10),
                                                                                          child: Text(data
                                                                                              .data[index].menuName),
                                                                                        ),
                                                                                        subtitle: Column(
                                                                                          crossAxisAlignment:
                                                                                              CrossAxisAlignment
                                                                                                  .start,
                                                                                          children: <Widget>[
                                                                                            Text(data.data[index]
                                                                                                .description),
                                                                                            Text(
                                                                                              "₱" +
                                                                                                  data.data[index]
                                                                                                      .price
                                                                                                      .toString(),
                                                                                              style:
                                                                                                  GoogleFonts.roboto(
                                                                                                      color:
                                                                                                          Colors.blue,
                                                                                                      letterSpacing:
                                                                                                          2,
                                                                                                      fontSize: 20,
                                                                                                      fontWeight:
                                                                                                          FontWeight
                                                                                                              .w700),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        trailing: Container(
                                                                                          width: 50,
                                                                                          child: InkWell(
                                                                                            onTap: () {
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
                                      
                                                                                              // Navigator.push(context, MaterialPageRoute(
                                                                                              // builder: (context) => MyHomePage()));
                                                                                            },
                                                                                            splashColor: Colors.blue,
                                                                                            child: Container(
                                                                                              width: 50,
                                                                                              padding:
                                                                                                  EdgeInsets.all(10),
                                                                                              decoration: BoxDecoration(
                                                                                                  shape:
                                                                                                      BoxShape.circle,
                                                                                                  color: Colors
                                                                                                      .transparent),
                                                                                              child: Icon(Icons.add,
                                                                                                  color: Colors.blue),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              });
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
                                      
                                        MyOrders() {}
}
