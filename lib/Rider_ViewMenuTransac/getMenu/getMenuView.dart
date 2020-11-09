import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerTransaction.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuResponseTran.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuStreamtran.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class MenuViewNew extends StatefulWidget {
  @override
  _MenuViewNewState createState() => _MenuViewNewState();
}

class _MenuViewNewState extends State<MenuViewNew> {

  @override
  void initState() {
    getMenuStreamTransDet..getMenuTransacDetails(UserGetPref().idMenuplusP);
    super.initState();
  }

  @override
  void dispose() {
    getMenuStreamTransDet..drainStreamDet();
    super.dispose();
  }



   Widget bodyAllMenu(){
      return StreamBuilder<GetMenuPertransactionResponse>(
      stream: getMenuStreamTransDet.subject.stream,
      builder: (context,AsyncSnapshot<GetMenuPertransactionResponse> snaphot){
         if(snaphot.hasData){
            if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                return _errorTempMessage(snaphot.data.error);
            }
              return _views(snaphot.data);
        }else if(snaphot.hasError){
              return _errorTempMessage(snaphot.error);
        }else{
              return _loading();
        }
      
      });
  }

Widget _views(GetMenuPertransactionResponse getMenuPertransactionResponse ){
    List<GetMenuPerTransaction> geto = getMenuPertransactionResponse.getTran;
    if(geto.length == 0){
      return Center(
          child: Icon(Icons.clear,color: wheretoDark,size: 50,),
        );
    }else{
      return ListView.builder(
        itemCount: geto.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (con,index){
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 140,
              width: 160,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow( spreadRadius: 2.2,blurRadius: 2.2,color: wheretoDark.withOpacity(0.2))],
                  borderRadius: BorderRadius.circular(15),
              ),
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(geto[index].menuName,
                    style: TextStyle(
                      color: wheretoDark,
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 12
                    ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    height: 6.0,
                    thickness: 2,
                    color: wheretoDark,
                    indent: 10.0,
                    endIndent: 10.0,
                  ),
                  SizedBox(height: 15,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Price : ',
                           style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 12
                  ),
                        ),
                        TextSpan(
                          text: geto[index].totalPrice.toString(),
                           style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 12
                  ),
                        ),
                      ]
                    )),

                    SizedBox(height: 15,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Qty : ',
                           style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 12
                  ),
                        ),
                        TextSpan(
                          text: geto[index].quantity.toString(),
                           style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 12
                  ),
                        ),
                      ]
                    )),
                ],
              ),
            ),

            ),
            );
      });
    }
  }

  Widget _errorTempMessage(String error){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Comback Later.")
              ],
            ),
          );
}
  Widget _loading(){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    strokeWidth: 4.0,
                  ),
                ),
          ],


        ),
      );
    }
  @override
  Widget build(BuildContext context) {
    return Container(
           height: 220,
           width: MediaQuery.of(context).size.width,
           child: bodyAllMenu(),
           );
  }
}