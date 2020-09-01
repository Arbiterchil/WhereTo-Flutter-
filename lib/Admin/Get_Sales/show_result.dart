

import 'dart:convert';

import 'package:WhereTo/Admin/Get_Sales/get_SaleResponses.dart';
import 'package:WhereTo/Admin/Get_Sales/get_saleClass.dart';
import 'package:WhereTo/Admin/Get_Sales/get_salesStream.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';

import '../../styletext.dart';

class ShowtheResults extends StatefulWidget {

  final String dateTo;
  final String dateFrom;
  final int id;

  const ShowtheResults({Key key, @required this.dateTo,  @required this.dateFrom,  @required this.id}) : super(key: key);

  @override
  _ShowtheResultsState createState() => _ShowtheResultsState(dateFrom,dateTo,id);
}

class _ShowtheResultsState extends State<ShowtheResults> {

  final String dateTo;
  final String dateFrom;
  final int id;

  _ShowtheResultsState( this.dateTo, this.dateFrom, this.id);

  var dataTotal;

  @override
  void initState() {
    getTotal();
    print(dateFrom+"_"+dateTo+"_"+id.toString());
    super.initState();
    getSaleStream..getSalesReport(dateFrom, dateTo, id);

  }

  void getTotal() async{
       var data = 
      {
        "restaurantId": id,
        "dateFrom": dateFrom,
        "dateTo": dateTo
      };
    var restotal = await ApiCall().getTotalRestaurantSalesReport(data,'/getTotalRestaurantSalesReport');
    var body = json.decode(restotal.body);
    print(body);
    setState(() {
       dataTotal = body[0]['totalAmount'];
    });  
  }

  @override
  void dispose() {
    super.dispose();
    getSaleStream..drainStream();
  }


  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
          children: <Widget>[
            StreamBuilder<GetSaleResponse>(
              stream: getSaleStream.subject.stream,
              builder: (context, AsyncSnapshot<GetSaleResponse> asyncSnapshot ){
                 if(asyncSnapshot.hasData){
                                  if(asyncSnapshot.data.error !=null &&
                                   asyncSnapshot.data.error.length > 0){
                                  return _error(asyncSnapshot.data.error);
                             }
                             return  _views(asyncSnapshot.data);       
                              }else if(asyncSnapshot.hasError){
                                    return _error(asyncSnapshot.error);
                              }else{
                                    return _load();
                              }
              },
            ),
            SizedBox(height: 20,),
                  Text(dataTotal != null ? dataTotal : "No Total Shown"),  
          ],
        ),
    );
    
  }
   Widget _load(){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(pureblue),
                    strokeWidth: 4.0,
                  ),
                ),
          ],
        ),
      );
    }
    Widget _error(String error){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Error :  $error")
              ],
            ),
          );
}
    Widget _views(GetSaleResponse getSaleResponse){
      List<GetSalerepo> getale = getSaleResponse.getSale;

       if(getale.length == 0 ){

         print(getale.length );

          return Center(
            child: Container(
              child: Text('No Result to Look',
              style: TextStyle(
                color: pureblue,
                fontFamily: 'Gilroy-ExtraBold',
                fontSize:  16.0,
                fontWeight: FontWeight.normal
              ),),
            ),
          );
        }else{

          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: getale.length,
                itemBuilder: (context,index){
                  return Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(getale[index].deliveryAddress,
                          style: TextStyle(
                            color: pureblue,
                            fontFamily: 'Gilory-light',
                          ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Flexible(
                                child: Text(getale[index].menuName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: pureblue,
                                  fontFamily: 'Gilroy-ExtraBold'
                                ),
                                ),
                              ),

                              Text(getale[index].price.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: pureblue,
                                  fontFamily: 'Gilroy-light'
                                ),
                                ),

                              Text(getale[index].quantity.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: pureblue,
                                  fontFamily: 'Gilroy-light'
                                ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(getale[index].total.toString(),
                          style: TextStyle(
                            color: pureblue,
                            fontFamily: 'Gilory-ExtraBold',
                          ),
                          ),
                        SizedBox(height: 20,),
                        Divider(
                  height: 6.0,
                  thickness: 2,
                  color: pureblue,
                  indent: 10.0,
                  endIndent: 10.0,
                ),  
                      ],
                    ),
                  );
                }),
            ),
          );


        }
    }
}