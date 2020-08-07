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

      "asset/img/carousel1.jpg",
      "asset/img/carousel2.jpg",
      "asset/img/carousel3.jpg",
      "asset/img/carousel4.jpg",
      "asset/img/carousel5.jpg"
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
      width: MediaQuery.of(context).size.width,
      
      child: Stack(
        children: <Widget>[
              Column(
                children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                
                child: CarouselSlider(
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
                      return Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: Container(
                          
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black, width: 5.0),
                          image: DecorationImage(
                            image: AssetImage(index),
                            fit: BoxFit.cover) ,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          // child: Container(
                          //   width: MediaQuery.of(context).size.width,
                            
                          //   margin: EdgeInsets.symmetric(horizontal: 0.0),
                          //   child: Image.asset(
                          //     index,
                          //     fit: BoxFit.cover,
                          //     ),
                          // ),
                        ),
                      );
                    });  
                }).toList(),   
            ),
              ),
              SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(img ,(index , asset){
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0 ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cur == index ? Color(0xFF0C375B) : Colors.amber,
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
