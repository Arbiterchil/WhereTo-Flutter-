import 'dart:convert';

import 'package:WhereTo/MenuRestaurant/categ_type.dart';
import 'package:WhereTo/MenuRestaurant/restaurant_menu_list.dart';
import 'package:WhereTo/Transaction/myOrders.dart';
import 'package:WhereTo/Transaction/mycart.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:WhereTo/modules/homepage.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/blocCategory.class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/blocMenu.class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/blocMenu.dart';
import 'package:WhereTo/restaurants/card_menu.dart';
import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import 'package:badges/badges.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListStactic extends StatefulWidget {
  final String nameRestau;
  final String restauID;
  final String baranggay;
  final String address;
  final String categID;
  const ListStactic({Key key, this.nameRestau, this.restauID, this.baranggay, this.address, this.categID})
      : super(key: key);
  @override
  _ListStacticState createState() => _ListStacticState();
}

class _ListStacticState extends State<ListStactic>
    with SingleTickerProviderStateMixin {
  MenuBloc menuBloc;
  Future<void> disposeBloc() async {
    menuBloc.dispose();
  }
  Future<void> getCateg() async{
    await menuBloc.getCateg();
  }
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      menuBloc = MenuBloc();
      getCateg();
    });
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: Color(0xFF0C375B),
          appBar: AppBar(
            bottomOpacity: 0.2,
            backgroundColor: Color(0xFF0C375B),
            title: Column(
              children: [
              Text(
              widget.nameRestau,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy-light'),
            ),
            Text(
              widget.address,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy-light'),
            ),
              ],
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                  child: BlocConsumer<OrderBloc, List<TransactionOrders>>(
                    builder: (context, snapshot) {
                      return Badge(
                        badgeContent: Text(snapshot.length.toString()),
                        badgeColor: Colors.white,
                        borderRadius: 20,
                        position: BadgePosition.topLeft(),
                        child: Container(
                          child: IconButton(
                              icon: Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyCart(
                                              barangay: widget.baranggay,
                                              restauID: widget.restauID.toString(),
                                              nameRestau: widget.nameRestau,
                                            )));
                              }),
                        ),
                      );
                    },
                    listener: (BuildContext context, order) {},
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:  10),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    SharedPreferences local =
                        await SharedPreferences.getInstance();
                    var userjson = local.getString('user');
                    var user = json.decode(userjson);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyOrder(id: user['id'].toString())));
                  }),
                ),
            ],
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                  BlocProvider.of<OrderBloc>(context)
                      .add(Computation.deleteAll());
                }),
          ),
          body: Builder(builder: (context) {
            return Container(
              child: StreamBuilder<List<Category>>(
                stream: menuBloc.streamCateg,
                builder: (context, datasnapshot) {
                  if (datasnapshot.data == null) {
                    return Center(
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 3.0,
                        ),
                      ),
                    );
                  } else {
                    return DefaultTabController(
                      length: datasnapshot.data.length, 
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child:TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BubbleTabIndicator(
                              indicatorHeight: 20.0,
                              indicatorColor: Colors.blue,
                              tabBarIndicatorSize: TabBarIndicatorSize.tab
                            ),
                            isScrollable: true,
                            tabs: datasnapshot.data.map<Widget>((Category category){
                              // _tabController = new TabController(length: category.id, vsync: this);
                              return Container(
                                width: 100,
                                child: Tab(
                                  child: Text(category.categoryName, style: TextStyle(
                                  letterSpacing: 2.0,
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy-light'),),
                                ),
                              );
                            }).toList(),
                          ),
                          ),
                          TabBarView(
                            children: datasnapshot.data.map<Widget>((Category category){
                            return Padding(padding: EdgeInsets.only(top: 50),
                            child: Container(
                            child: FutureBuilder(
                              future: MenuBloc().getRest(widget.nameRestau, category.id.toString()),
                              builder: (context, snapshot){
                                if(snapshot.hasData){
                                  if(snapshot.data.length >0){
                                    return ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index){
                                       if(snapshot.data.length >0){
                                         return Padding(padding: EdgeInsets.all(15),
                                          child: MenuBoxRestaurant(
                                          menuName: snapshot.data[index].menuName,
                                          menuDescription: snapshot.data[index].description,
                                          fixprice: snapshot.data[index].price.toString(),
                                          onTap: (){
                                            BlocProvider.of<OrderBloc>(context).add(Computation.add(TransactionOrders(
                                              name: snapshot.data[index].menuName,
                                              description: snapshot.data[index].description,
                                              price: snapshot.data[index].price,
                                              quantity: 1,
                                              id: snapshot.data[index].menuId,
                                            )));
                                          },
                                        ),
                                      );
                                       }else{ 
                                         return Container();
                                       }
                                    });
                                  }else{
                                    return Container();
                                  }
                                }else{
                                  return Center(
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      strokeWidth: 3.0,
                                    ),
                                  ),
                                );
                                }
                              },
                            )
                          ),
                          ); 
                            }).toList()
                            ),
                        ],
                      ),
                      );
                  }
                },
              ),
            );
          }),
        );
      },
    );
  }
}
