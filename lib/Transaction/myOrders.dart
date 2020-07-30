

import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';
import 'package:WhereTo/Rider_viewTransac/view_Transac.dart';
import 'package:WhereTo/Transaction/Data/response.dart';
import 'package:WhereTo/Transaction/Data/stream.dart';
import 'package:WhereTo/Transaction/MyOrder/getMenuPerTransaction.class.dart';
import 'package:WhereTo/Transaction/MyOrder/getTransactionDetails.class.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'MyOrder/bloc.dart';
import 'MyOrder/bloc.provider.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  // @override
  // void setState(fn) {
  
  //   super.setState(fn);
   
  // }

  @override
  void initState() {
    // TODO: implement initState
     userStream..getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
   
    return Scaffold(
      backgroundColor: Color(0xFF398AE5),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
         Padding(padding: EdgeInsets.only(top: 40, left: 10, right: 10),
          child:  Align(
              alignment: Alignment.topLeft,
              child: DesignButton(
                height: 55,
                width: 55,
                color: Color(0xFF398AE5),
                offblackBlue: Offset(-4, -4),
                offsetBlue: Offset(4, 4),
                blurlevel: 4.0,
                icon: Icons.arrow_back,
                iconSize: 30.0,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ), 
         ),
         Padding(
              padding: EdgeInsets.only(top: 55),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "My Orders",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 55),
              child: xStreamAsshole(),
              ),
            
        ],
      ),
    );


  }


  Widget xStreamAsshole(){

    return StreamBuilder<Response>(
      stream: userStream.subject.stream,
      builder: (context , AsyncSnapshot<Response> snaphot){
        if(snaphot.hasData){
            if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                return _error(snaphot.data.error);
            }
              return _views(snaphot.data);
        }else if(snaphot.hasError){
              return _error(snaphot.error);
        }else{
              return _load();
        }
      },
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
    Widget _views(Response rider){
        List<RiderViewClass> rs = rider.getview;

        if(rs.length == 0 ){
          return Container(
            child: Text('Ok.',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize:  16.0,
              fontWeight: FontWeight.normal
            ),),
          );
        }else{
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: rs.length,
                itemBuilder: (context,index){
                   return Column(
                     children: <Widget>[
                     
                      ViewTransacRider(
                        image: "asset/img/app.jpg",
                        transacId: rs[index].id.toString(),
                        name: rs[index].name,
                        address: rs[index].address,
                        deliveryAddress: rs[index].deliveryAddress,
                        restaurantName: rs[index].restaurantName,
                        onTap: () async {
                          

                        },
                      ),
                     ],
                   );
                },
                ),
            ),
          );
        }
    }



}