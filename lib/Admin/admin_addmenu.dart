import 'dart:convert';

import 'package:WhereTo/Admin/admin_addrestu.dart';
import 'package:WhereTo/Admin/admin_trial.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styletext.dart';

class AddmenuAdmin extends StatefulWidget {

  final String id;

  const AddmenuAdmin({Key key, this.id}) : super(key: key);

  @override
  _AddmenuAdminState createState() => _AddmenuAdminState();
}

class _AddmenuAdminState extends State<AddmenuAdmin> {

    var formkey = GlobalKey<FormState>();
    TextEditingController menuname  = TextEditingController();
    TextEditingController decription = TextEditingController();
    TextEditingController price = TextEditingController();
    int countname = 0;
    SharedPreferences prefs;
    bool loading = false;
  @override
  void initState() {
    super.initState();
    this.callCategory();
    slectCategory = null;
  }
  int count = 1;
  int indexx;
  var ids;
  List dataCategory = List();
  List<String> items = [];
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
                    child: SafeArea(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40,right: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.pushAndRemoveUntil(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => AdminAddRestaurant()),ModalRoute.withName('/'));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: pureblue,
                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.backspace,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),  
                            SizedBox(height: 30,),
                            _menuForm(),

                            ],
                          
                      ),
                        )),
        ),
       onWillPop: () async => false),
    );
  }

  Widget _menuForm(){

    return Form(
      key: formkey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
            SizedBox(height: 10.0,),
            // Text('Menu Name',
            //         style: eLabelStyle,
            //         ),
            // SizedBox(height: 10.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
                controller: menuname,
                validator: (val) => val.isEmpty ? ' Please Put Your Menu Name' : null,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.menu,
                    color: pureblue,
                  ),
                  hintText: 'Menu Name',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            // Text('Description',
            //         style: eLabelStyle,
            //         ),
            // SizedBox(height: 10.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                cursorColor: pureblue,
                controller: decription,
                validator: (val) => val.isEmpty ? ' Please Put Your Description on this.' : null,
                style: TextStyle(
                  color: pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.description,
                    color: pureblue,
                  ),
                  hintText: 'Description',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            // Text('Price',
            //         style: eLabelStyle,
            //         ),
            // SizedBox(height: 10.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                cursorColor: pureblue,
              keyboardType: TextInputType.number,
                controller: price,
                validator: (val) => val.isEmpty ? ' Please Put Your Price' : null,
                    onSaved: (val) => price.text = val,
                    
                
                style: TextStyle(
                  color:pureblue,
                  fontFamily: 'Gilroy-light',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: pureblue,
                  ),
                  hintText: '0.00',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            // Text("Category",
            //           style: eLabelStyle,
            //           ),
            SizedBox(height: 10.0,),

            Provider<Holder>(
            create: (context) => Holder(),
             child: Container(
             width: MediaQuery.of(context).size.width,
             alignment: Alignment.centerLeft,
            // decoration: eBoxDecorationStyle,
            height: 260.0,
            child: Padding(
            padding: const EdgeInsets.only(left: 2),
            
            child: Consumer<Holder>(
            builder: (context, model , child){
            
            return  Column(
            children: <Widget>[
            DropdownButtonHideUnderline(
            child:
            Stack(
            children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 50,
                width: 50,
                decoration: eBoxDecorationStyle ,
                child: Icon(Icons.category,
                color: pureblue,),
              )),
            ),
            Padding(
            padding: const EdgeInsets.only(left: 60,top: 5),
            child: Container(
              height: 50,
              padding: EdgeInsets.all(5),
              decoration: eBoxDecorationStyle,
              child: DropdownButton(
              isExpanded: true ,
              hint: Text( "Select Category",
              style: TextStyle(
              color: pureblue,
              fontFamily: 'Gilroy-light'
              ),),
              dropdownColor:  Colors.white,
              icon: Icon(Icons.arrow_drop_down,color:pureblue,),
              value: slectCategory,
              items: dataCategory.map((item) {
              nameCategory = item['categoryName'];
              return new DropdownMenuItem(
              child: Text(nameCategory!=null ? nameCategory : "Nope",
              style: TextStyle(
              color: pureblue,
              fontFamily: 'Gilroy-light'
              ),),
              value: item['id'].toString(),);}).toList(),
              onChanged: (item){
              setState(() {
              slectCategory = item;
              print(slectCategory);
              model.addSome(slectCategory);
              int index = int.parse(item); 
              model.addSomeName(dataCategory[--index]['categoryName']);
              });},),),),],),),
                    Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: model._items.length,
                      itemBuilder: ( context ,  index){
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              decoration: eBoxDecorationStyle,
                              padding: EdgeInsets.all(5),
                              child: Text(model._items[index].toString()
                              +". "+
                              model._itemNames[index].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-light',
                                      fontSize: 20,
                                      color: pureblue
                                    ),
                                    
                                  ),
                            ),
                          );

                   
                          
                      }),
                  ),
                  SizedBox(height: 15,),
                  Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>
                    [
                      Align(
                        alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: 
                            () async{
                                          if(slectCategory == null){
                      // print("Select Barangay");
                      _showDistictWarning();
                        }else{
                        if(formkey.currentState.validate()){
                        formkey.currentState.save();
                        
                        Map<String, int> id = {};
                        Map<String , int> shit = {};
                        List<dynamic> categs = [];
                        List resultant = [];
                        
                       for(int i = 0 ; i < model._items.length; i++){
                           ids = int.parse(model._items[i]);
                            id = {
                                'id': ids
                            };
                           categs.add(id);
                            } 
                    
                        for(int x = 0; x< categs.length; x++){
                            resultant.add(categs[x]);
                        }
                        shit.forEach((key ,val) { 
                          resultant.add(
                            {
                              'id': val
                            });
                        });
                        print(resultant);
                         var data =
                          {
                                "restaurantId" : widget.id.toString(),
                                "menu":
                                [{
                                "menuName" : menuname.text,
                                "description" : decription.text,
                                "price":price.text,
                                "imagePath": "https://res.cloudinary.com/ddoiozfmr/image/upload/c_thumb,w_200,g_face/Images/xamples/${menuname.text}.jpg",
                                "category": resultant
                                }]
                                };

                          var response =  await ApiCall().addMenu(data, '/addMenu');
                          print(response.body);
                          menuname.clear();
                          decription.clear();
                          price.clear();
                          setState(() {
                             model.remove();
                          });
                          _showDone();
                        }
                         }
                            },
                            // _addResturant,
                            child: Container(
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                color: pureblue,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Center(
                                child: Text( loading ? '....' : 'Add Menu >',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                                ),
                              ),
                            
                          ),
                          ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: 
                            (){
                              setState(() {
                           model.remove();
                              });
                            },
                            // _addResturant,
                            child: Container(
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                color: pureblue,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Center(
                                child: Text( loading ? '....' : 'Remove All <',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                                ),
                              ),
                            
                          ),
                          ),
                      ),
                    ],
                  ),
                       ),

                //           Container(
                //         width: 120,
                //       child:RaisedButton(
                //       onPressed: (){
                //         setState(() {
                //            model.remove();
                //         });
                //       },
                //       elevation: 5.0,
                //       padding: EdgeInsets.all(8.0),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30.0),
                //       ),
                //       color: Colors.white,
                //       child: Text('Remove All',
                //       style: TextStyle(
                //         color: Color(0xFF0C375B),
                //         letterSpacing: 1,
                //         fontSize: 16.0,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: 'Gilroy-light',
                //       ),),
                //       )
                    
                   
                  
                // ),

                // SizedBox(height: 10,),
                // Container(
                //         width: 120,
                //       child:RaisedButton(
                //       onPressed: () async {

                //         if(slectCategory == null){
                //       print("Select Barangay");
                //       _showDistictWarning();
                //         }else{
                //         if(formkey.currentState.validate()){
                //         formkey.currentState.save();
                        
                //         Map<String, int> id = {};
                //         Map<String , int> shit = {};
                //         List<dynamic> categs = [];
                //         List resultant = [];
                        
                //        for(int i = 0 ; i < model._items.length; i++){
                //            ids = int.parse(model._items[i]);
                //             id = {
                //                 'id': ids
                //             };
                //            categs.add(id);
                //             } 
                    
                //         for(int x = 0; x< categs.length; x++){
                //             resultant.add(categs[x]);
                //         }
                //         shit.forEach((key ,val) { 
                //           resultant.add(
                //             {
                //               'id': val
                //             });
                //         });
                //         print(resultant);
                //          var data =
                //           {
                //                 "restaurantId" : widget.id.toString(),
                //                 "menu":
                //                 [{
                //                 "menuName" : menuname.text,
                //                 "description" : decription.text,
                //                 "price":price.text,
                //                 "category": resultant
                //                 }]
                //                 };
                //           print(data);

                //           await ApiCall().addMenu(data, '/addMenu');
                //           menuname.clear();
                //           decription.clear();
                //           price.clear();
                //           setState(() {
                //              model.remove();
                //           });
                //           _showDone();
                //         }
                //          }
                //       },
                //       elevation: 5.0,
                //       padding: EdgeInsets.all(8.0),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30.0),
                //       ),
                //       color: Colors.white,
                //       child: Text('Add Menu',
                //       style: TextStyle(
                //         color: Color(0xFF0C375B),
                //         letterSpacing: 1,
                //         fontSize: 16.0,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: 'Gilroy-light',
                //       ),),
                //       )
                    
                   
                  
                // ), 

                  

                        ],
                      );

                    },
                  ),
                    
                )
              ),
                      ),

                  ],
        ),
      ),

    );

  }
   void _showDistictWarning(){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: mCustomDistictWarning(context),
    ); 
    },);
}
 mCustomDistictWarning(BuildContext context){

       return Container(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                         gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),),

                    ),
                    Positioned(
                      top: 50.0,
                      left: 94.0,
                      child: Container(
                        height: 90,
                        width: 90,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          
                          // border: Border.all(
                          //   color: Colors.white,
                          //   style: BorderStyle.solid,
                          //   width: 2.0,
                          // ),
                          image: DecorationImage(
                            image: AssetImage("asset/img/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Please Select a Category.",
                  style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    fontFamily: 'Gilroy-light'
                  ),
                  
                  ),),
                  SizedBox(height: 25.0,),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[         
                RaisedButton(
                  color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                      Navigator.of(context).pop();
                      },   
                      
                  child: Text ( "Yes", style :TextStyle(
                  color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),),
                  ],
                ), 
              ],
          ),
        ),
      );


    }
void _showDone(){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: mCustomDOne(context),
    ); 
    },);
}
 mCustomDOne(BuildContext context){

       return Container(
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
                         gradient: LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),),

                    ),
                    Positioned(
                      top: 50.0,
                      left: 94.0,
                      child: Container(
                        height: 90,
                        width: 90,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(45),
                          
                          // border: Border.all(
                          //   color: Colors.white,
                          //   style: BorderStyle.solid,
                          //   width: 2.0,
                          // ),
                          image: DecorationImage(
                            image: AssetImage("asset/img/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Menu Added",
                  style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    fontFamily: 'Gilroy-light'
                  ),
                  
                  ),),
                  SizedBox(height: 25.0,),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[         
                RaisedButton(
                  color:Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                      Navigator.of(context).pop();
                      },   
                      
                  child: Text ( "OK", style :TextStyle(
                  color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                              fontFamily: 'OpenSans'
                ),),),
                  ],
                ), 
              ],
          ),
        ),
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