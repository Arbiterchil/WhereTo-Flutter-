
import 'dart:math';

import 'package:flutter/material.dart';

class FuckThisShit extends StatefulWidget {
  @override
  _FuckThisShitState createState() => _FuckThisShitState();
}

class _FuckThisShitState extends State<FuckThisShit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            Expanded(
              child: PageViewWidget(),
            )
        ],
      ),
    );
  }
}

class PageViewWidget extends StatefulWidget {
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {

List<StaticpageDisplay> _list = StaticpageDisplay.generateStatic();

  PageController pageController;

  double viewportFraction = 0.8;

  double pageOffset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController.page;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
     return PageView.builder(
      controller: pageController,
      itemBuilder: (context, index) {
        // double scale = max(viewportFraction,
        //     (1 - (pageOffset - index).abs()) + viewportFraction);

        double angle = (pageOffset - index).abs();

        if (angle > 0.5) {
          angle = 1 - angle;
        }
        return Container(
          // padding: EdgeInsets.only(
          //   right: 10,
          //   left: 20,
          //   // top: 100 - scale * 25,
          //   bottom: 50,
          // ),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(
                3,
                2,
                0.001,
              )
              ..rotateY(angle),
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  _list[index].staticLocalimage,
                  height:  MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.none,
                  alignment: Alignment((pageOffset - index).abs() * 0.5, 0),
                ),
                Positioned(
                  bottom: 60,
                  left: 20,
                  child: AnimatedOpacity(
                    opacity: angle == 0 ? 1 : 0,
                    duration: Duration(
                      milliseconds: 200,
                    ),
                    child: Text(
                      _list[index].staticImagename,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: _list.length,
    );
  }
}



class StaticpageDisplay{


  final String staticLocalimage ;
  final String staticImagename;

  StaticpageDisplay(this.staticLocalimage, this.staticImagename);





  static List<StaticpageDisplay> generateStatic(){

    return
    [
      StaticpageDisplay("asset/img/carousel1.jpg","KFC"),
      StaticpageDisplay("asset/img/carousel2.jpg","Jollibee"),
      StaticpageDisplay("asset/img/carousel3.jpg","McDonalds"),
      StaticpageDisplay("asset/img/carousel4.jpg","Chowking"),
      StaticpageDisplay("asset/img/carousel5.jpg","Penongs"),
      // StaticpageDisplay("asset/img/carousel1.jpg","KFC","Located at GMALL of TAGUM"),
      // StaticpageDisplay("asset/img/carousel2.jpg","Jollibee","Located at National HighWay"),
      // StaticpageDisplay("asset/img/carousel3.jpg","McDonalds","Located at Rizal Street"),
      // StaticpageDisplay("asset/img/carousel4.jpg","Chowking","Located at National HighWay"),
      // StaticpageDisplay("asset/img/carousel5.jpg","Penongs","Located at Lapu-Lapu Street"),
    ];


  }
  
}