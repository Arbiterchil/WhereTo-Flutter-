import 'dart:convert';
import 'dart:ui';

import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerTransaction.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuResponseTran.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuStreamtran.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class MenuForAdminView extends StatefulWidget {
  
  final int id;

  const MenuForAdminView({Key key, this.id}) : super(key: key);

  @override
  _MenuForAdminViewState createState() => _MenuForAdminViewState(id);
}

class _MenuForAdminViewState extends State<MenuForAdminView> {

final int id;

  _MenuForAdminViewState(this.id);


var totalAll;
double priceTotal = 0;
var totals;

   Widget  buildWidgetError(String error){
    return Center(
      child: Text("$error"),
    );
  }
  Widget buildWidgetLoad(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor:  new AlwaysStoppedAnimation<Color>(Colors.indigo[700]),
          strokeWidth: 4.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    getMenuStreamTransDet..getMenuTransacDetails(id);
    super.initState();
    getTotalPrice(id);
  }

  @override
  void dispose() {
    getMenuStreamTransDet..drainStreamDet();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<GetMenuPertransactionResponse>(
                          stream: getMenuStreamTransDet.subject.stream,
                          builder: (cons,AsyncSnapshot<GetMenuPertransactionResponse> snapshot){
                            if(snapshot.hasData){
                            if(snapshot.data.error != null && snapshot.data.error.length > 0){
                              return buildWidgetError(snapshot.data.error);
                            }
                            return buildWidgetViewMenu(snapshot.data);
                          }else if(snapshot.hasError){
                             return buildWidgetError(snapshot.data.error); 
                          }else{
                              return buildWidgetLoad();
                          }
                          }),
          ],
        ),
      ),
    );
  }

   Widget buildWidgetViewMenu(GetMenuPertransactionResponse gt){
    List<GetMenuPerTransaction> gts = gt.getTran;   
    if(gts.length == 0){
      return Center(
          child: Icon(Icons.clear,color: wheretoDark,size: 50,),
        );
    }else{
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
          child: Column(
            children: [
              RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Total: ',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontFamily: 'Gilroy-light'
                    )
                  ),
                  TextSpan(
                    text: priceTotal.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.indigo,
                      fontFamily: 'Gilroy-ExtraBold'
                    )
                  ),
                ]
              )),
              SizedBox(height: 15,),
              Container(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: gts.map((e) => 
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.indigo,
                          width: 1
                        ),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('${e.totalPrice}',
                              style: TextStyle(
                                color: Colors.indigo,
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 13,
                              ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: Text('${e.menuName}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.indigo,
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 13,
                              ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Text('x${e.quantity}',
                              style: TextStyle(
                                color: Colors.indigo,
                                fontFamily: 'Gilroy-ExtraBold',
                                fontSize: 13,
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 40,
                width: 120,
                child: RaisedButton(
                  color: wheretoDark,
                  child: Center(
                    child: Text("Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gilroy-light'
                    ),
                    ),
                  ),
                  splashColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  onPressed: ()=>Navigator.pop(context)),
              ),
              SizedBox(height: 15,),
            ],
          ),
        ),
      );
    }
  }


getTotalPrice(int intid) async{


final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/$intid');                     
                              var body = json.decode(response.body);
                              for(var body in body){
                                  RiverMenu riverMenu = RiverMenu(
                                    menuName: body["menuName"],
                              description: body["description"],
                              totalPrice: body["totalPrice"].toDouble(),
                              id: body["id"],
                              quantity: body["quantity"],
                                  );
                                  List prices =  [riverMenu.totalPrice];
                                  List quans =  [riverMenu.quantity];
                                  for(var i = 0 ; i < prices.length; i++){
                                    for(var x = 0 ; x < quans.length ; x++){
                                        totalAll = prices[i]*quans[x];
                                      List all =  [totalAll]; 
                                      for(var z = 0 ; z < all.length; z++){
                                            // setState(() {
                                            //   priceTotal = priceTotal+all[z];  
                                            // });                                         
                                      priceTotal = priceTotal+all[z];
                                      }
                                  }
                                  }           
                              }
                            
}
}