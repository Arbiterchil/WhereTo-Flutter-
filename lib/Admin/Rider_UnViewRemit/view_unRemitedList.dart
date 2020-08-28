import 'dart:convert';
import 'dart:ui';

import 'package:WhereTo/Admin/Rider_UnViewRemit/view_unStrream.dart';
import 'package:WhereTo/Admin/Rider_UnViewRemit/view_unremit.dart';
import 'package:WhereTo/Admin/Rider_UnViewRemit/view_unresponse.dart';
import 'package:WhereTo/Admin/Rider_viewRemit/view_RemitImages.dart';
import 'package:WhereTo/Admin/navbottom_admin.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../styletext.dart';

class UnRemitedView extends StatefulWidget {
  @override
  _UnRemitedViewState createState() => _UnRemitedViewState();
}

class _UnRemitedViewState extends State<UnRemitedView> {


  @override
  void initState() {
    unremitStream..getUnViewRemit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(left: 20,top: 10),
                   child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>
                      [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: GestureDetector(
                              onTap: () =>
                                Navigator.pushAndRemoveUntil(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => RemitViewImagesAdmin()),ModalRoute.withName('/')),
                              child: Container(
                                height: 50,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: pureblue,
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                                child: Center(
                                  child: Text( 'Back <',
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
                        )
                      ],
                    ),
                ),
                 ),
                 SizedBox(height: 20.0,),
                  Container(
                    height: 600,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<UnRemitResponse>(

                      stream: unremitStream.subject.stream,
                      builder: (context, AsyncSnapshot<UnRemitResponse> asyncSnapshot){
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
                ), 
      
              ],
            ),
          ),
        ),
      onWillPop:() async => false),
      
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


Widget _views(UnRemitResponse remitResponse){

      List<UnViewRemit> un = remitResponse.viewRemit;

      if(un.length == 0 ){
          return Center(
            child: Container(
              child: Text('No Incomming to Verify',
              style: TextStyle(
                color: pureblue,
                fontFamily: 'Gilroy-ExtraBold',
                fontSize:  16.0,
                fontWeight: FontWeight.normal
              ),),
            ),
          );
        }else{
            return Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child:  new StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemBuilder: (context, index){
                   
                  return   GestureDetector(
                    onTap:  () {
                      
                      _showDial(
                        un[index].riderId,
                        un[index].name,
                        un[index].amount,
                        un[index].createdAt,
                        false,
                        );
                      }, 
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("asset/img/logo.png")
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(padding: const EdgeInsets.only(left: 10),
                                child: Text(un[index].name,
                                style: TextStyle(
                                  color: pureblue,
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 20
                                ),
                                ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // child: FadeInImage.memoryNetwork(
                        //   // fadeInDuration: Duration(milliseconds: 1),
                        //   // fadeOutDuration: Duration(milliseconds: 1),
                        //   placeholder: kTransparentImage,
                        //    image: Image.asset("name"),
                        //    fit: BoxFit.cover,)

                      ),

                    ),
                  );

                },
                itemCount: un.length,
                staggeredTileBuilder: (index){
                  return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                },),
              );


        }


}
void _showDial( int id ,String name, int amount, String createdAt,bool laso){
    
    laso = false;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
        child: Dialog(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child:Container(
          height: 450.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          color: Colors.white),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                    // image: DecorationImage(
                    //   image: NetworkImage(resources),
                    //   fit: BoxFit.fitHeight)
                  
                  ),
                  child: PhotoView(
                    backgroundDecoration: BoxDecoration(
                      color: Colors.white,
                     borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                    ),
                    imageProvider: AssetImage("asset/img/logo.png")),
                ),    
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: RichText(text: TextSpan(
                    children: [
                       TextSpan(
                  text: 'ID: ',
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-light'
                  ),
              ),
              TextSpan(
                  text: id.toString(),
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-ExtraBold'
                  ),
              ),
                    ]
                  )),
                ),
                SizedBox(height: 10,),
                Padding(
                 padding: const EdgeInsets.only(left: 10,right: 10),
                  child: RichText(text: TextSpan(
                    children: [
                       TextSpan(
                  text: 'Name: ',
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-light'
                  ),
              ),
              TextSpan(
                  text: name,
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-ExtraBold'
                  ),
              ),
                    ]
                  )),
                ),
                SizedBox(height: 10,),
                Padding(
                 padding: const EdgeInsets.only(left: 10,right: 10),
                  child: RichText(text: TextSpan(
                    children: [
                       TextSpan(
                  text: 'Amount: ',
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-light'
                  ),
              ),
              TextSpan(
                  text: amount.toString(),
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-ExtraBold'
                  ),
              ),
                    ]
                  )),
                ),
                 SizedBox(height: 10,),
                Padding(
                 padding: const EdgeInsets.only(left: 10,right: 10),
                  child: RichText(text: TextSpan(
                    children: [
                       TextSpan(
                  text: 'Created At: ',
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-light'
                  ),
              ),
              TextSpan(
                  text: createdAt,
                  style: TextStyle(
                    color: pureblue,
                    fontSize: 12.0,
                    fontFamily: 'Gilroy-ExtraBold'
                  ),
              ),
                    ]
                  )),
                ),
                SizedBox(height: 20,),
                 Padding(
                     padding: const EdgeInsets.only(left: 20,right: 20),
                     child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>
                        [
                          Align(
                            alignment: Alignment.topLeft,
                            child:  Padding(
                              padding: const EdgeInsets.only(left: 20,right: 5),
                              child: GestureDetector(
                                onTap: ()async{

                                  setState(() {
                                    laso = true;
                                  });
                                     var respawn = await ApiCall().getRiderRemit('/unSuspendRider/$id');
                                      print(respawn.body); 
                                  
                                   Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => AdminHomeDash()));
                                  setState(() {
                                    laso = false;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: pureblue,
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: Center(
                                    child: Text(laso ? '....' :'UnSuspend >',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 12,
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                ),
                              ),
                              ),

                              
                          ),
                           Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5,right: 5),
                              child: GestureDetector(
                                onTap: ()async{

                                  setState(() {
                                    laso = true;
                                  });
                                    
                                    var getSus = await ApiCall().suspendRider('/suspendRider/$id');
                                    print(getSus.body);
                                    Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => AdminHomeDash()));
                                  setState(() {
                                    laso = false;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: pureblue,
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: Center(
                                    child: Text(laso ? '....' :'Suspend >',
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-ExtraBold',
                                      fontSize: 12,
                                      color: Colors.white
                                    ),
                                    ),
                                  ),
                                ),
                              ),
                              ),
                           ),
                        ],
                      ),
                  ),
                   ),
                 SizedBox(height: 20,),
                ],
            ),
          ),
        )
    ),
      ); 
    },);


}
}