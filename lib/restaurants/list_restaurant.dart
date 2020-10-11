import 'dart:convert';

import 'package:WhereTo/MenuRestaurant/categ_type.dart';
import 'package:WhereTo/MenuRestaurant/restaurant_menu_list.dart';
import 'package:WhereTo/Transaction/myOrders.dart';
import 'package:WhereTo/Transaction/mycart.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:WhereTo/google_maps/google-key.dart';
import 'package:WhereTo/modules/homepage.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/blocCategory.class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/blocMenu.class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/blocMenu.dart';
import 'package:WhereTo/restaurants/card_menu.dart';
import 'package:WhereTo/restaurants/restaurant_searchdepo.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ListStactic extends StatefulWidget {
  final String nameRestau;
  final String restauID;
  final String baranggay;
  final double lat;
  final double lng;
  final String categID;
  const ListStactic({Key key, this.nameRestau, this.restauID, this.baranggay, this.lat, this.lng, this.categID})
      : super(key: key);
  @override
  _ListStacticState createState() => _ListStacticState();
}

class _ListStacticState extends State<ListStactic>
    with TickerProviderStateMixin {
  MenuBloc menuBloc;
  final PageStorageBucket _bucket = new PageStorageBucket();
  final PageStorageKey key = new PageStorageKey("isLoad");
  Future<void> disposeBloc() async {
    menuBloc.dispose();
  }
  Future<void> getCateg() async{
    await menuBloc.getCateg();
  }
  TabController tabController;
  int _index =0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    setState(() {
      menuBloc = MenuBloc();
      getCateg();
    });
    return WillPopScope(
          onWillPop: ()async=>false,
          child: Builder(
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
              FutureBuilder(
                future: CoordinatesConverter().getAddressByLocation("${widget.lat},${widget.lng}"),
                builder: (context, snapshot){
                if(snapshot.data==null){
                  return Container();
                }else{
                return Text(
                snapshot.data,
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy-light'),
              );
                }
                })
                ],
              ),
              actions: [
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                    child: BlocConsumer<OrderBloc, List<TransactionOrders>>(
                      builder: (context, snapshot) {
                        return IconBadge(
                          icon: Icon(Icons.add_shopping_cart),
                          itemCount: snapshot.length,
                          itemColor: Colors.white,
                          badgeColor: Colors.blue,
                          hideZero: true,
                          onTap: ()async{
                            Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyCart(
                                                baranggay: widget.baranggay,
                                                restoLat: widget.lat.toDouble(),
                                                restoLng: widget.lng.toDouble(),
                                                restauID: widget.restauID.toString(),
                                                nameRestau: widget.nameRestau,
                                              )));
                          },
                          
                          );
                          
                      },
                      listener: (BuildContext context, order) {},
                    ),
                  ),
                ),
              ],
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context)=> HomePage()),ModalRoute.withName('/'));
                    BlocProvider.of<OrderBloc>(context)
                        .add(Computation.deleteAll());
                  }),
            ),
            body: Builder(builder: (context) {
              return Container(
                child: StreamBuilder<List<Category>>(
                  stream: menuBloc.streamCateg,
                  builder: (context, datasnapshot) {
                    if(datasnapshot.hasData){
                      if(datasnapshot.data.length >0){
                         tabController = new TabController(vsync: this, length: datasnapshot.data.length, initialIndex:  int.parse(widget.categID)-1 ==0 || int.parse(widget.categID)-1 <0 ? 0 :int.parse(widget.categID)-1);
                      return DefaultTabController(
                        length: datasnapshot.data.length, 
                        child: Scaffold(
                          appBar: PreferredSize(
                            preferredSize: Size.fromHeight(50.5),
                            child: AppBar(
                              elevation: 0,
                              excludeHeaderSemantics: true,
                              // toolbarHeight: 50.5,
                              automaticallyImplyLeading: false,
                              // backgroundColor: Color(0xFF0C375B),
                              backgroundColor: Colors.white,
                              bottom: TabBar(
                                controller: tabController,
                                indicatorSize: TabBarIndicatorSize.label,
                                labelColor: Colors.white,
                                unselectedLabelColor:Colors.transparent,
                                indicator: MD2Indicator(
                                  indicatorHeight: 5, 
                                  indicatorColor: wheretoDark, 
                                  indicatorSize:MD2IndicatorSize.normal),
                                isScrollable: true,
                                tabs: datasnapshot.data.map<Widget>((Category category){
                                  return Container(
                                    width: 100,
                                    child: Tab(
                                      
                                      child: Text(category.categoryName, style: TextStyle(
                                      letterSpacing: 2.0,
                                      color: wheretoDark,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy-light'),),
                                    ),
                                  );
                                }).toList(),
                              ),
                              ),
                          ),
                            body: TabBarView(
                                controller: tabController,
                                
                                children: datasnapshot.data.map<Widget>((Category category){
                                return Padding(padding: EdgeInsets.only(top: 10),
                                child: Container(
                                child: FutureBuilder(
                                  future: MenuBloc().getRest(widget.nameRestau, category.id.toString()),
                                  builder: (context, snapshot){
                                    if(snapshot.hasData){
                                      if(snapshot.data.length >0){
                                        return ListView.builder(
                                          cacheExtent: 9999,
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index){
                                           if(snapshot.data.length >0){
                                             return Padding(padding: EdgeInsets.only(top:35,bottom: 10,left: 40,right: 40),
                                            //   child: MenuBoxRestaurant(
                                            //   image: snapshot.data[index].imagePath.toString(),
                                            //   menuName: snapshot.data[index].menuName.toString(),
                                            //   menuDescription: snapshot.data[index].description.toString(),
                                            //   fixprice: double.parse(snapshot.data[index].totalPrice.toString()),
                                            //   onTap: (){
                                            //     BlocProvider.of<OrderBloc>(context).add(Computation.add(TransactionOrders(
                                            //       name: snapshot.data[index].menuName,
                                            //       description: snapshot.data[index].description,
                                            //       price: double.parse(snapshot.data[index].totalPrice.toString()),
                                            //       quantity: 1,
                                            //       id: snapshot.data[index].menuId,
                                            //       image: snapshot.data[index].imagePath,
                                            //     )));
                                            //   },
                                            // ),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(15),
                                                boxShadow: [
                                                  BoxShadow(
                                                    spreadRadius: 3.3,
                                                    blurRadius: 3.3,
                                                    color: Colors.grey[300]
                                                  )
                                                ],
                                              ),
                                              child: Stack(
                                                overflow: Overflow.visible,
                                                children: [

                                                  Positioned(
                                                    top: -35,
                                                    right: -20,
                                                    child: Container(
                                                      height: 80,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 3,
                                                          color: wheretoDark
                                                        ),
                                                        borderRadius: BorderRadius.circular(5),
                                                        image: DecorationImage(
                                                          image: NetworkImage(snapshot.data[index].imagePath),
                                                          fit: BoxFit.cover
                                                          )
                                                      ),
                                                    )
                                                    
                                                    ),

                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10,top:15),
                                                    child: Text(snapshot.data[index].menuName.toString(),
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      color: wheretoDark,
                                                      fontFamily: 'Gilroy-ExtraBold'
                                                    ),
                                                    ),
                                                    ),
                                                    
                                                  ),
                                                 Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10,top:45),
                                                    child: Text(snapshot.data[index].description.toString(),
                                                    maxLines: 8,
                                                    style: TextStyle(
                                                      color: wheretoDark,
                                                      fontFamily: 'Gilroy-light'
                                                    ),
                                                    ),
                                                    ),
                                                    
                                                  ),
                                                  Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(bottom: 10,left: 15),
                                                      child: Container(
                                                        width: 100,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: wheretoDark
                                                          ),
                                                          borderRadius: BorderRadius.circular(40), 
                                                        ),
                                                        child: Center(
                                                        child: Text("${double.parse(snapshot.data[index].totalPrice.toString())}",
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      color: wheretoDark,
                                                      fontFamily: 'Gilroy-ExtraBold'
                                                    ),
                                                        ),
                                                    ),
                                                      ),
                                                      ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: Padding(padding: const EdgeInsets.only(bottom: 10,right: 15),
                                                    child: Container(
                                                      height: 40,
                                                      width: 120,
                                                      child: RaisedButton(
                                                        child: Center(
                                                          child: Text("Add to Cart",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Gilroy-light',
                                                          
                                                          ),
                                                          ),
                                                        ),
                                                        splashColor: Colors.white,
                                                        color: wheretoDark,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(40),
                                                        ),
                                                        onPressed: (){
                                                           BlocProvider.of<OrderBloc>(context).add(Computation.add(TransactionOrders(
                                                  name: snapshot.data[index].menuName,
                                                  description: snapshot.data[index].description,
                                                  price: double.parse(snapshot.data[index].totalPrice.toString()),
                                                  quantity: 1,
                                                  id: snapshot.data[index].menuId,
                                                  image: snapshot.data[index].imagePath,
                                                )));
                                                        }),
                                                    ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                    }
                                  },
                                )
                              ),
                              ); 
                                }).toList()
                                ),
                            ),
                      
                        
                        
                        );
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
                    return Container();
                  },
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
