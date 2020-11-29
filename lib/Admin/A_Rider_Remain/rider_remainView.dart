
import 'package:WhereTo/Admin/A_RiderRet/rider_viewRets.dart';
import 'package:WhereTo/Admin/A_Rider_Remain/rider_reaminStream.dart';
import 'package:WhereTo/Admin/A_Rider_Remain/rider_remainResponse.dart';
import 'package:WhereTo/Rider_MonkeyBar/rider_bottom.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/finale/viewLast.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/rider_previous.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/view_MenuTransac.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:flutter/material.dart';

import '../../styletext.dart';

class RaminDataIndi extends StatefulWidget {

  final int id;

  const RaminDataIndi({Key key, this.id}) : super(key: key);

  @override
  _RaminDataIndiState createState() => _RaminDataIndiState(id);
}



class _RaminDataIndiState extends State<RaminDataIndi> {

  final int id;

  _RaminDataIndiState(this.id);
  @override
  void initState() {

    super.initState();
    remainStream..getRemianData();
  }

  @override
  void dispose() {
    super.dispose();
    remainStream.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
         shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<RemainResponse>(
                        stream: remainStream.subject.stream,
                        builder: (context, AsyncSnapshot<RemainResponse> asyncSnapshot){
                           if(asyncSnapshot.hasData){
                              if(asyncSnapshot.data.error !=null && asyncSnapshot.data.error.length > 0){
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
            )
          ],
        ),
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
                Text("Something went wrong")
              ],
            ),
          );
}
  Widget _views(RemainResponse response){
    List<RetieveAlltransac> v = response.retieveAlltransac;

     if(v.length == 0 ){
          return Center(
            child: Container(
              child: Text('No Transaction',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy-light',
                fontSize:  16.0,
                fontWeight: FontWeight.normal
              ),),
            ),
          );
        }else{
          return ListView.builder(
            itemCount: v.length,
            itemBuilder: (context,index){
              //  del = v[index].deliveryAddress;
              //  converting();
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          
                    child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
                                                        return ViewLastStepper(
                                                          getId:v[index].id,
                                                          deviceId: v[index].deviceId,
                                                          restuName:v[index].restaurantName ,
                                                          name: v[index].name,
                                                          address:v[index].deliveryAddress ,
                                                          contact:v[index].contactNumber.toString() ,
                                          
                                                          );
                                                      }));
      },
      child:  Banner(
        message: "Previous",
        location: BannerLocation.topEnd,
        color: wheretoDark,
        child: Container(
               height: 140,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                color: Color(0xFFF7F7F7),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2.2,
                          blurRadius: 3.3,
                          color: wheretoDark.withOpacity(0.3)
                  ),
                ],
                 borderRadius: BorderRadius.all(Radius.circular(5)),
               ),
               child: Padding(
                 padding: const EdgeInsets.only(left: 20),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Text(v[index].name,
                      style: TextStyle(
                      color: wheretoDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: 'Gilroy-ExtraBold'
                      ),
                      ),
                      SizedBox(height: 7.0,),
                      Text(v[index].restaurantName,
                      style: TextStyle(
                      color: wheretoDark,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.0,
                      fontFamily: 'Gilroy-light'
                      ),
                      ),
                      SizedBox(height: 7.0,),
                      Text(v[index].deliveryAddress,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                      color: wheretoDark,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.0,
                      fontFamily: 'Gilroy-light'
                      ),
                      ),
                      SizedBox(height: 7.0,),
                      Text(v[index].deliveryCharge.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                      color: wheretoDark,
                      fontWeight: FontWeight.normal,
                      fontSize: 11.0,
                      fontFamily: 'Gilroy-light'
                      ),
                      ),
                   ],
                 ),
               ),

                   
                          ),
      ),
    ),

                  ),
                ],
              );
            },
            
            );
        }
  }
}