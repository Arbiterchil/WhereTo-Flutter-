import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class MenuBoxRestaurant extends StatefulWidget {

  final Function onTap;
  final String menuName;
  final String menuDescription;
  final double fixprice;
  final String image;
  final String hugs;

  const MenuBoxRestaurant({Key key, this.onTap, this.menuName, this.menuDescription, this.fixprice, this.hugs, this.image}) : super(key: key);

 
  @override
  _MenuBoxRestaurantState createState() => _MenuBoxRestaurantState();
}

class _MenuBoxRestaurantState extends State<MenuBoxRestaurant> {


  final PageStorageBucket _bucket = new PageStorageBucket();
  final PageStorageKey key = new PageStorageKey("isLoad");

  @override
  Widget build(BuildContext context) {

    setState(() {
      PageStorage.of(context).writeState(context, "Load!", identifier: ValueKey(key));
    });
    return Container(
      height:120,
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
          // gradient:  LinearGradient(
          //                     stops: [0.2,2],
          //                     colors: 
          //                     [
          //                       Color(0xFF176DB5),
          //                       Color(0xFF0C375B),
                                
          //                     ],
          //                     begin: Alignment.bottomRight,
          //                     end: Alignment.topLeft),
                              boxShadow: [
                             BoxShadow(
                               color: Colors.black12,
                               spreadRadius: 4.4,
                               blurRadius: 4.4
                             ),
                           ],
        // image: DecorationImage(
        //   image: AssetImage("asset/img/bgback.png",
        //   ),
        //   fit: BoxFit.cover),
        
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                // height: MediaQuery.of(context).size.height,
                height: 110,
                width: 170,
                // decoration: BoxDecoration(
                //   color: Color(0xFF0C375B),
                //   borderRadius: BorderRadius.only(
                //     bottomRight: Radius.circular(50),
                //     topLeft: Radius.circular(20),
                //     bottomLeft: Radius.circular(10)
                //   ),
                // ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.menuName,
                    style: TextStyle(
                      color: Color(0xFF0C375B),
                      fontSize: 14.0,
                      letterSpacing: 1,
                      fontFamily: 'Gilroy-ExtraBold'
                    ),
                    ),
                    SizedBox(height: 5,),
                    Text(widget.menuDescription,
                    style: TextStyle(
                      color: Color(0xFF0C375B),
                      fontSize: 12.0,
                      fontFamily: 'Gilroy-light'
                    ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Color(0xFF0C375B),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                      child: Center(
                        child: Text(widget.fixprice.toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'Gilroy-light'
                        ),
                        ),
                      ),
                    ),
                      ],
                    ),
                  ),
                
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              // child: Padding(
              //   padding: const EdgeInsets.only(top: 5,right: 20),
                child: PageStorage(
                  bucket: _bucket,
                  key: key, 
                  child: ExtendedImage.network(widget.image,
                  height: MediaQuery.of(context).size.height,
                  width: 120,
                  cache: true,
                  fit: BoxFit.fill,
                  border: Border.all(color: Colors.white, width: 1.1),
                  shape: BoxShape.circle,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                )
                  ),
                // ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: const EdgeInsets.only(right: 10 ,top: 5),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("asset/img/heartIcon.jpg")
                      ),
                    ),
                  ),
                  ),
            ),
            Align(
              alignment: Alignment.bottomRight,
        
                child: InkWell(
                  onTap: widget.onTap,
                   splashColor: Colors.blue,
                       child: Container(
                       width: 60,
                        height: 30,
                        decoration: BoxDecoration(  
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(40),
                           bottomRight: Radius.circular(20)
                         ),
                         color: Color(0xFF0C375B)),
                        child: Icon(Icons.add,
                        color: Colors.white),),
                     ),    
            ),

            // Align(
            //   alignment: Alignment.topRight,

            //            child: Container(
            //            width: 120,
            //             height: 20,
            //             decoration: BoxDecoration(  
            //              borderRadius: BorderRadius.only(
            //                topRight: Radius.circular(20),
            //                bottomLeft: Radius.circular(10)
            //              ),
            //              color: Color(0xFF0C375B)),
            //             child: Center(
            //               child: Text(widget.hugs,
            //               style: TextStyle(
            //                     color: Colors.white,
            //             fontSize: 15.0,
            //             fontFamily: 'Gilroy-light'
            //           ),
                          
            //               ),
            //             )
                        
            //             ),
                       
            // ),

          ],
        ),
      
    );
  }
}

