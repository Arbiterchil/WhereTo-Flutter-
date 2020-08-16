import 'dart:collection';
import 'dart:convert';

import 'package:WhereTo/Transaction/test.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styletext.dart';

class TrialCardPratice extends StatefulWidget {
  @override
  _TrialCardPraticeState createState() => _TrialCardPraticeState();
}

class _TrialCardPraticeState extends State<TrialCardPratice> {


  List dataCategory = List();
  List<String> items = [];
  SharedPreferences prefs;
  var formkey = GlobalKey<FormState>();
  callCategory() async{

    var respon = await ApiCall().getCategory('/getCategories');
    var bararang = json.decode(respon.body);
  
    setState(() {
      dataCategory = bararang;
    });
    print(bararang);
  }
 
  String slectCategory;
  String nameCategory;
  @override
  void initState() {
    super.initState();
    this.callCategory();
    slectCategory = null;
  }

  @override
  Widget build(BuildContext context) {
       return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Category",
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),

                    Provider<Holder>(
                      create: (context) => Holder(),
                      child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 200.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Consumer<Holder>(
                  builder: (context, model , child){
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[


                        DropdownButtonHideUnderline(
                            child:
                              Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.category,
                                  color: Colors.white,)),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child:
                                   Form(
                                     key: formkey,
                                     child: DropdownButton(
                                          isExpanded: true ,
                                          hint: Text( "Select Category",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Gilroy-light'
                                            ),),
                                          dropdownColor:  Color(0xFF0C375B),
                                          icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                                          value: slectCategory,
                                          items: dataCategory.map((item) {
                                          nameCategory = item['categoryName'];

                                          return new DropdownMenuItem(
                                            
                                            child: Text(nameCategory!=null ? nameCategory : "Nope",
                                            style: TextStyle(
                                              
                                              color: Colors.white,
                                              fontFamily: 'Gilroy-light'
                                            ),
                                            ),
                                            value: item['id'].toString(),
                                          );
                                        }).toList(),
                                          onChanged: (item){
                                            setState(() {
                                              slectCategory = item;
                                             print(slectCategory);
                                            //  Provider.of<Holder>(context ,listen: false).add(item);
                                            model.addSome(slectCategory);
                                            int index = int.parse(item);
                                            // print(dataCategory[--index]['categoryName']);
                                            model.addSomeName(dataCategory[--index]['categoryName']);
                                            // print(model._items);
                                            });

                                          },
                                          ),
                                   ),
                                ),
                              ],
                            ),
                          ),
                  Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: model._items.length,
                    itemBuilder: ( context ,  index){
                        return Text(model._items[index].toString()
                        +". "+
                        model._itemNames[index].toString(),
                              style: TextStyle(
                                fontFamily: 'Gilroy-light',
                                fontSize: 20,
                                color: Colors.white
                              ),
                              
                            );

                 
                        
                    }),
                ),
                        Container(
                      width: 120,
                    child:RaisedButton(
                    onPressed: (){
                      setState(() {
                         model.remove();
                      });
                    },
                    elevation: 5.0,
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    child: Text('Remove All',
                    style: TextStyle(
                      color: Color(0xFF0C375B),
                      letterSpacing: 1,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy-light',
                    ),),
                    )
                  
                 
                
              ), 
                

                      ],
                    );

                  },
                ),
                  
              )
            ),
                    ),
           
      ],
    );
  }

  

}

class Holder {

  List<String> _items = []; 
  List<String> _itemNames=[];
  void addSome(String item){
    _items.add(item);
    print(_items);
  }
   void addSomeName(String item){
    _itemNames.add(item);
    print(_itemNames);
  }
  void remove(){
    _items.clear();
    _itemNames.clear();

  }
 

 
}