import 'package:flutter/material.dart';

class MenuBoxRestaurant extends StatefulWidget {

  final Function onTap;
  final String menuName;
  final String menuDescription;
  final String fixprice;
  // final String image;
  final String hugs;

  const MenuBoxRestaurant({Key key, this.onTap, this.menuName, this.menuDescription, this.fixprice, this.hugs}) : super(key: key);

 
  @override
  _MenuBoxRestaurantState createState() => _MenuBoxRestaurantState();
}

class _MenuBoxRestaurantState extends State<MenuBoxRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:140,
      decoration: BoxDecoration(
          gradient:  LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
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
                height: 80,
                width: 170,
                decoration: BoxDecoration(
                  color: Color(0xFF0C375B),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    topLeft: Radius.circular(20)
                  ),
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.menuName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      letterSpacing: 1,
                      fontFamily: 'Gilroy-ExtraBold'
                    ),
                    ),
                    SizedBox(height: 5,),
                    Text(widget.menuDescription,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontFamily: 'Gilroy-light'
                    ),
                    ),
                      ],
                    ),
                  ),
                
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 5,right: 20),
                child: Container(
                  height: 115,
                  width: 115,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("asset/img/image.jpg"),
                      fit: BoxFit.cover)
                  ),
                ),
                ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                  color:  Color(0xFF0C375B),
                  borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(20)
                  ),
                ),
                  child: Center(
                    child: Text(widget.fixprice,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontFamily: 'Gilroy-light'
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
                       width: 70,
                        height: 40,
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

            Align(
              alignment: Alignment.topRight,

                       child: Container(
                       width: 120,
                        height: 20,
                        decoration: BoxDecoration(  
                         borderRadius: BorderRadius.only(
                           topRight: Radius.circular(20),
                           bottomLeft: Radius.circular(10)
                         ),
                         color: Color(0xFF0C375B)),
                        child: Center(
                          child: Text(widget.hugs,
                          style: TextStyle(
                                color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: 'Gilroy-light'
                      ),
                          
                          ),
                        )
                        
                        ),
                       
            ),

          ],
        ),
      
    );
  }
}

