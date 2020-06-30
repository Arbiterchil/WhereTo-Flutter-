import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';


class Item {
  String itemname;
  String itemtype;
  int numberofitems;

  Item({this.itemname, this.itemtype, this.numberofitems});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future callback;

  @override
  void initState() {
    callback = _getItemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder =  FutureBuilder(
      future: callback,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return  Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError)
              return  Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return  Scaffold(
      appBar:  AppBar(
        title:  Text("Home Page"),
      ),
      body: futureBuilder,
    );
  }

  Future<List<Item>> _getItemList() async {
    var values =  List<Item>();
    values.add(
        Item(itemname: "A", itemtype: "assets/images/a.jpg", numberofitems: 0));
    values.add(
        Item(itemname: "B", itemtype: "assets/images/a.jpg", numberofitems: 0));
    values.add(
        Item(itemname: "C", itemtype: "assets/images/a.jpg", numberofitems: 0));

    //throw  Exception("Danger Will Robinson!!!");

    await  Future.delayed( Duration(seconds: 2));

    return values;
  }


  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Item> itemList = snapshot.data;
    return  ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (BuildContext context, int index) {
          {
            return Container(
              height: 100,
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(width: 2.0, color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.3),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 75,
                    child: ClipRRect(
                      borderRadius:  BorderRadius.circular(10.0),
                      child: Image(
                        image: AssetImage('assets/images/a.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 10),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 10, top: 15, bottom: 5),
                                      child: Text(
                                        itemList[index].itemname,
                                      ))),
                              Container(
                                  color: Colors.white,
                                  width: 25,
                                  margin: EdgeInsets.only(
                                      left: 10, top: 15, bottom: 5),
                                  child: Image.asset(itemList[index].itemtype)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 10, top: 15, bottom: 5),
                                  child: Text(
                                    'Price : ',
                                  )),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 10, top: 15, bottom: 5),
                                  child: Text(
                                    itemList[index].numberofitems.toString() +
                                        ' \u20B9 ',
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (itemList[index].numberofitems > 0) {
                              setState(() {
                                itemList[index].numberofitems =
                                    itemList[index].numberofitems - 1;
                              });
                            }
                          },
                          child: Container(
                            width: 30,
                            child: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          width: 30,
                          child: Center(
                              child: Text(
                            itemList[index].numberofitems.toString(),
                            style: TextStyle(fontSize: 25),
                          )),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              itemList[index].numberofitems =
                                  itemList[index].numberofitems + 1;
                              print(
                                  ' ${itemList[index].itemname.toString()} ${itemList[index].numberofitems.toString()}');
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            width: 30,
                            child: Icon(
                              Icons.add_circle_outline,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          ;
        });
  }
}