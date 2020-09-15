import 'package:WhereTo/Admin/view_saleOurs/remitStream_list.dart';
import 'package:WhereTo/Admin/view_saleOurs/view_remitedListStream.dart';
import 'package:WhereTo/Admin/view_saleOurs/view_reponselist.dart';
import 'package:flutter/material.dart';

import '../../styletext.dart';

class RemitListByDateWithTotal extends StatefulWidget {

  final String dateTo;
  final String dateFrom;
  final String lastresort;

  const RemitListByDateWithTotal({Key key, this.dateTo, this.dateFrom, this.lastresort}) : super(key: key);

  @override
  _RemitListByDateWithTotalState createState() => _RemitListByDateWithTotalState();
}

class _RemitListByDateWithTotalState extends State<RemitListByDateWithTotal> {

  @override
  void initState() {
    super.initState();
    remitListFromDate..getremitList(widget.dateFrom,widget.dateTo);
  }
  @override
  void dispose() {
    super.dispose();
    remitListFromDate..drainstream();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<RemiitanceListResponse>(
            stream: remitListFromDate.beSubject.stream,
            builder: (context,AsyncSnapshot<RemiitanceListResponse> asyncSnapshot){
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
                    fontFamily: 'Gilroy-light',
                    fontSize: 18
                  ), 
                  ),
                  TextSpan(
                    text: widget.lastresort != null ? widget.lastresort  : "No Total Shown",
                    style: TextStyle(
                    color: pureblue,
                    fontFamily: 'Gilroy-ExtraBold',
                     fontSize: 18
                  ), 
                  ),

                ]
              )),
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
                Text("Error :  Restart the Page")
              ],
            ),
          );
}

   Widget _views(RemiitanceListResponse remiitanceListResponse ){
     List<RemittanceList> r = remiitanceListResponse.remitList;

    if(r.length == 0){
        print(r.length );
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
      return Container(
        height: 700,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: r.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 130,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: wheretoDark,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,left: 20,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r[index].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Gilroy-ExtraBold'
                      ),),
                      SizedBox(height: 15,),
                       Text("Amount : ${r[index].amount.toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Gilroy-light'
                      ),),
                      SizedBox(height: 15,),
                       Text("Created At: ${r[index].createdAt}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'Gilroy-light'
                      ),),
                      
                    ],
                  ),
                ),
              ),
            );
          }),
      );
    }

   }

}