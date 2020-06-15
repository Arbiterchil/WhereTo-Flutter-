import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselSex extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<CarouselSex> {
  
  int cur = 0;
  List img = [

      "asset/img/61338547_p0.png",
      "asset/img/62512004_p0.png",
      "asset/img/76134055_p0.png",
      "asset/img/fbmYkDz.jpg",
      "asset/img/mWWsAhL.jpg",
  ];

   List<T> map<T>(List list, Function handler){
     List<T> result = [];
     for(var i = 0 ; i<list.length; i++){
       result.add(handler(i,list[i]));
     }
     return result;
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
              Column(
                children: <Widget>[
                   CarouselSlider(
              height: 200.0,
              autoPlayCurve: Curves.fastOutSlowIn,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: Duration(seconds: 5),
              onPageChanged: (index){
                  setState(() {
                    cur = index;
                  });
              },
              items: img.map((index){
                return Builder(
                  builder:(BuildContext context){
                    return Container(
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black, width: 5.0),
                      ),
                      child: Container(
                        
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Image.asset(
                          index,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,),
                      ),
                    );
                  });  
              }).toList(),   
            ),
              SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(img ,(index , asset){
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0 ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cur == index ? Colors.amber : Color(0xFF3936ea),
                      ),
                    );
                  }
              ),
            ),
                ],
              ),
           
          
        ],
      ),
    );
  }
  
}
