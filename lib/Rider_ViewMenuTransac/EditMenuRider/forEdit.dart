import 'package:WhereTo/Rider_ViewMenuTransac/EditMenuRider/MenuforEdit.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/EditMenuRider/appStateProv.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerResponse.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerRestaurant.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerStream.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerRestaurant/getMenuPerTransaCtion.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerTransaction.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuResponseTran.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuStreamtran.dart';
import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class ForEditTrial extends StatefulWidget {
  @override
  _ForEditTrialState createState() => _ForEditTrialState();
}

class _ForEditTrialState extends State<ForEditTrial> {


  @override
  void initState() {
     getMenuStreamTransDet..getMenuTransacDetails(UserGetPref().idMenuplusP);
     resposneEdit..getMenuRiderOnly();
    super.initState();
  }
  @override
  void dispose() {
    resposneEdit..drainStreamDet();
   getMenuStreamTransDet..drainStreamDet();
    super.dispose();
  }
  
  

  // Widget _views1(ResponseMenuRider responseMenuRider,AppStateData appStateData){
  //   List<GetMenuPerRestaurant>geto = responseMenuRider.filter;


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
    final AppStateData appStateData = AppState.of(context);
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 240,
                  child: StreamBuilder(
                   
                    stream: appStateData.editMenuBloc.menuGetget,
                    builder: (_,AsyncSnapshot<List<MenuForEdit>> snap){
                     if(snap.hasData){
                        return ListView(
                        scrollDirection: Axis.horizontal,
                        children: snap.data.map((e) => 
                         Padding(
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
                    child: Text(e.menuName,
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
                          text: e.totalPrice.toString(),
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
                          text: e.quantity.toString(),
                           style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 12
                  ),
                        ),
                      ]
                    )),
                   SizedBox(height: 15,),
                   Container(
                     height: 40,
                     width: 100,
                     child: RaisedButton(
                       splashColor: Colors.indigo[500],
                       color: wheretoDark,
                       child: Center(
                         child: Text('ADD',
                         style: TextStyle(
                           color: Colors.white,
                           fontFamily: 'Gilroy-light'
                         ),
                         ),
                       ),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(50)
                       ),
                       onPressed: (){
                         List<MenuForEdit> menuEdit;
                         bool menuProb = snap.data.any((element) => element.id == e.id);
                         if(menuProb){
                           menuEdit = snap.data.where((elements) => 
                           elements.id != e.id
                           ).toList();
                         }else{
                           menuEdit = snap.data + [e];
                         }
                        appStateData.editMenuBloc.update(menuEdit);
                       }),
                   ),
                ],
              ),
            ),

            ),
            )
                        
                        ).toList(),
                      );
                     }else{
                       return Container();
                     }
                    },
                  ),
                ),
                Container(
                     width: MediaQuery.of(context).size.width,
                  height: 210,
                  child: getMerPerrestu(appStateData)),
                SizedBox(height: 30,),
                // allRight(appStateData),
              ],
            ),
          ) 
          ),
      );
  }

  // Widget allRight(AppStateData appStateData){
  //   return Container(
  //     height: 200,
  //     width: MediaQuery.of(context).size.width,
  //     child:   StreamBuilder(
  //                 stream: appStateData.editMenuBloc.menuGetget,
  //                 builder: (BuildContext _,AsyncSnapshot<List<MenuForEdit>> snapshot ){
  //                   if(!snapshot.hasData){
  //                     _loading();
  //                   }
  //                   if(snapshot.hasError){
  //                     _errorTempMessage(snapshot.error);
  //                   }
                    
  //                   return bodyAllMenu(snapshot);


  //                 }),
  //   );
  // }

Widget _views1(ResponseMenuRider responseMenuRider,AppStateData appStateData){

    List<GetMenuPerRestaurant>geto = responseMenuRider.filter;
    List bem = geto.map((e) => MenuForEdit(
      id: e.id,
      menuName: e.menuName,
      totalPrice: e.totalPrice,
      quantity: 1,
    )).toList();
    final okeTrial = bem;
    appStateData.editMenuBloc.update(bem);
    print(bem);
      List<MenuForEdit> menuEdit;
      return Container();
          //                if(menuProb){
          //                  menuEdit = asyncSnapshot.data.where((elements) => 
          //                  elements.id != e.id
          //                  ).toList();
          //                }else{
          //                  menuEdit = asyncSnapshot.data + [e];
          //                }
          //               appStateData.editMenuBloc.update(menuEdit);

    // if(geto.length == 0){
    //   return Center(
    //       child: Icon(Icons.clear,color: wheretoDark,size: 50,),
    //     );
    // }else{
      
    //     return StreamBuilder(
    //       stream: appStateData.editMenuBloc.menuGetget,
    //       builder: (_,AsyncSnapshot<List<MenuForEdit>> asyncSnapshot){
    //         if(!asyncSnapshot.hasData){
    //                   _loading();
    //                 }
    //                 if(asyncSnapshot.hasError){
    //                   _errorTempMessage(asyncSnapshot.error);
    //                 }
    //         // var check = okeTrial.map((e) => 
    //         //   menuEdit = asyncSnapshot.data + [e],
    //         // ).toList();
            
    //         // print(okeTrial);
    //         return Container();
    //       // return ListView(
    //       //   scrollDirection:Axis.horizontal ,
    //       //   children: 
    //       //   okeTrial.map((e) => 
    //       //   Padding(
    //       //   padding: const EdgeInsets.all(10),
    //       //   child: Container(
    //       //     height: 140,
    //       //     width: 160,
    //       //     decoration: BoxDecoration(
    //       //         color: Colors.white,
    //       //         boxShadow: [BoxShadow( spreadRadius: 2.2,blurRadius: 2.2,color: wheretoDark.withOpacity(0.2))],
    //       //         borderRadius: BorderRadius.circular(15),
    //       //     ),
    //       //   child: Padding(
    //       //     padding: const EdgeInsets.only(left:8.0),
    //       //     child: Column(
    //       //       mainAxisAlignment: MainAxisAlignment.center,
    //       //       crossAxisAlignment: CrossAxisAlignment.start,
    //       //       children: [
    //       //         SingleChildScrollView(
    //       //           scrollDirection: Axis.horizontal,
    //       //           child: Text(e.menuName,
    //       //           style: TextStyle(
    //       //             color: wheretoDark,
    //       //             fontFamily: 'Gilroy-ExtraBold',
    //       //             fontSize: 12
    //       //           ),
    //       //           ),
    //       //         ),
    //       //         SizedBox(height: 10,),
    //       //         Divider(
    //       //           height: 6.0,
    //       //           thickness: 2,
    //       //           color: wheretoDark,
    //       //           indent: 10.0,
    //       //           endIndent: 10.0,
    //       //         ),
    //       //         SizedBox(height: 15,),
    //       //         RichText(
    //       //           text: TextSpan(
    //       //             children: [
    //       //               TextSpan(
    //       //                 text: 'Price : ',
    //       //                  style: TextStyle(
    //       //           color: wheretoDark,
    //       //           fontFamily: 'Gilroy-ExtraBold',
    //       //           fontSize: 12
    //       //         ),
    //       //               ),
    //       //               TextSpan(
    //       //                 text: e.totalPrice.toString(),
    //       //                  style: TextStyle(
    //       //           color: wheretoDark,
    //       //           fontFamily: 'Gilroy-ExtraBold',
    //       //           fontSize: 12
    //       //         ),
    //       //               ),
    //       //             ]
    //       //           )),
    //       //          SizedBox(height: 15,),
    //       //          Container(
    //       //            height: 40,
    //       //            width: 100,
    //       //            child: RaisedButton(
    //       //              splashColor: Colors.indigo[500],
    //       //              color: wheretoDark,
    //       //              child: Center(
    //       //                child: Text('ADD',
    //       //                style: TextStyle(
    //       //                  color: Colors.white,
    //       //                  fontFamily: 'Gilroy-light'
    //       //                ),
    //       //                ),
    //       //              ),
    //       //              shape: RoundedRectangleBorder(
    //       //                borderRadius: BorderRadius.circular(50)
    //       //              ),
    //       //              onPressed: (){
    //       //               //  List<GetMenuPerRestaurant> menuEdit;
    //       //               //  menuEdit = geto + [e];
    //       //               //  appStateData.editMenuBloc.update(menuEdit);
    //       //                 // print(asyncSnapshot.data[0].id);
    //       //                 // print(e.id);
    //       //                 // print(geto.iterator);
    //       //                  bool menuProb = asyncSnapshot.data.any((element) => element.id == e.id);
                           
    //       //                List<MenuForEdit> menuEdit;
    //       //                if(menuProb){
    //       //                  menuEdit = asyncSnapshot.data.where((elements) => 
    //       //                  elements.id != e.id
    //       //                  ).toList();
    //       //                }else{
    //       //                  menuEdit = asyncSnapshot.data + [e];
    //       //                }
    //       //               appStateData.editMenuBloc.update(menuEdit);
    //       //              }),
    //       //          ),
    //       //       ],
    //       //     ),
    //       //   ),

    //       //   ),
    //       //   )
    //       //   ).toList()
    //       // );          
    //       },
    //     );

    //     // return ListView.builder(
    //     // itemCount: geto.length,
    //     // scrollDirection: Axis.horizontal,
    //     // itemBuilder: (con,index){

          


    //       // return Padding(
    //       //   padding: const EdgeInsets.all(10),
    //       //   child: Container(
    //       //     height: 140,
    //       //     width: 160,
    //       //     decoration: BoxDecoration(
    //       //         color: Colors.white,
    //       //         boxShadow: [BoxShadow( spreadRadius: 2.2,blurRadius: 2.2,color: wheretoDark.withOpacity(0.2))],
    //       //         borderRadius: BorderRadius.circular(15),
    //       //     ),
    //       //   child: Padding(
    //       //     padding: const EdgeInsets.only(left:8.0),
    //       //     child: Column(
    //       //       mainAxisAlignment: MainAxisAlignment.center,
    //       //       crossAxisAlignment: CrossAxisAlignment.start,
    //       //       children: [
    //       //         SingleChildScrollView(
    //       //           scrollDirection: Axis.horizontal,
    //       //           child: Text(geto[index].menuName,
    //       //           style: TextStyle(
    //       //             color: wheretoDark,
    //       //             fontFamily: 'Gilroy-ExtraBold',
    //       //             fontSize: 12
    //       //           ),
    //       //           ),
    //       //         ),
    //       //         SizedBox(height: 10,),
    //       //         Divider(
    //       //           height: 6.0,
    //       //           thickness: 2,
    //       //           color: wheretoDark,
    //       //           indent: 10.0,
    //       //           endIndent: 10.0,
    //       //         ),
    //       //         SizedBox(height: 15,),
    //       //         RichText(
    //       //           text: TextSpan(
    //       //             children: [
    //       //               TextSpan(
    //       //                 text: 'Price : ',
    //       //                  style: TextStyle(
    //       //           color: wheretoDark,
    //       //           fontFamily: 'Gilroy-ExtraBold',
    //       //           fontSize: 12
    //       //         ),
    //       //               ),
    //       //               TextSpan(
    //       //                 text: geto[index].totalPrice.toString(),
    //       //                  style: TextStyle(
    //       //           color: wheretoDark,
    //       //           fontFamily: 'Gilroy-ExtraBold',
    //       //           fontSize: 12
    //       //         ),
    //       //               ),
    //       //             ]
    //       //           )),
    //       //          SizedBox(height: 15,),
    //       //          Container(
    //       //            height: 40,
    //       //            width: 100,
    //       //            child: RaisedButton(
    //       //              splashColor: Colors.indigo[500],
    //       //              color: wheretoDark,
    //       //              child: Center(
    //       //                child: Text('ADD',
    //       //                style: TextStyle(
    //       //                  color: Colors.white,
    //       //                  fontFamily: 'Gilroy-light'
    //       //                ),
    //       //                ),
    //       //              ),
    //       //              shape: RoundedRectangleBorder(
    //       //                borderRadius: BorderRadius.circular(50)
    //       //              ),
    //       //              onPressed: (){

    //       //                 // print(snapshot.hasData);
    //       //               //    bool menuProb = snapshot.data.any((element) => element.id == geto[index].id);
    //       //               //  List<GetMenuPerRestaurant> menuEdit;
    //       //               //  if(menuProb){
    //       //               //    menuEdit = snapshot.data.where((elements) => 
    //       //               //    elements.id != geto[index].id
    //       //               //    ).toList();
    //       //               //  }else{
    //       //               //    menuEdit = snapshot.data + menuEdit;
    //       //               //  }
                       
    //       //              }),
    //       //          ),
    //       //       ],
    //       //     ),
    //       //   ),

    //       //   ),
    //       //   );
    //   // });

      
    // }
  }

  Widget getMerPerrestu(AppStateData appStateData){
      return StreamBuilder<ResponseMenuRider>(
        stream: resposneEdit.subject.stream,
        builder: (context,AsyncSnapshot<ResponseMenuRider> snaps){
             if(snaps.hasData){
            if(snaps.data.error !=null && snaps.data.error.length > 0){
                return _errorTempMessage(snaps.data.error);
            }
              return _views1(snaps.data,appStateData);
        }else if(snaps.hasError){
              return _errorTempMessage(snaps.error);
        }else{
              return _loading();
        }
        },
      );
  }

  

  Widget bodyAllMenu(AsyncSnapshot<List<MenuForEdit>> edit){
      return StreamBuilder<GetMenuPertransactionResponse>(
      stream: getMenuStreamTransDet.subject.stream,
      builder: (context,AsyncSnapshot<GetMenuPertransactionResponse> snaphot){
         if(snaphot.hasData){
            if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                return _errorTempMessage(snaphot.data.error);
            }
              return _views(snaphot.data,edit);
        }else if(snaphot.hasError){
              return _errorTempMessage(snaphot.error);
        }else{
              return _loading();
        }
      
      });
  }

  Widget _views(GetMenuPertransactionResponse getMenuPertransactionResponse,AsyncSnapshot<List<MenuForEdit>> edit){
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
                   SizedBox(height: 15,),
                   Container(
                     height: 40,
                     width: 100,
                     child: RaisedButton(
                       splashColor: Colors.indigo[500],
                       color: wheretoDark,
                       child: Center(
                         child: Text('ADD',
                         style: TextStyle(
                           color: Colors.white,
                           fontFamily: 'Gilroy-light'
                         ),
                         ),
                       ),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(50)
                       ),
                       onPressed: (){
                         
                         bool menuProb = edit.data.any((element) => element.id == geto[index].id);
                         List<MenuForEdit> menuEdit;
                         if(menuProb){
                           menuEdit = edit.data.where((elements) => 
                           elements.id != geto[index].id
                           ).toList();
                         }else{
                           menuEdit = edit.data + menuEdit;
                         }
                         
                       }),
                   ),
                ],
              ),
            ),

            ),
            );
      });
    }
  }
}