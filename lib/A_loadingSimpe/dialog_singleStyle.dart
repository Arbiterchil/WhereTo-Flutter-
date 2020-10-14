import 'dart:ui';

import 'package:flutter/material.dart';

import '../styletext.dart';

class DialogForAll extends StatefulWidget {

  final Widget widgets;
  final String labelHeader;
  final String message;
  final Function yesFunc;
  final Function noFunc;
  final bool showorNot1;
  final bool showorNot2;
  final String buttTitle1;
  final String buttTitle2;

  const DialogForAll({Key key, this.widgets, this.labelHeader, this.message, this.yesFunc, this.noFunc, this.showorNot1, this.showorNot2, this.buttTitle1, this.buttTitle2}) : super(key: key);

 
  
  @override
  _DialogForAllState createState() => _DialogForAllState();
}

class _DialogForAllState extends State<DialogForAll> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Positioned(
              top: -50,
              child: Container(
              
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(70)),
              ),
              child: Center(
                child: widget.widgets,
              ),
            )),
            Container(
              height: 270,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.only(top: 50),
                    child: Text(widget.labelHeader,
                    style: TextStyle(
                      color: wheretoDark,
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 18
                    ),
                    ),
                    ),
                    SizedBox(height: 20,),
                    Text(widget.message,
                    style: TextStyle(
                      color: wheretoDark,
                      fontFamily: 'Gilroy-light',
                      fontSize: 14
                    ),
                    ),
                    SizedBox(height: 35,),
                    Container(
                      height: 40,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Visibility(
                            visible: widget.showorNot2,
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: wheretoDark,
                                  width: 1
                                ),
                                 borderRadius: BorderRadius.all(Radius.circular(40)), 
                              ),
                              child: RaisedButton(
                                color: Colors.white,
                                splashColor: wheretoDark,
                                child: Center(
                                  child: Text(widget.buttTitle2,
                                      style: TextStyle(
                                        color: wheretoDark,
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 12
                                      ),
                                      ),
                                ),
                                shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.all(Radius.circular(40)), 
                                ),
                                onPressed: widget.noFunc),
                            ),
                          ),
                          Visibility(
                            visible: widget.showorNot1,
                            child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(40)), 
                              ),
                              child: RaisedButton(
                                color: pureblue,
                                splashColor: wheretoDark,
                                child: Center(
                                  child: Text(widget.buttTitle1,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 12
                                      ),
                                      ),
                                ),
                                shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.all(Radius.circular(40)), 
                                ),
                                onPressed: widget.yesFunc),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}