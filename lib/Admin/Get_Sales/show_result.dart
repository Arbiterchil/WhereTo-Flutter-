

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
  final String result;

  
  

  const ShowtheResults({Key key, this.dateTo, this.dateFrom, this.id, this.result}) : super(key: key);@override
  _ShowtheResultsState createState() => _ShowtheResultsState(dateFrom,dateTo,id,result);
}

class _ShowtheResultsState extends State<ShowtheResults> {

  final String dateTo;
  final String dateFrom;
  final int id;
  final String result;



  var dataTotal;

  _ShowtheResultsState(this.dateTo, this.dateFrom, this.id, this.result);

  @override
  void initState() {

    print(dateFrom+"_"+dateTo+"_"+id.toString());
    super.initState();
    getSaleStream..getSalesReport(dateFrom, dateTo, id);

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
              RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: "Total Amount: ",
                    style: TextStyle(
                    color: pureblue,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 25
                  ), 
                  ),
                  TextSpan(
                    text: widget.result != null ? widget.result  : "No Total Shown",
                    style: TextStyle(
                    color: pureblue,
                    fontFamily: 'Gilroy-ExtraBold',
                     fontSize: 25
                  ), 
                  ),

                ]
              )),  
               SizedBox(height: 40,),
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
              height: 400,
              child: ListView.builder(
                itemCount: getale.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 10),
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   width: 1,
                        //   color: pureblue
                        // ),
                        // borderRadius: BorderRadius.all(Radius.circular(20)),

                      ),
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
                              fontFamily: 'Gilroy-ExtraBold',
                            ),
                            ),
                          SizedBox(height: 5,),
                        Divider(
                  height: 6.0,
                  thickness: 2,
                  color: pureblue,
                  indent: 10.0,
                  endIndent: 10.0,
                ),  
                        ],
                      ),
                    ),
                  );
                }),
            ),
          );


        }
    }
}