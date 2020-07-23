import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_class.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_reponse.dart';
import 'package:WhereTo/Rider_viewTransac/rider_classView/rider_stream.dart';
import 'package:WhereTo/Rider_viewTransac/view_Transac.dart';
import 'package:flutter/material.dart';

class RiderViewing extends StatefulWidget {
  @override
  _RiderViewingState createState() => _RiderViewingState();
}

class _RiderViewingState extends State<RiderViewing> {

  @override
  void initState() {

    super.initState();
    streamRider..getView();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RiderResponse>(
      stream: streamRider.subject.stream,
      builder: (context , AsyncSnapshot<RiderResponse> snaphot){
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
    Widget _views(RiderResponse rider){
        List<RiderViewClass> rs = rider.riderview;

        if(rs.length == 0 ){
          return Container(
            child: Text('No Transactions This Time.',
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
                      //  rs[index].id == null ? 
                      //   Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: 330.0,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      //       shape: BoxShape.rectangle
                      //     ),
                      //     child: Column(
                      //           children: <Widget>[

                      //           ],
                      //     ),
                      //   ) :
                      ViewTransacRider(
                        image: "asset/img/app.jpg",
                        transacId: rs[index].id.toString(),
                        name: rs[index].name,
                        address: rs[index].address,
                        deliveryAddress: rs[index].deliveryAddress,
                        restaurantName: rs[index].restaurantName,
                        onTap: (){
                          
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