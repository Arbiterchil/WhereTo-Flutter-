import 'package:WhereTo/Admin/r_source.dart';
import 'package:WhereTo/Admin/view_allID.dart';
import 'package:flutter/material.dart';

import '../styletext.dart';

class ViewItImage extends StatefulWidget {
   final Resources resources;

  ViewItImage(this.resources);
  @override
  _ViewItImageState createState() => _ViewItImageState();
}

class _ViewItImageState extends State<ViewItImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async => false,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,top:10,right: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>
                      [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: GestureDetector(
                              onTap: (){

                                // uploadImagtoCloud();
                                Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => ViewAllImageId()));
                              },
                              // _signingIn,
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
                   SizedBox(height: 50,),
                  Container(
                    child: Hero(
                tag: widget.resources.secureUrl,
                child: Image.network(
                  widget.resources.secureUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),      
    );
  }
}